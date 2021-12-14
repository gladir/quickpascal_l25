Program L25;

Uses Crt,MSGraph;

Label
 Gagne,10,20,13,560;
Const
 StartX=115;
Var
 XPosition:Byte;
 YPosition:Byte;
 A,B:Byte;
 Erreur:Integer;
 TypeCase:Byte;
 Quitte:Boolean;
 Nombre:Byte;
 TableauL25:Packed Array[1..5,1..5] of Byte;
 TableauCase:Packed Array[0..2000] of Byte;
 Touche:Word;

 Procedure AfficheCase(XPosition,YPosition,Couleur:Byte);Begin
  If((Couleur=0)and(((XPosition + YPosition * 5) Mod 2)=0))Then Couleur := 3;
  _SetColor(Couleur);
  _Ellipse(_GFillInterior,StartX+3+16*XPosition,53+16*YPosition,StartX+12+16*XPosition,62+16*YPosition);
 End;

BEGIN { Main L 2 5 }
 Erreur:=_SetVideoMode(_MRes16Color);
 For A := 1 to 5 do For B := 1 to 5 do TableauL25[A,B] := 0;
 _SetTextPosition(1,16);
 _SetColor(5);
 _OutText('L 2 5');
 TypeCase := 0;
 For XPosition := 0 to 4 do Begin
  For YPosition := 0 to 4 do Begin
   If(TypeCase=0)Then Begin
    _SetColor(3);
    _Rectangle(3,StartX+XPosition*16,50+YPosition*16,StartX+15+XPosition*16,65+YPosition*16);
    _SetColor(1);
    _Rectangle(2,StartX+XPosition*16,50+YPosition*16,StartX+15+XPosition*16,65+YPosition*16);
   End
    else
   Begin
    _SetColor(0);
    _Rectangle(3,StartX+XPosition*16,50+YPosition*16,StartX+15+XPosition*16,65+YPosition*16);
   End;
   TypeCase := (TypeCase + 1) and 1;
  End;
 End;
 Quitte:=False;
 XPosition:=0;
 YPosition:=0;
 Nombre:=1;
 A:=0;
 B:=0;
 TableauL25[1,1]:=1;
 TypeCase:=0;
 AfficheCase(0,0,1);
 Repeat
  Repeat
   _GetImage(StartX+XPosition*16,50+YPosition*16,StartX+15+XPosition*16,65+YPosition*16,TableauCase);
   Erreur:=0;
   Repeat
    Erreur := (Erreur + 1) and $FFF;
    If(Erreur=1)Then Begin
     _PutImage(StartX+XPosition*16,50+YPosition*16,TableauCase,_GPreset);
    End;
    If(Erreur=$8FF)Then Begin
     _PutImage(StartX+XPosition*16,50+YPosition*16,TableauCase,_GPset);
    End;
    If((TypeCase > 0)and(Erreur=$FFF))Then Begin
     Inc(TypeCase);
     If(TypeCase=6)Then Begin
      TypeCase := 0;
     End;
    End;
   Until KeyPressed;
   Touche:=Byte(ReadKey);
   If Touche=0 Then Touche:=Byte(ReadKey) shl 8;
   _PutImage(StartX+XPosition*16,50+YPosition*16,TableauCase,_GPset);
   TypeCase:=1;
   Case Hi(Touche) of
    72: If(YPosition>0)Then Dec(YPosition) else YPosition := 4;
    75: If(XPosition>0)Then Dec(XPosition) else XPosition := 4;
    77: If(XPosition<4)Then Inc(XPosition) else XPosition := 0;
    80: If(YPosition<4)Then Inc(YPosition) else YPosition := 0;
   End;
   If(Lo(Touche)=27)Then Begin
    _SetTextPosition(24,1);
    _SetColor(5);
    _OutText('Vous avez abandonne!');
    Halt(0);
   End;
