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
F13 & w::Send ^w
F13 & r::Send ^r
F13 & t::Send ^t
F13 & y::Send ^y
F13 & s::Send ^s
F13 & l::Send ^l
F13 & z::Send ^z
F13 & x::Send ^x
F13 & c::Send ^c
F13 & v::Send ^v
F13 & LButton::Send ^{LButton}


;;
;; MacOSのキーボード風の入力切替
;;

; 無変換を押したときは、半角(IME off)
vk1C::
imeoff:
  Gosub, IMEGetstate
  If (vimestate=0)
  {
    Send, {vkf3}
  }
  return

; 変換を押したときは、全角(IME on)
vk1D::
imeon:
  Gosub, IMEGetstate
  If (vimestate=1)
  {
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
#InstallKeybdHook
#UseHook

; The following line is a contribution of NTEmacs wiki http://www49.atwiki.jp/ntemacs/pages/20.html
;SetKeyDelay 0

; Applications you want to disable emacs-like keybindings
; (Please comment out applications you don't use)
is_target()
{
  IfWinActive,ahk_class ConsoleWindowClass ; Cygwin
    Return 1
;  IfWinActive,ahk_class MEADOW ; Meadow
;    Return 1
  IfWinActive,ahk_class cygwin/x X rl-xterm-XTerm-0
    Return 1
  IfWinActive,ahk_class MozillaUIWindowClass ; keysnail on Firefox
    Return 1
  IfWinActive,ahk_class VMwareUnityHostWndClass ; VMwareUnity
    Return 1
  IfWinActive,ahk_class Vim ; GVIM
    Return 1
;  IfWinActive,ahk_class SWT_Window0 ; Eclipse
;    Return 1
;  IfWinActive,ahk_class Xming X
;    Return 1
;  IfWinActive,ahk_class SunAwtFrame
;    Return 1
;  IfWinActive,ahk_class Emacs ; NTEmacs
;    Return 1  
;  IfWinActive,ahk_class XEmacs ; XEmacs on Cygwin
;    Return 1
  Return 0
}

delete_char()
{
  Send {Del}
  Return
}
delete_backward_char()
{
  Send {BS}
  Return
}
open_line()
{
  Send {END}{Enter}
  Return
}
newline()
{
  Send {Enter}
  Return
}
move_beginning_of_line()
{
  Send {HOME}
  Return
}
move_end_of_line()
{
  Send {END}
  Return
}
previous_line()
{
  Send {Up}
  Return
}
next_line()
{
  Send {Down}
  Return
}
forward_char()
{
  Send {Right}
  Return
}
backward_char()
{
  Send {Left}
  Return
}


F13 & f::
  If is_target()
    Send %A_ThisHotkey%
  Else
    forward_char()
  Return
F13 & p::                     ; emacs-like
F13 & k::                     ; vim-like
  If is_target()
    Send %A_ThisHotkey%
  Else
    previous_line()
  Return
F13 & n::                     ; emacs-like
F13 & j::                     ; vim-like
  If is_target()
    Send %A_ThisHotkey%
  Else
    next_line()
  Return
F13 & b::
  If is_target()
    Send %A_ThisHotkey%
  Else
    backward_char()
  Return
F13 & a::
  If is_target()
    Send %A_ThisHotkey%
  Else
    move_beginning_of_line()
  Return
F13 & e::
  If is_target()
    Send %A_ThisHotkey%
  Else
    move_end_of_line()
  Return
F13 & d::
  If is_target()
    Send %A_ThisHotkey%
  Else
    delete_char()
  Return
F13 & h::
  If is_target()
    Send %A_ThisHotkey%
  Else
    delete_backward_char()
  Return
F13 & o::
  If is_target()
    Send %A_ThisHotkey%
  Else
    open_line()
  Return
F13 & m::
  If is_target()
    Send %A_ThisHotkey%
  Else
    newline()
  Return
