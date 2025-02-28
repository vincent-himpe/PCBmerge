{ -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

  Released under MIT Licenes   https://opensource.org/license/mit

  MIT License

  Copyright 2024 Vincent Himpe
  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
  files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy,
  modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
  Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
  IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


  v1.0  Original release
  v1.1  bugfix
  v1.2  Solved the issue where some components did not move. This is a threading problem.
        Operations did not wait for the robots to complete and sometimes there was a race condition.
        Added part details
        Added highlight
        Added AD<space> hotkeys to perform selection. (not implemented in pcb view yet) -future feature-
        <enter> executes selected line
  v1.21 additional display when a part is beingworked upon. 1.2 slowed down operations due to the required wait for thread compleation.
        This gives more detail on what is happening
        updated part information label formatting
        added information label
        bugfix in lockmode selection
  V2.0  Designator option and UI cleanup


 -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-}
var
  ComponentDesignatorArray: array [0..1000] of string;
  XCoordArray, YCoordArray, RotationArray: array  [0..1000] of Real;
  LayerArray: array  [0..1000] of TLayer;
  Lockstate: array [0..1000] of Boolean;
  SelectionState : array [0..1000] of Boolean;

  DesignatorX , DesignatorY, DesignatorRotation: array [0..1000] of real;
  DesignatorLayer: Array [0..1000] of Tlayer;
  Designatorstate: array[0..1000] of boolean;
  DesignatorOnly: Boolean;

  ComponentDesignator,q as string;
  I,J : Integer;
  Lockmode : integer;
  SelectedDesignator : integer;


// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- end program -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

procedure TPCBmerge.EndrunClick(Sender: TObject);
begin
     close;
end;

Procedure LockBehavior();
Begin
   If radiobutton1.Checked = true Then lockmode := 1;
   If radiobutton2.Checked = true Then lockmode := 2;
   If radiobutton3.Checked = true Then lockmode := 3;
   If radiobutton4.Checked = true Then lockmode := 4;
  {v1.21 fix radiobutton3->4}
End;

// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- Get component information -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

procedure TPCBmerge.GetComponentsClick(Sender: TObject);
var
    Board : IPCB_Board;
    Iterator : IPCB_GroupIterator;
    Component : IPCB_Component;

begin
    Board := PCBServer.GetCurrentPCBBoard;
    if Board = nil then
    begin
     label1.caption :='Select a board document first';
     Exit;
    end;

    Iterator := PCBServer.GetCurrentPCBBoard.BoardIterator_Create;
    Iterator.AddFilter_ObjectSet(MkSet(eComponentObject));
    iterator.addfilter_method(eprocessall);

    memo1.text :='';
    I:=0;
    Component := Iterator.FirstPCBObject;
    while (Component <> nil) do
    begin
        if component.selected = true then begin
           I := I+1;
           componentdesignator :=component.name.text;
           ComponentDesignatorArray[I] := componentdesignator;                   // store designator

           DesignatorX[I] := component.name.XLocation;
           DesignatorY[I] := component.name.YLocation;
           DesignatorRotation[I] := component.name.Rotation;
           designatorstate[I] :=component.name.ishidden;                                // store designator visibility

           XCoordArray[I] := Component.x;
           YCoordArray[I] := Component.y;
           RotationArray[I] := Component.Rotation;
           LayerArray[I] := Component.Layer;
           Lockstate[I] :=component.Moveable;

           if Component.moveable = true then
           memo1.text := memo1.text + '[ free ] '
           else memo1.text := memo1.text + '[locked] ';
           memo1.text := memo1.text + format ('%12d | %12d | ', [component.x,component.y ]);
           memo1.text := memo1.text + format ('%4s |',[vartostr(component.rotation)]);
           memo1.text := memo1.text + format ('%4s ||',[vartostr(component.layer)]);
           memo1.text := memo1.text + format ('%12d | %12d | ', [component.name.xlocation,component.name.ylocation ]);
           memo1.text := memo1.text + format ('%4s |',[vartostr(component.name.rotation)]);
           memo1.text := memo1.text + componentdesignator;
           memo1.text := memo1.text + #13#10;
        end;
        Component := Iterator.NextPCBObject;
    end;
    label1.caption := 'Component Count : ' +  IntToStr(i);
    LockBehavior;
    //Board.GroupIterator_Destroy(Iterator);
