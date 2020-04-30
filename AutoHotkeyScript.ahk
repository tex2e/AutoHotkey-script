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
F13 Up::Send, {vkF3sc029}  ; 全角半角キー
F13 & q::Send ^q
F13 & r::Send ^r
F13 & t::Send ^t
F13 & y::Send ^y
F13 & i::Send ^i
F13 & s::Send ^s
F13 & g::Send ^g
F13 & l::Send ^l
F13 & z::Send ^z
F13 & x::Send ^x
F13 & c::Send ^c
F13 & v::Send ^v
F13 & LButton::Send ^{LButton}
F13 & Left::Send ^{Left}
F13 & Right::Send ^{Right}


;;
;; カスタムキーバインド
;;
F13 & Tab::AltTab               ; CapsLock+Tab でウィンドウ切り替え
F13 & w::Send ^{Left}+^{Right}  ; CapsLock+w で単語選択
;;
;; プログラム起動のショートカット
;;
#n::Run, Notepad.exe
#c::Run, cmd.exe, %A_MyDocuments%
!#c::Run, powershell.exe, %A_MyDocuments%


;;
;; MacOSのキーボード風の入力切替
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


;;
;; Emacs風のキー入力
;;
F13 & f::Send,{Right}      ; forward_char
F13 & p::Send,{Up}         ; previous_line (emacs)
F13 & k::Send,{Up}         ; previous_line (vim)
F13 & n::Send,{Down}       ; next_line (emacs)
F13 & j::Send,{Down}       ; next_line (vim)
F13 & b::Send,{Left}       ; backward_char
F13 & a::Send,{HOME}       ; move_beginning_of_line
F13 & e::Send,{END}        ; move_end_of_line
F13 & d::Send,{Del}        ; delete_char
F13 & h::Send,{BS}         ; delete_backward_char
F13 & o::Send,{END}{Enter} ; open_line
F13 & m::Send,{Enter}      ; newline
F13 & u::^z                ; undo


;;
;; ウィンドウの切り替え
;;   CapsLock & Shift & 1 で、現在アクティブのウィンドウを記憶
;;   CapsLock & 1 で記憶したウィンドウをアクティブ化
;;
captureOrActive(ByRef id) {
  if GetKeyState("shift", "P") {
    WinGet, id, ID, A
  } else {
    WinActivate, ahk_id %id%
  }
  return
}
F13 & 1::captureOrActive(id1)
F13 & 2::captureOrActive(id2)
F13 & 3::captureOrActive(id3)
F13 & 4::captureOrActive(id4)
F13 & 5::captureOrActive(id5)
