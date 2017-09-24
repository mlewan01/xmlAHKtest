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