end;

// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- Restore components -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

procedure TPCBmerge.SetComponentsClick(Sender: TObject);
var
    Board : IPCB_Board;
    Iterator : IPCB_GroupIterator;
    Component : IPCB_Component;
    LocalLock : boolean;
    icounter : integer;
begin
    LockBehavior;
    icounter :=0;
    Board := PCBServer.GetCurrentPCBBoard;
    if Board = nil then
    begin
     label1.caption :='Select a board';
     Exit;
    end;
    setcomponents.enabled := false;
    Iterator := PCBServer.GetCurrentPCBBoard.BoardIterator_Create;
    Iterator.AddFilter_ObjectSet(MkSet(eComponentObject));
    iterator.addfilter_method(eprocessall);

    label1.caption :='Working';
    if i = 0 then exit;
    Component := Iterator.FirstPCBObject;
    while (Component <> nil) do
    begin
        ComponentDesignator := component.name.text;
        label1.caption := 'Skipping  ' + format('%6s',[ComponentDesignator]) + ' ('+ format('%4d',[icounter]) + ' of ' + format ('%4d',[i]) + ')';
        Application.ProcessMessages;
        for j := 1 to i do
        begin
           q := ComponentDesignatorArray[j];
           if q = ComponentDesignator then
           begin
              {v1.21 mod}
              icounter := icounter+1;
              label1.caption := 'Modifying ' + format('%6s',[ComponentDesignator]) + ' ('+ format('%4d',[icounter]) + ' of ' + format ('%4d',[i]) + ')';
              Application.ProcessMessages;

              {end v1.21 mod}
              {v1.2 / v1.21 mod}
              if checkbox3.Checked = true then begin
                 LocalLock := component.moveable;


                 if component.Moveable = false then begin  // don't do this blindly. it is slowing down   v1.21
                    PCBServer.SendMessageToRobots(Component.I_ObjectAddress, c_Broadcast, PCBM_BeginModify , c_NoEventData);
                    component.Moveable := true;
                    PCBServer.SendMessageToRobots(Component.I_ObjectAddress, c_Broadcast, PCBM_EndModify , c_NoEventData);
                    Application.ProcessMessages;
                 end;

                 if (component.x <> xcoordarray[j]) or (component.y <> ycoordarray[j]) then begin // don't do this blindly. it is slowing down   v1.21
                    PCBServer.SendMessageToRobots(Component.I_ObjectAddress, c_Broadcast, PCBM_BeginModify , c_NoEventData);
                    component.MoveToXY(xcoordarray[j],ycoordarray[j]);
                    PCBServer.SendMessageToRobots(Component.I_ObjectAddress, c_Broadcast, PCBM_EndModify , c_NoEventData);
                    Application.ProcessMessages;
                 end;

                 if component.rotation <> rotationarray[j] then begin   // don't do this blindly. it is slowing down v1.21
                    PCBServer.SendMessageToRobots(Component.I_ObjectAddress, c_Broadcast, PCBM_BeginModify , c_NoEventData);
                    Component.Rotation := RotationArray[j];
                    PCBServer.SendMessageToRobots(Component.I_ObjectAddress, c_Broadcast, PCBM_EndModify , c_NoEventData);
                    Application.ProcessMessages;
                 end;

                 if Component.Layer <> LayerArray[j]then begin // don't do this blindly. it is slowing down v1.21
                    PCBServer.SendMessageToRobots(Component.I_ObjectAddress, c_Broadcast, PCBM_BeginModify , c_NoEventData);
                    Component.Layer := LayerArray[j];
                    PCBServer.SendMessageToRobots(Component.I_ObjectAddress, c_Broadcast, PCBM_EndModify , c_NoEventData);
                    Application.ProcessMessages;
                 end;

                 {end v1.2 mod}
                 if lockmode = 1 then component.Moveable := lockstate[j];
                 if lockmode = 2 then component.Moveable := locallock;
                 if lockmode = 3 then component.moveable := false;
                 if lockmode = 4 then component.moveable := true;
              end;
              if checkbox4.Checked =true then begin
                 //PCBServer.SendMessageToRobots(Component.name.I_ObjectAddress, c_Broadcast, PCBM_BeginModify , c_NoEventData);
                 component.name.BeginModify;
                 component.Name.Moveable :=true;
                 component.name.endmodify;

                 // rotation need to be done FIRST as the origin is that of the enclosing rectangle. if text is rotated differently then the origin is different !
                 component.name.BeginModify;
                 component.name.rotation := DesignatorRotation[j] ;
                 component.name.endmodify;

                 component.name.BeginModify;
                 component.name.MoveToXY(designatorx[j],designatory[j]);
                 component.name.endmodify;

                 component.name.BeginModify;
                 component.NameOn := not(Designatorstate[j]);
                 component.name.endmodify;


                 //component.name.IsHidden :=false   ;
                 //component.nameon := designatorstate[I] ;
                 //component.Name.EndModify;
                 //PCBServer.SendMessageToRobots(Component.name.I_ObjectAddress, c_Broadcast, PCBM_EndModify , c_NoEventData);
                 //Application.ProcessMessages;

              end;
              //if lockpart.checked = true then component.Moveable := false;
           end;
        end;
        Component := Iterator.NextPCBObject;
    end;
    setcomponents.enabled := true;
    label1.caption := '... Altium DRC Cleanup in progress ... '     ;
    Application.processMessages;
     PCBServer.PostProcess;
     label1.caption := 'Done '
