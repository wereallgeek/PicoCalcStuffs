' PicoCalc MOD Player by @Guidouil
Dim fname$(128,2)
fcount=0
sel=0:wl=16:id=0
black=RGB(0,0,0)
w=MM.HRES
h=MM.VRES
green=RGB(0,255,0)
grey=RGB(80,80,80)

Function fsz(f$)
 If Dir$(f$)="" Then
  fsz=0
  Exit Function
 EndIf
 Open f$ For input As #1
  fsz=Lof(#1)
 Close #1
End Function

intro()
modpath$ = "b:/mod/"
listfiles()
filesview()

Sub listfiles()
'list mod files & size
file$=Dir$(modpath$ + "*.mod",FILE)
Do While file$ <> "" And fcount<128
 If Left$(file$,1) <> "." Then
  fname$(fcount,0)=file$
  fcount=fcount+1
 EndIf
 file$=Dir$()
Loop
If fcount>0 Then
 For i=0 To fcount-1
  sz=Int(fsz(modpath$ + fname$(i,0))/1024)
  fname$(i,1)=Str$(sz)
 Next i
EndIf
End Sub

Sub filesview()
CLS black
If fcount=0 Then
 CLS green
 Color black,green
 Font 8,4
 Text 160,160,"404: NO MOD FOUND",c
 Do
  If Inkey$<>"" Then CLS :End
 Loop
Else
'show mod files
Do
 'window
 Font 8,4
 fht=MM.Info(fontheight)
 Box 0,0,w,fht+10,2,green,grey
 Color green,grey
 Text w/2,6,"PicoCalc MOD Player",c
 Box 0,fht+10,w,h,1,green
 Font 8,2
 Color black,green
 Box 0,h-13,w,13,1,green,green
 Text w/2,h-11,"ESC : Quit      ENTER or RIGHT : Play",c
 k$=Inkey$
 ' ESC
 If k$=Chr$(27) Or k$="q" Then
  CLS black
  End
 EndIf
 If fcount<wl Then wl=fcount
 For i=id To Min(fcount-1,id+wl)
  If (fname$(i,0)<>"") Then
  Font 7,2
  fh=MM.Info(fontheight)
  Color green,black
  If i=sel Then
   Color black,green
  End If
  sho$=fname$(i,0)
  If Len(sho$)>22 Then
   sho$=Left$(sho$,22)
  EndIf
  Text 2,(i-id)*(fh+1)+36,sho$
  Text 318,(i-id)*(fh+1)+36,fname$(i,1)+"K",r
 EndIf
 Next i
 ' DOWN
 If k$=Chr$(129) And sel<(fcount-1) Then
  sel=sel+1
  If sel>wl Then
   id=id+1
   Box 0,fht+10,w,h,1,green,black
  EndIf
 EndIf
 ' UP
 If k$=Chr$(128) And sel>0 Then
  sel=sel-1
  If sel<id Then
   id=id-1
   Box 0,toph,w,h,1,green,black
  EndIf
 EndIf
 ' ENTER or RIGHT
 If k$=Chr$(13) Or k$=Chr$(131) Then
  playerview(fname$(sel,0), fname$(sel,1))
 EndIf

Loop
End If
End Sub ' filesview end

Sub playerview(f$,s$)
 If Val(s$)>192 Then
  CLS green
  Color black,green
  Font 7,3
  Text 160,140,s$+"K > 192K",c
  Text 160,180,"FILE TOO BIG ",c
  Pause 1500
  Exit Sub
 EndIf
 ' now playing
 mute(0)
 Play modfile modpath$ + f$
 Timer =0
 playing=1
 CLS black
 Font 8,3
 Color green,black
 Text 160,10,"Now Playing:",c
 Font 7,2
 Text 160,30,f$+" "+s$+"K",c
 Font 7,1
 fh=MM.Info(fontheight)
 Box 60,70,200,fh*6,1,green
 Text 66,75,"ESC or LEFT : Back To List"
 Text 66,85,"ENTER : Play / Pause"
 Text 66,95,"MINUS (-) : Mute / Unmute"
 Text 66,105,"Keys 1 to C : Sample 1 to 32"
 showbat()
 Do
  If playing=1 Then
   Font 7,2
   Text 160,50,Str$(Int(Timer/1000))+"s",c
  EndIf
  k$=Inkey$
  ' ESC or LEFT
  If k$=Chr$(27) Or k$=Chr$(130) Then
   Play stop
   CLS
   Exit Sub
  EndIf
  ' ENTER
  If k$=Chr$(13) Then
   Font 7,1
   fh=MM.Info(fontheight)
   If playing=1 Then
    p=Timer
    Play pause
    playing=0
    Text w,h-fh,"PAUSE",r
   Else
    Timer =p
    Play resume
    playing=1
    Text w,h-fh,"     ",r
   EndIf
  EndIf
  ' - minus
  If k$=Chr$(45) Then
   If muted = 0 Then
    mute(1)
   Else
    mute(0)
   EndIf
  EndIf
  ' play samples
  If playing=1 Then
   If k$="1" Then playsamp(1,1,"1")
   If k$="2" Then playsamp(2,2,"2")
   If k$="3" Then playsamp(3,3,"3")
   If k$="4" Then playsamp(4,4,"4")
   If k$="5" Then playsamp(5,1,"5")
   If k$="6" Then playsamp(6,2,"6")
   If k$="7" Then playsamp(7,3,"7")
   If k$="8" Then playsamp(8,4,"8")
   If k$="9" Then playsamp(9,1,"9")
   If k$="0" Then playsamp(10,3,"0")
   If k$="q" Then playsamp(11,4,"Q")
   If k$="w" Then playsamp(12,1,"W")
   If k$="e" Then playsamp(13,2,"E")
   If k$="r" Then playsamp(14,3,"R")
   If k$="t" Then playsamp(15,4,"T")
   If k$="y" Then playsamp(16,1,"Y")
   If k$="u" Then playsamp(17,2,"U")
   If k$="i" Then playsamp(18,3,"I")
   If k$="o" Then playsamp(19,4,"O")
   If k$="p" Then playsamp(20,1,"P")
   If k$="a" Then playsamp(21,2,"A")
   If k$="s" Then playsamp(22,3,"S")
   If k$="d" Then playsamp(23,4,"D")
   If k$="f" Then playsamp(24,1,"F")
   If k$="g" Then playsamp(25,2,"G")
   If k$="h" Then playsamp(26,3,"H")
   If k$="j" Then playsamp(27,4,"J")
   If k$="k" Then playsamp(28,1,"K")
   If k$="l" Then playsamp(29,2,"L")
   If k$="z" Then playsamp(30,3,"Z")
   If k$="x" Then playsamp(31,4,"X")
   If k$="c" Then playsamp(32,1,"C")
  EndIf
 Loop
End Sub

Sub playsamp(sp%,ch%,key$)
 muting=0
 If muted=1 Then mute(0):muting=1
 Play modsample sp%,ch%,64
 Font 5,6
 fh=MM.Info(fontheight)
 Text w/2,h-fh,key$,c
 Pause 250
 Text w/2,h-fh,"  ",c
 If muting=1 Then Pause 250:mute(1)
 showbat()
End Sub

Sub mute(state)
 Font 7,1
 fh=MM.Info(fontheight)
 If state=0 Then
  Play volume 100,100
  muted=0
  Text 0,h-fh,"    "
 Else
  Play volume 0,0
  muted=1
  Text 0,h-fh,"MUTE"
 EndIf
End Sub

Sub showbat()
 Font 7,1
 bat$=Str$(MM.Info(battery))+"%"
 Text w,0,bat$,r
End Sub

Sub intro()
 Font 8,4
 fh=MM.Info(fontheight)
 Box 0,0,w,fh+10,2,green,grey
 Color green,grey
 Text w/2,6,"PicoCalc MOD Player",c
 Color green,black
 Text w/2,h/2,"LOADING...",c
 Font 8,2
 fh=MM.Info(fontheight)
 Text w/2,h-fh,"v0.1 made by Guidouil",c
End Sub
