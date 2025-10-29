' keyb.bas - Keyboard testing
CLS
FRAMEBUFFER create
FRAMEBUFFER write f
Dim v0$(4)=("145","146","147","148","149")
Dim l0$(4)=("F1","F2","F3","F4","F5")
Dim v1$(4)=("27","9","","127","8")
Dim l1$(4)=("Esc","Tab","Cap","Del","Bck")
Dim l2$(6)=("`","/","\","-","=","[","]")
Dim l3$(9)=("1","2","3","4","5","6","7","8","9","0")
Dim l4$(9)=("Q","W","E","R","T","Y","U","I","O","P")
Dim l5$(8)=("A","S","D","F","G","H","J","K","L")
Dim l6$(8)=("Z","X","C","V","B","N","M",",",".")
Dim l7$(1)=(";","'")
Dim xl%(2)=(1,40,1)
Dim yl%(2)=(86,119,150)
Dim xr%(2)=(90,50,90)
Dim yr%(2)=(86,119,150)
Dim xu%(2)=(5,45,85)
Dim yu%(2)=(82,115,82)
Dim xd%(2)=(5,45,85)
Dim yd%(2)=(156,122,156)
g=RGB(0,255,0)
b=RGB(0,0,0)
Do
 k$=UCase$(Inkey$)
 darrow 149,130,xl%(), yl%(),15,119,k$
 darrow 148,131,xr%(), yr%(),75,119,k$
 darrow 146,128,xu%(), yu%(),46,97,k$
 darrow 147,129,xd%(), yd%(),46,144,k$
 dtopline v0$(),l0$(),4,82,k$,96
 dtopline v1$(),l1$(),4,106,k$,96
 dline l2$(),6,130,k$,96
 dline l3$(),9,162,k$
 dline l4$(),9,194,k$
 dline l5$(),8,226,k$
 dline l6$(),8,258,k$
 dline l7$(),1,290,k$,200
 dkey "En",Chr$(13),288,226,28,60,k$
 dkey "Space"," ",115,290,80,28,k$
 FRAMEBUFFER copy f,n
 'If k$=Chr$(27) Then CLS : End
 keycode = Asc(k$)
 If keycode <> 0 Then
  Print @(0,20) "keycode =      "
  Print @(80,20) keycode
 EndIf
Loop

Sub dline a$(),l%,h%,k$,m%
 For i=0 To l%
  Box i*32+m%,h%,28,28,1,g,b
  Text i*32+5+m%,h%+3,a$(i),,3
  If k$=a$(i) Then
   playkey Asc(a$(i))
   Box i*32+m%,h%,28,28,1,g,g
   Text i*32+5+m%,h%+3,a$(i),,3,,b,g
  EndIf
 Next
End Sub

Sub dtopline va$(),la$(),l%,h%,k$,m%
 For i=0 To l%
  Box i*45+m%,h%,40,20,1,g,b
  Text i*45+5+m%,h%+5,la$(i)
  If k$=Chr$(Val(va$(i))) Then
   playkey Asc(va$(i))
   Box i*45+m%,h%,40,20,1,g,g
   Text i*45+5+m%,h%+5,la$(i),,,,b,g
  EndIf
 Next
End Sub

Sub dkey la$,va$,x%,y%,w%,h%,k$
 Box x%,y%,w%,h%,1,g,b
 Text x%+5,y%+5,la$
 If k$=va$ Then
  playkey Asc(va$)
  Box x%,y%,w%,h%,1,g,g
  Text x%+5,y%+5,la$,,,,b,g
 EndIf
End Sub

Sub darrow la%,va%,xx%(),yy%(),x%,y%,k$
 Polygon 3,xx%(),yy%(),g,b
 Text x%,y%,Chr$(la%),cm,1,2
 If k$=Chr$(va%) Then
  playkey va%
  Polygon 3,xx%(),yy%(),g,g
  Text x%,y%,Chr$(la%),cm,1,2,b,g
 EndIf
End Sub

Sub playkey t%
 t%=t%*12
 Play tone t%,t%,100
End Sub