13:If(Lo(Touche)=13)Then Begin
    If(TableauL25[XPosition+1,YPosition+1]=1)Then Touche := 0;
    If Not((((A+1=XPosition+1-1)or(A+1=XPosition+1+1))and((B+1=YPosition+1-2)or(B+1=YPosition+1+2)))or
   (((A+1=XPosition+1-2)or(A+1=XPosition+1+2))and((B+1=YPosition+1-1)or(B+1=YPosition+1+1))))Then Touche := 0;
   End;
  Until Lo(Touche) = 13;
  If((XPosition+1=1)and(YPosition+1=1)AND(TableauL25[2,3]=1)AND(TableauL25[3,2]=1))Then Goto 560;
  If((XPosition+1=1)and(YPosition+1=2)AND(TableauL25[3,1]=1)AND(TableauL25[3,3]=1)AND(TableauL25[2,4]=1))THEN Goto 560;
  If((XPosition+1=1)and(YPosition+1=3)AND(TableauL25[2,1]=1)AND(TableauL25[2,5]=1)AND
    (TableauL25[3,2]=1)AND(TableauL25[3,4]=1))THEN Goto 560;
  If((XPosition+1=1)and(YPosition+1=4)AND(TableauL25[2,2]=1)AND(TableauL25[3,3]=1)AND
    (TableauL25[3,5]=1))THEN Goto 560;
  If((XPosition+1=1)and(YPosition+1=5)AND(TableauL25[2,3]=1)AND(TableauL25[3,4]=1))THEN Goto 560;
  If((XPosition+1=2)and(YPosition+1=1)AND(TableauL25[1,3]=1)AND(TableauL25[3,3]=1)AND
  (TableauL25[4,2]=1))Then Goto 560;
  If((XPosition+1=2)and(YPosition+1=2)AND(TableauL25[1,4]=1)AND(TableauL25[3,4]=1)AND
  (TableauL25[4,1]=1)AND(TableauL25[4,3]=1))Then Goto 560;
  If((XPosition+1=2)and(YPosition+1=3)AND(TableauL25[1,1]=1)AND(TableauL25[1,5]=1)AND
  (TableauL25[3,1]=1)AND(TableauL25[3,5]=1)AND(TableauL25[4,2]=1)AND(TableauL25[4,4]=1))THEN Goto 560;
  If((XPosition+1=2)and(YPosition+1=4)AND(TableauL25[1,2]=1)AND(TableauL25[3,2]=1)AND
  (TableauL25[4,3]=1)AND(TableauL25[4,5]=1))Then Goto 560;
  If((XPosition+1=2)and(YPosition+1=5)AND(TableauL25[1,3]=1)AND(TableauL25[3,3]=1)AND
  (TableauL25[4,4]=1))Then Goto 560;
  If((XPosition+1=3)and(YPosition+1=1)AND(TableauL25[1,2]=1)AND(TableauL25[2,3]=1)AND
  (TableauL25[4,3]=1)AND(TableauL25[5,2]=1))Then Goto 560;
  If((XPosition+1=3)and(YPosition+1=2)AND(TableauL25[1,1]=1)AND(TableauL25[1,3]=1)AND
  (TableauL25[2,4]=1)AND(TableauL25[4,4]=1)AND(TableauL25[5,1]=1)AND(TableauL25[5,3]=1))THEN Goto 560;
  If((XPosition+1=3)and(YPosition+1=3)AND(TableauL25[1,2]=1)AND(TableauL25[1,4]=1)AND
    (TableauL25[2,1]=1)AND(TableauL25[2,5]=1)AND(TableauL25[4,1]=1)AND
    (TableauL25[4,5]=1)AND(TableauL25[5,2]=1)AND(TableauL25[5,4]=1))THEN Goto 560;
  If((XPosition+1=3)and(YPosition+1=4)AND(TableauL25[1,3]=1)AND(TableauL25[1,5]=1)AND
  (TableauL25[2,2]=1)AND(TableauL25[4,2]=1)AND(TableauL25[5,3]=1)AND(TableauL25[5,5]=1))THEN Goto 560;
  If((XPosition+1=3)and(YPosition+1=5)AND(TableauL25[1,4]=1)AND(TableauL25[2,3]=1)AND
  (TableauL25[4,3]=1)AND(TableauL25[5,4]=1))THEN Goto 560;
  If((XPosition+1=4)and(YPosition+1=1)AND(TableauL25[2,2]=1)AND(TableauL25[3,3]=1)AND
  (TableauL25[5,3]=1))Then Goto 560;
  If((XPosition+1=4)and(YPosition+1=2)AND(TableauL25[2,1]=1)AND(TableauL25[2,3]=1)AND
  (TableauL25[3,4]=1)AND(TableauL25[5,4]=1))THEN Goto 560;
  If((XPosition+1=4)and(YPosition+1=3)AND(TableauL25[2,2]=1)AND(TableauL25[2,4]=1)AND
  (TableauL25[3,1]=1)AND(TableauL25[3,5]=1)AND(TableauL25[5,1]=1)AND(TableauL25[5,5]=1))THEN Goto 560;
  If((XPosition+1=4)and(YPosition+1=4)AND(TableauL25[2,3]=1)AND(TableauL25[2,5]=1)AND
  (TableauL25[3,2]=1)AND(TableauL25[5,2]=1))THEN Goto 560;
  If((XPosition+1=4)and(YPosition+1=5)AND(TableauL25[2,4]=1)AND(TableauL25[3,3]=1)AND
  (TableauL25[5,3]=1))Then Goto 560;
  If((XPosition+1=5)and(YPosition+1=1)AND(TableauL25[3,2]=1)AND(TableauL25[4,3]=1))THEN Goto 560;
  If((XPosition+1=5)and(YPosition+1=2)AND(TableauL25[3,1]=1)AND(TableauL25[3,3]=1)AND
  (TableauL25[4,4]=1))Then Goto 560;
  If((XPosition+1=5)and(YPosition+1=3)AND(TableauL25[3,2]=1)AND(TableauL25[3,4]=1)AND
  (TableauL25[4,1]=1)AND(TableauL25[4,5]=1))THEN Goto 560;
  If((XPosition+1=5)and(YPosition+1=4)AND(TableauL25[3,3]=1)AND(TableauL25[3,5]=1)AND
  (TableauL25[4,2]=1))Then Goto 560;
  If((XPosition+1=5)and(YPosition+1=5)AND(TableauL25[3,4]=1)AND(TableauL25[4,3]=1))Then Goto 560;
  Inc(Nombre);
  AfficheCase(A,B,1);
  AfficheCase(XPosition,YPosition,2);
  TableauL25[XPosition+1,YPosition+1] := 1;
  A := XPosition;
  B := YPosition;
  IF(Nombre>24)Then Begin
Gagne:
   _SetTextPosition(24,1);
   _SetColor(5);
   _OutText('Tu as gagner!');
   Halt(1);
  End;
 Until (Quitte);
560:
 AfficheCase(A,B,1);
 AfficheCase(XPosition,YPosition,2);
 If(Nombre = 24)Then Goto Gagne;
 _SetTextPosition(24,1);
 _SetColor(5);
 _OutText('Vous avez perdue.');
END.