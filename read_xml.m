function xml_document = read_xml(filename)
DOMnode = xmlread(filename);
xml_document = XML.Document;
if DOMnode.hasChildNodes
    chiledNodes = DOMnode.getChildNodes;
    assert(chiledNodes.getLength==1);
    rootNode = chiledNodes.item(0);
    root_element = XML.Element(char(rootNode.getNodeName));
    root_element.parseElement(rootNode);
end
xml_document.RootElement = root_element;
end
