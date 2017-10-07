#SingleInstance force

Gui, Add, ListBox, gMyListBox vMyListBox x112 y9 w170 h450 , ; % tempBL ; ListBox
Gui, Add, Edit, vMyEdit x292 y9 w500 h440 ,  ; % tempX
Gui, Add, Button, x1 y8 w103 h42 gButtonOpen, Open xml
Gui, Add, Button, x1 y59 w103 h41 gButtonSave, Save
Gui, Show, w809 h465, mini XML editor GUI
return

ButtonSave:

GuiControlGet, ItemText, , MyListBox
GuiControl, +AltSubmit, MyListBox
GuiControlGet, ItemIndex, , MyListBox
GuiControl, -AltSubmit, MyListBox
GuiControlGet, editText, , MyEdit

xmlTextUpdate(oxml,ItemIndex-1,editText)

oxml.Save("xxxml.xml")
return

ButtonOpen:

;FileSelectFile, SelectedFile, 3, , Open a file, Text Documents (*.txt; *.xml)
GuiControl,, MyListBox, |
GuiControl,, MyEdit, % ""
SelectedFile = xmltest.xml
oxml := oXML_Create(SelectedFile)
nodesFormated := xmlFormatedNodes(oxml)
tempBL :=""
Loop % nodesFormated.MaxIndex() {
	tempBL = % tempBL . "|" . nodesFormated[A_Index]
}

GuiControl,, MyListBox, % tempBL

return

MyListBox:
GuiControlGet, ItemText, , MyListBox
GuiControl, +AltSubmit, MyListBox
GuiControlGet, ItemIndex, , MyListBox
GuiControl, -AltSubmit, MyListBox

temp := xmlNodeNumber(oxml, ItemIndex-1)
GuiControl,, MyEdit, % temp.text ;.xml for xme output
;MsgBox, 0, %MyListBox%, % trim(ItemText) . ItemIndex

return

GuiClose:
ExitApp

#z::
ExitApp

xmlNodeNumber(x,i){
; i: position in the list, first position == 1
; x: oxml object
; returns xml node number i-1
	;MsgBox % "i   : " . i . "`ntxt: " . txt
	j := 0
	Loop, % (node1:=x.selectNodes("*")).length {
		x1 := node1.item(A_index-1)
		if % i == j  {
			return x1
		}
		j++
		Loop, % (node2:=x1.selectNodes("*")).length {
			x2 := node2.item(A_index-1)
			if % i = j  {
				return x2
			}
			j++
			Loop, % (node3:=x2.selectNodes("*")).length {
				x3 := node3.item(A_index-1)
				if % i = j  {
					return x3
				}
				j++
				Loop, % (node4:=x3.selectNodes("*")).length {
					x4 := node4.item(A_index-1)
					if % i = j  {
						return x4
					}
					j++
				}
			}
		}
	}
}

xmlTextUpdate(x,i,txt){
; x: xml Object 
; i: position of the xml tag in the listBox to be replaced in the list of tags with txt
; txt: text to be replaced to
	;MsgBox % "i   : " . i . "`ntxt: " . txt
	j := 0
	nodes := Object()
	;MsgBox, 0, 18. length: , % (node1:=x.selectNodes("*")).length
	Loop, % (node1:=x.selectNodes("*")).length {
		x1 := node1.item((ii:=A_index)-1)
		
		;MsgBox,0, first layer, % x1.nodeName
		;MsgBox,0, 22. length: , % (node2:=x1.selectNodes("*")).length
		;nodes.Insert(x1) ; .nodeName)
		;x1.text := "dupa"
		;MsgBox % x1.text
		;x.Save("xxxml.xml")
		if % i == j  {
			;MsgBox % "text before change: `n" . x1.text
			x1.text := txt
			;MsgBox % "jej " . j . " i: " . i . "`nx1: " . x1.text 
		}
		j++
		Loop, % (node2:=x1.selectNodes("*")).length {
			x2 := node2.item(A_index-1)
			;MsgBox,0, second layer, % x2.nodeName
			;MsgBox,0, 27. length: , % (node3:=x2.selectNodes("*")).length
			;nodes.Insert(x2) ; "    " . x2.nodeName)
			if % i = j  {
				;MsgBox % "text before change: `n" . x2.text
				x2.text := txt
				;MsgBox % "jej " . j . " i: " . i .  "`nx2: " . x2.text 
			}
			j++
			Loop, % (node3:=x2.selectNodes("*")).length {
				x3 := node3.item(A_index-1)
				;MsgBox,0, third layer %A_index%, % x3.nodeName
				;nodes.Insert(x3) ; "        " . x3.nodeName)
				if % i = j  {
					;MsgBox % "text before change: `n" . x3.text
					x3.text := txt
					;MsgBox % "jej " . j . " i: " . i .  "`nx3: " . x3.text 
				}
				j++
				Loop, % (node4:=x3.selectNodes("*")).length {
					x4 := node4.item(A_index-1)
					;nodes.Insert(x4) ; "            " . x4.nodeName)
					;x4.text := "dupa"
					;x.Save("xxxml.xml")
					if % i = j  {
						;MsgBox % "text before change: `n" . x4.text
						x4.text := txt
						;MsgBox % "jej " . j . " i: " . i .  "`nx4: " . x4.text 
					}
					j++
					;MsgBox % "jej " . j . "`n xText: " . x4.text 
				}
			}
		}
	}
	;return nodes
}