end;
 {v1.2 mod}
procedure UpdateComponentParameters( var idx :integer);
var
    Board : IPCB_Board;
    Iterator : IPCB_GroupIterator;
    Component : IPCB_Component;
    LocalLock : boolean;
begin
    LockBehavior;
    Board := PCBServer.GetCurrentPCBBoard;
    if Board = nil then
    begin
     label1.caption :='Select a board';
     Exit;
    end;
    setcomponents.enabled := false;
    Iterator := PCBServer.GetCurrentPCBBoard.BoardIterator_Create;
    Iterator.AddFilter_ObjectSet(MkSet(eComponentObject));
    iterator.addfilter_method(eprocessall);

    label1.caption :='Working';
    if i = 0 then exit;
    q := ComponentDesignatorArray[idx];
    Component := Iterator.FirstPCBObject;
    while (Component <> nil) do
    begin
        ComponentDesignator := component.name.text;
        if q = ComponentDesignator then
           begin

              LocalLock := component.moveable;
              if component.Moveable = false then component.Moveable := true;
              PCBServer.SendMessageToRobots(Component.I_ObjectAddress, c_Broadcast, PCBM_BeginModify , c_NoEventData);
              component.MoveToXY(xcoordarray[idx],ycoordarray[idx]);
              PCBServer.SendMessageToRobots(Component.I_ObjectAddress, c_Broadcast, PCBM_EndModify , c_NoEventData);

              PCBServer.SendMessageToRobots(Component.I_ObjectAddress, c_Broadcast, PCBM_BeginModify , c_NoEventData);
              Component.Layer := LayerArray[idx];
              PCBServer.SendMessageToRobots(Component.I_ObjectAddress, c_Broadcast, PCBM_EndModify , c_NoEventData);

              PCBServer.SendMessageToRobots(Component.I_ObjectAddress, c_Broadcast, PCBM_BeginModify , c_NoEventData);
              Component.Rotation := RotationArray[idx];
              PCBServer.SendMessageToRobots(Component.I_ObjectAddress, c_Broadcast, PCBM_EndModify , c_NoEventData);

              if lockmode = 1 then component.Moveable := lockstate[idx];
              if lockmode = 2 then component.Moveable := locallock;
              if lockmode = 3 then component.moveable := false;
              if lockmode = 4 then component.moveable := true;
           end;
        Component := Iterator.NextPCBObject;
    end;
    setcomponents.enabled := true;
    PCBServer.PostProcess;
    label1.caption := 'Done '
