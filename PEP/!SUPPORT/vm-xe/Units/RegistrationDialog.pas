Unit RegistrationDialog;



Interface
Uses PlatformConsts;



Function ShowNagScreen(var AUserName, AUserKey: TConstWString):Int64;





Implementation
Uses  Winapi.Windows, Winapi.Messages, Licensing;




function ShellExecuteW(hWnd: HWND; Operation, FileName, Parameters,
          Directory: LPWSTR; ShowCmd: Integer): HINST; stdcall;
          external 'shell32.dll' name 'ShellExecuteW';



Const
 con_Button : TConstWString = 'Button';
 con_Static : TConstWString = 'Static';
 con_Edit   : TConstWString = 'Edit';





// [NAG USED]
Var
 hbrEditBg : HBRUSH;
 nagHandle, Bevel1, lblLid, lblKey, eLicenseID, hFont : HWND;
 eDemo, btnKey, btnOrder, btnTry, eKey : HWND;


Var
 btnTryX : Integer;
 deltaH  : Integer;
 DialogResult : Int64;
 DialogName, DialogKey : TConstWString;
 WaitAKey : Boolean = False;
 DelayElapsed : Integer;


Const
 FormWidth  = 423;
 FormHeight = 360;


Var
  WinClass : TWNDCLASSEXW;
  wnd_class_name  : TConstWString;


Var
 pclRed : Cardinal = $0000FF;
 pclBg  : Cardinal = 2368548;
 pclSky : Cardinal = $F0CAA6;



{===============================PROCEDURE==================================}

Function NagWindowProc(hwnd, msg, wparam, lparam: longint): longint; stdcall;
Var
 I : Integer;
Begin
 Result := DefWindowProcW(hwnd, msg, wparam, lparam);
 case Msg of
  WM_COMMAND:
   Begin
    if (lParam = btnKey) and (HiWord(wParam) = BN_CLICKED) then
      begin
       //OnClick  btnKey
       ShowWindow(btnKey, SW_HIDE);
       UpdateWindow(nagHandle);
       I:=0;
       while I<= deltaH Do
        begin
         SetWindowPos(Bevel1, 0, 0, 290-deltaH+I, -1, -1, SWP_NOSIZE);

         SetWindowPos(btnTry, 0, btnTryX, 299-deltaH+I, -1, -1, SWP_NOSIZE);
         SetWindowPos(btnOrder, 0, 308, 299-deltaH+I, -1, -1, SWP_NOSIZE);

         SetWindowPos(nagHandle, 0, -1, -1, FormWidth, FormHeight-deltaH+I, SWP_NOMOVE);

         UpdateWindow(nagHandle);
         Inc(I, 2);
         Sleep(1);
        end;
       ShowWindow(lblKey, SW_SHOW);
       ShowWindow(eKey, SW_SHOW);

       SetWindowTextW(lblLid, PWideChar(Statica.VarW[1,9]));
       SendMessage(eLicenseID,EM_SETREADONLY,0,0);
       SetWindowLong(eLicenseID,GWL_STYLE,WS_CHILD or ES_AUTOHSCROLL or ES_LEFT or WS_VISIBLE);
       SetWindowTextW(eLicenseID, PWideChar(''));
       WaitAKey:=True;

       UpdateWindow(nagHandle);
       SetFocus(eLicenseID);
      end
    else
    if (lParam = btnTry) and (HiWord(wParam) = BN_CLICKED) then
      begin
       If WaitAKey Then
        begin
         DialogResult:=1;
         SetLength(DialogKey, 4096);
         I:=GetWindowTextW(eKey, PWideChar(DialogKey), Length(DialogKey));
         SetLength(DialogKey, I);

         SetLength(DialogName, 4096);
         I:=GetWindowTextW(eLicenseID, PWideChar(DialogName), Length(DialogName));
         SetLength(DialogName, I);
        end;

       if (DialogName='') and (DialogKey='') Then DialogResult:=-1;
       ShowWindow(nagHandle, SW_HIDE);
       DestroyWindow(hwnd);
      end
    else
    if (lParam = btnOrder) and (HiWord(wParam) = BN_CLICKED) then
      begin
       ShellExecuteW(nagHandle, PWideChar('open'), PWideChar(Statica.VarW[0,3]), nil, nil, 0);
      end;
   End;



   WM_CTLCOLORSTATIC:
    begin
     If (lParam=eLicenseID) or (lParam=eDemo) Then
      begin
       If lParam = eLicenseID Then SetTextColor(wParam, pclSky);
       If lParam = eDemo Then SetTextColor(wParam, pclRed);
       SetBkMode( wParam, OPAQUE );
       SetBkColor(wParam, pclBg);
       Result:=hbrEditBg;
      End;
    End;

   WM_CTLCOLOREDIT:
    begin
     If lParam = eKey Then SetTextColor(wParam, pclSky);
     If (WaitAKey) and  (lParam = eLicenseID) Then SetTextColor(wParam, pclSky);
     SetBkColor(wParam, pclBg);
     Result:=hbrEditBg;
    End;

   WM_TIMER:
    begin
     Inc(DelayElapsed);
     If DelayElapsed>=Statica.VarI64[1,14] Then
      begin
       EnableWindow(btnTry, True);
       SetWindowTextW(btnTry, PWideChar(Statica.VarW[1,7]));
      end
     Else
      begin
       EnableWindow(btnTry, False);
       SetWindowTextW(btnTry, PWideChar(Statica.VarW[1,7]+' ('+
                     IntToStr(Statica.VarI64[1,14]-DelayElapsed)+')'));
      end;

    end;

   WM_DESTROY:
    Begin
     PostQuitMessage(0);
    End;
  end;