oXML_Create(xmlpath) {
; xmlpath: path to file to be opened
; returns: xml Object
	FileRead, xml, %xmlpath%
	oXML := ComObjCreate("MSXML2.DOMDocument.6.0")
	oXML.async := False  
	oXML.setProperty("SelectionLanguage", "XPath")
	oXML.preserveWhiteSpace := true
	oXML.loadXML(xml)
	
	Return oXML
}

xmlFormatedNodes(x){
	nodes := Object()
	;MsgBox, 0, 18. length: , % (node1:=x.selectNodes("*")).length
	Loop, % (node1:=x.selectNodes("*")).length {
		x1 := node1.item((i:=A_index)-1)
		;MsgBox,0, first layer, % x1.nodeName
		;MsgBox,0, 22. length: , % (node2:=x1.selectNodes("*")).length
		nodes.Insert(x1.nodeName)
		Loop, % (node2:=x1.selectNodes("*")).length {
			x2 := node2.item(A_index-1)
			;MsgBox,0, second layer, % x2.nodeName
			;MsgBox,0, 27. length: , % (node3:=x2.selectNodes("*")).length
			nodes.Insert("    " . x2.nodeName)
			Loop, % (node3:=x2.selectNodes("*")).length {
				x3 := node3.item(A_index-1)
				;MsgBox,0, third layer %A_index%, % x3.nodeName
				nodes.Insert("        " . x3.nodeName)
				Loop, % (node4:=x3.selectNodes("*")).length {
					x4 := node4.item(A_index-1)
					nodes.Insert("            " . x4.nodeName)
				}
			}
		}
	}
	return nodes
}

xmlDomNodes(x){
	nodes := Object()
	;MsgBox, 0, 18. length: , % (node1:=x.selectNodes("*")).length
	Loop, % (node1:=x.selectNodes("*")).length {
		x1 := node1.item((i:=A_index)-1)
		;MsgBox,0, first layer, % x1.nodeName
		;MsgBox,0, 22. length: , % (node2:=x1.selectNodes("*")).length
		nodes.Insert(x1) ; .nodeName)
		Loop, % (node2:=x1.selectNodes("*")).length {
			x2 := node2.item(A_index-1)
			;MsgBox,0, second layer, % x2.nodeName
			;MsgBox,0, 27. length: , % (node3:=x2.selectNodes("*")).length
			nodes.Insert(x2) ; "    " . x2.nodeName)
			Loop, % (node3:=x2.selectNodes("*")).length {
				x3 := node3.item(A_index-1)
				;MsgBox,0, third layer %A_index%, % x3.nodeName
				nodes.Insert(x3) ; "        " . x3.nodeName)
				Loop, % (node4:=x3.selectNodes("*")).length {
					x4 := node4.item(A_index-1)
					nodes.Insert(x4) ; "            " . x4.nodeName)
				}
			}
		}
	}
	return nodes
}