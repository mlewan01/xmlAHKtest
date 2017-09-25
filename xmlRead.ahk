#z::
#SingleInstance force

;path = %A_ScriptDir%\xmltest.xml
;MsgBox %path%
FileRead, xml, xmltest.xml
oXML := ComObjCreate("MSXML2.DOMDocument")
oXML.setProperty("SelectionLanguage", "XPath")
oXML.LoadXML(xml)
;;; returns value of all the nodes inside it
xpObj := oXML.selectSingleNode("//breeze_systems_photobooth")
;;; node name: prints, value: 1
;xpObj := oXML.selectNodes("//prints[contains(.,'1')]")

MsgBox % xpObj.text
;displays nodes value
;MsgBox, % xpObj.item(0).text
;displays nodes tags and the value
;MsgBox, % xpObj.item(0).xml
MsgBox, % xpObj.xml
;MsgBox %xml%

;xpObj.item(0).text := "dupa"
;MsgBox, % xpObj.item(0).text

oXML_Create(xmlpath, xmldata=False) {
	if !xmldata {
		;default xml contents
		xmldata =
		(Ltrim
			<?xml version="1.0"?>
			<root>
			</root>
		)
	}
	
	oXML := ComObjCreate("MSXML2.DOMDocument")
	oXML.async := False  
	if (doc := oXML.loadXML(xmldata))
		doc.Save(xmlpath)
	else ; Could not load the xml file.
		Return False
	Return oXML
}


oXML_DeleteNode(ByRef oXML, NodeName, NumItem=0) {
	x := oXML.getElementsByTagName(NodeName).Item(NumItem)
	x.parentNode.removeChild(x)
}

oXML_AddNode(ByRef oXML, ParentNode, ChildNode, NumItem=0) {
	oNode := oXML.createElement(ChildNode)
	oXML.getElementsByTagName(ParentNode).Item(NumItem).appendChild(oNode)
}

oXML_InsertText(ByRef oXML, NodeName, text, NumItem=0) {
	x := oXML.getElementsByTagName(NodeName).Item(NumItem)
	x.appendChild(oXML.createTextNode(text))
}