end;

{===============================PROCEDURE==================================}

Function ShowNagScreen(var AUserName, AUserKey: TConstWString):Int64;
Var
 Msg   : TMSG;
 hInst : HMODULE;
 dxStyle : TConstDWord;
 hTimer : UINT;
Begin
 DialogResult:=-1;
 DialogName:='';
 DialogKey:='';
 AUserName:='';
 AUserKey:='';
 hInst := GetModuleHandle(nil);

 wnd_class_name:='p'+IntToStr(Abs(Random(MaxInt)));
 with WinClass do
  begin
   cbSize:=SizeOf(WinClass);
   Style := CS_PARENTDC or CS_DBLCLKS;
   hIcon := LoadIcon(0, nil);
   lpfnWndProc := @NagWindowProc;
   hInstance := hInst;
   hbrBackground := COLOR_BTNFACE + 1;
   lpszClassName := PWideChar(wnd_class_name);
   hCursor := LoadCursor(0, IDC_ARROW);
  end;
 RegisterClassExW(WinClass);

 pclBg:=Statica.VarC64[1,10];
 pclRed:=Statica.VarC64[1,11];
 pclSky:=pclRed;


 nagHandle := CreateWindowExW(WS_EX_WINDOWEDGE, PWideChar(wnd_class_name),
                              PWideChar(Statica.VarW[1,2]),
                              WS_CLIPSIBLINGS or WS_CAPTION or WS_BORDER or WS_DLGFRAME or
                              WS_GROUP ,
                              GetSystemMetrics( SM_CXSCREEN ) div 2 - FormWidth div 2,
                              GetSystemMetrics( SM_CYSCREEN ) div 2 - FormHeight div 2,
                              FormWidth, FormHeight, 0, 0, hInst, nil);
 hFont := CreateFontW(-11, 0, 0, 0, 0, 0, 0, 0,DEFAULT_CHARSET,
                      OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
                      DEFAULT_QUALITY, DEFAULT_PITCH or FF_DONTCARE, 'Segoe UI');
 If (hFont=0) Then
  hFont := CreateFontW(-11, 0, 0, 0, 0, 0, 0, 0,DEFAULT_CHARSET,
                       OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
                       DEFAULT_QUALITY, DEFAULT_PITCH or FF_DONTCARE, 'Arial');
 SendMessage(nagHandle, WM_SETFONT, hFont, 0);


 Bevel1 := CreateWindowExW(0,PWideChar(con_Static),PWideChar('') ,WS_CHILD or WS_VISIBLE or SS_SUNKEN,
                           0, 290, 418, 2, nagHandle, 0, hInst, nil);
 SendMessage(Bevel1, WM_SETFONT, hFont, 0);


 lblLid := CreateWindowW(PWideChar(con_Static),PWideChar(Statica.VarW[1,3]) ,
                         WS_CHILD or SS_NOTIFY or SS_LEFT or WS_VISIBLE,
                         8, 180, FormWidth-8, 14, nagHandle, 0, hInst, nil);
 SendMessage(lblLid, WM_SETFONT, hFont, 0);


 lblKey := CreateWindowW(PWideChar(con_Static),PWideChar(Statica.VarW[1,4]) ,
                         WS_CHILD or SS_NOTIFY or SS_LEFT or WS_VISIBLE,
                         8, 232, FormWidth-8, 14, nagHandle, 0, hInst, nil);
 SendMessage(lblKey, WM_SETFONT, hFont, 0);

 dxStyle:=WS_CHILD or ES_MULTILINE or ES_WANTRETURN or ES_READONLY or WS_VISIBLE;
 If (Statica.VarI64[1,13] = 1) Then dxStyle:=dxStyle or ES_LEFT Else
  dxStyle:=dxStyle or ES_CENTER;
 If (Statica.VarI64[1,12] = 1) Then dxStyle:=dxStyle or WS_VSCROLL;

 eDemo := CreateWindowExW(WS_EX_CLIENTEDGE, PWideChar(con_Edit), PWideChar(Statica.VarW[1,5]) ,
                          dxStyle or ES_AUTOVSCROLL,
                          8, 8, 401, 161, nagHandle, 0, hInst, nil);
 SendMessage(eDemo, WM_SETFONT, hFont, 0);


 btnKey := CreateWindowW(PWideChar(con_Button), PWideChar(Statica.VarW[1,6]), WS_CHILD or BS_TEXT or WS_VISIBLE or WS_TABSTOP,
                         8, 299, 135, 25, nagHandle, 0, hInst, nil);
 SendMessage(btnKey, WM_SETFONT, hFont, 0);


 btnOrder := CreateWindowW(PWideChar(con_Button), PWideChar(Statica.VarW[1,8]), WS_CHILD or BS_TEXT or WS_VISIBLE or WS_TABSTOP,
                           308, 299, 103, 25, nagHandle, 0, hInst, nil);
 SendMessage(btnOrder, WM_SETFONT, hFont, 0);


 btnTryX:=196;
 btnTry := CreateWindowW(PWideChar(con_Button), PWideChar(Statica.VarW[1,7]), WS_CHILD or BS_TEXT or WS_VISIBLE or WS_TABSTOP,
                         btnTryX, 299, 103, 25, nagHandle, 0, hInst, nil);
 SendMessage(btnTry, WM_SETFONT, hFont, 0);


 If Statica.VarW[0,3]='' Then // -> order page
  begin
   ShowWindow(btnOrder, SW_HIDE);
   btnTryX:=308;
   SetWindowPos(btnTry, 0, btnTryX, 299, -1, -1,  SWP_NOSIZE);
   UpdateWindow(nagHandle);
  End;

 eLicenseID := CreateWindowExW(WS_EX_CLIENTEDGE, PWideChar(con_Edit), PWideChar(ppiGetLicenseIDFmt),
                               WS_CHILD or ES_AUTOHSCROLL or ES_CENTER or WS_VISIBLE or ES_READONLY,
                               8, 198, 401, 22, nagHandle, 0, hInst, nil);
 SendMessage(eLicenseID, WM_SETFONT, hFont, 0);


 eKey := CreateWindowExW(WS_EX_CLIENTEDGE, PWideChar(con_Edit), PWideChar('') ,
                         WS_CHILD or ES_AUTOHSCROLL or WS_VISIBLE,
                         8, 250, 401, 22, nagHandle, 0, hInst, nil);
 SendMessage(eKey, WM_SETFONT, hFont, 0);


 ShowWindow(lblKey, SW_HIDE);
 ShowWindow(eKey, SW_HIDE);

 deltaH:= 290-232;
 SetWindowPos(Bevel1, 0, 0, 290-deltaH, -1, -1, SWP_NOSIZE);

 SetWindowPos(btnTry, 0, btnTryX, 299-deltaH, -1, -1, SWP_NOSIZE);
 SetWindowPos(btnKey, 0, 8, 299-deltaH, -1, -1, SWP_NOSIZE);
 SetWindowPos(btnOrder, 0, 308, 299-deltaH, -1, -1, SWP_NOSIZE);

 SetWindowPos(nagHandle, 0, -1, -1, FormWidth, FormHeight-deltaH, SWP_NOMOVE);


 hbrEditBg :=CreateSolidBrush(pclBg);
 hTimer:=0;
 If Statica.VarI64[1,14]>0 Then
  begin
   DelayElapsed:=0;
   hTimer:=SetTimer(nagHandle,7709077, 1000, nil);
   EnableWindow(btnTry, False);
   SetWindowTextW(btnTry, PWideChar(Statica.VarW[1,7]+' ('+
                  IntToStr(Statica.VarI64[1,14])+')'));
  end;



 ShowWindow(nagHandle, SW_SHOWNORMAL);
 UpdateWindow(nagHandle);
 InvalidateRect(nagHandle, nil, TRUE);


 while(GetMessage(Msg, 0, 0, 0)) do
  begin
   TranslateMessage(Msg);
   DispatchMessage(Msg);
  end;

 If hTimer<>0 Then KillTimer(nagHandle, 7709077);
 DeleteObject(hFont);
 DeleteObject(hbrEditBg);
 UnRegisterClassW(PWideChar(wnd_class_name), hInst);
 Result:=DialogResult;
 AUserKey:=Trim(DialogKey);
 AUserName:=Trim(DialogName);
End;

{===============================PROCEDURE==================================}



End.

