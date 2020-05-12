#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; 編集したらスタートアップに再登録する
; 1. AutoHotkeyScript.ahk を右クリックし、Compile Script を実行
; 2. win + R で「shell:startup」を入力
; 3. 常駐しているAutoHotkeyScriptの停止
; 4. AutoHotkeyScript.exe をスタートアップに移動


;;
;; CapsLockで入力切替とCtrlキーの役割
;;
F13 Up:: Send {vkF3sc029}  ; 全角半角キー
F13 & r:: ^r
F13 & t:: ^t
F13 & y:: ^y
F13 & i:: ^i
F13 & s:: ^s
F13 & g:: ^g
F13 & l:: ^l
F13 & z:: ^z
F13 & x:: ^x
F13 & c:: ^c
F13 & v:: ^v
F13 & LButton:: Send ^{LButton}
F13 & Left:: Send ^{Left}
F13 & Right:: Send ^{Right}

;;
;; カスタムマップ
;;
^#s::!PrintScreen  ; 左手だけでスクリーンショット

; 日付のリマップ
::ddd::
  FormatTime,TimeString,,yyyy/MM/dd
  Send,%TimeString%
  Return
::dd::
  FormatTime,TimeString,,M/d
  Send,%TimeString%
  Return

; プログラム起動のショートカット
#n:: Run, Notepad.exe                       ; Notepad
#c:: Run, cmd.exe, %A_MyDocuments%          ; cmd.exe
!#c:: Run, powershell.exe, %A_MyDocuments%  ; PowerShell
#q:: DllCall("PowrProf\SetSuspendState", "int", 0, "int", 1, "int", 0) ; スリープ


;;
;; MacOS風のキーボード操作
;;
; 無変換を押したときは、半角(IME off)
vk1C::
imeoff:
  Gosub, IMEGetstate
  If (vimestate=0) {
    Send, {vkf3}
  }
  return

; 変換を押したときは、全角(IME on)
vk1D::
imeon:
  Gosub, IMEGetstate
  If (vimestate=1) {
    Send, {vkf3}
  }
  return

IMEGetstate:
  WinGet, vcurrentwindow, ID, A
  vimestate := DllCall("user32.dll\SendMessageA", "UInt", DllCall("imm32.dll\ImmGetDefaultIMEWnd", "Uint", vcurrentwindow), "UInt", 0x0283, "Int", 0x0005, "Int", 0)
  return

F13 & k:: F7     ; Ctrl-kでカタカナに変換
F13 & j:: F6     ; Ctrl-jでひらがなに変換
F13 & Space:: #s ; Ctrl-SpaceでWindowsの検索ボックスを開く
^q:: WinClose,A  ; Command-qでアクティブウィンドウを閉じる


;;
;; Emacs風のキー入力
;;
F13 & f:: Right             ; forward_char
F13 & p:: Up                ; previous_line
F13 & n:: Down              ; next_line
F13 & b:: Left              ; backward_char
F13 & a:: HOME              ; move_beginning_of_line
F13 & e:: END               ; move_end_of_line
F13 & d:: Del               ; delete_char
F13 & h:: BS                ; delete_backward_char
F13 & o:: Send {END}{Enter} ; open_line
F13 & m:: Enter             ; newline
F13 & u:: ^z                ; undo
