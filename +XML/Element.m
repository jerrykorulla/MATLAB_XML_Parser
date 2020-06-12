classdef Element < handle
    properties
        Tag
        Attributes
        Children
    end
    
    methods
        function obj=Element(tag)
            obj.Tag = tag;
        end
        
        function add_child(obj,child)
            if isempty(obj.Children)
                obj.Children = child;
            else
                obj.Children(end+1) = child;
            end
        end
        
        function add_attribute(obj,attribute)
            if isempty(obj.Attributes)
                obj.Attributes = attribute;
            else
                obj.Attributes(end+1) = attribute;
            end
        end
        
        function obj = parseElement(obj,theNode)
            if theNode.hasAttributes
                theAttributes = theNode.getAttributes;
                numAttributes = theAttributes.getLength;
                for count = 1:numAttributes
                    attribute = XML.Attribute;
                    attrib = theAttributes.item(count-1);
                    attribute.Name = char(attrib.getName);
                    attribute.Value = char(attrib.getValue);
                    obj.add_attribute(attribute);
                end
            end

            if theNode.hasChildNodes
                childNodes = theNode.getChildNodes;
                numChildNodes = childNodes.getLength;
                for count = 1:numChildNodes
                    theChild = childNodes.item(count-1);
                    tag = char(theChild.getNodeName);
                    if ~strcmp(tag,'#text')
                        child_node = XML.Element(tag);
                        child_node.parseElement(theChild);
                        obj.add_child(child_node);
                    else
                        text = strip(char(theChild.getData));
                        if ~isempty(text)
                            child_node = XML.Text;
                            child_node.Content = text;
                            obj.add_child(child_node);
                        end
                    end
                end
            end
        end
        
    end
end