end;
  {end v1.2 mod}

   procedure SelectComponents( var idx :integer);
   end;





// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- debug routine -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

procedure ShowInfo;
var
    Board : IPCB_Board;
    Iterator : IPCB_GroupIterator;
    Component : IPCB_Component;
    XCoord, YCoord, Rotation : Real;
begin
    Board := PCBServer.GetCurrentPCBBoard;
    if Board = nil then Exit;

    Iterator := PCBServer.GetCurrentPCBBoard.BoardIterator_Create;
    Iterator.AddFilter_ObjectSet(MkSet(eComponentObject));
    iterator.addfilter_method(eprocessall);

    memo1.text :='';
    Component := Iterator.FirstPCBObject;
    while (Component <> nil) do
    begin
        XCoord := Component.x;
        YCoord := Component.y;
        Rotation := Component.Rotation;
        ComponentDesignator := component.name.text;
        if component.selected = true then begin
        memo1.text := memo1.text + ','+componentdesignator;
        end;
        Component := Iterator.NextPCBObject;
    end;

end;
procedure TPCBmerge.Button1Click(Sender: TObject);
begin
  showinfo;
end;

// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- Update info label -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
procedure ShowPartInformation;
begin
  if ComponentDesignatorArray[SelectedDesignator] <>'' then
  begin
     label2.Caption :=  format('%6s',[ComponentDesignatorArray[SelectedDesignator]])
     + ' | X: ' + format('%6s',[FloatToStr(CoordToMMs(XCoordArray[selecteddesignator]))]) +'mm'
     + ' | Y: ' + format('%6s',[floattostr(CoordToMMs(YCoordArray[selecteddesignator]))]) +'mm'
     + ' | R: ' + format('%3s',[vartostr(RotationArray[SelectedDesignator])])
     + ' | L: ' + format ('%4s',[vartostr(LayerArray[SelectedDesignator])])
     + ' |'
     ;
     if SelectionState[selecteddesignator] = true then
        label2.Caption := label2.Caption + ' *'
     else
        label2.Caption := label2.Caption + ' -'  ;
     end;
end;



{v1.2 mod}
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- Clickhandler for main text frame -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
procedure TPCBmerge.Memo1Click(Sender: TObject);
var
  CurrentLine: integer;
begin
  CurrentLine := Memo1.Perform(EM_LINEFROMCHAR, -1, 0);
  Memo1.SelStart := Memo1.Perform(EM_LINEINDEX, CurrentLine, 0);
  Memo1.SelLength := Length(Memo1.Lines[CurrentLine]);
  SelectedDesignator := currentline+1;
  ShowPartInformation;
end;

// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- Key handler for main text fram -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
procedure TPCBmerge.Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  CurrentLine: integer;
begin
  CurrentLine := Memo1.Perform(EM_LINEFROMCHAR, -1, 0);
  Memo1.SelStart := Memo1.Perform(EM_LINEINDEX, CurrentLine, 0);
  Memo1.SelLength := Length(Memo1.Lines[CurrentLine]);
  SelectedDesignator := currentline+1;
  if key = 65 then SelectionState[selecteddesignator] := true;  // (A)dd to Selection
  if key = 68 then SelectionState[selecteddesignator] := false; // (D)elete from selection
  if key = 32 then begin                                        // <space> : toggle selection
     if SelectionState[selecteddesignator] = false then
        SelectionState[selecteddesignator] := true
     else
        SelectionState[selecteddesignator] := false;
  end;
  if key = 13 then UpdateComponentParameters(selecteddesignator); // <enter> : execute change
  ShowPartInformation;
end;
{end v1.2 mod}


