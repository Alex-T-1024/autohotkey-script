#Requires AutoHotkey v2.0

#SingleInstance Force
HotIfWinActive "ahk_class Diablo IV Main Window Class"

StartFlag := false
StartFlag2 := false

F6::
{
    global StartFlag
    StartFlag := !StartFlag

    SetKeyDelay 25, 25

    if (StartFlag) {
        SetTimer Spam, 80
        SetTimer Spam2, 1000
        ;MsgBox "StartFlag is true"
        SoundBeep(1500)
    } else {
        SetTimer Spam, 0
        SetTimer Spam2, 0
        ;MsgBox "Stop timer"
        SoundBeep(1000)
    }
    ;MsgBox "End"
}

Spam() {
    state := GetKeyState("LButton", "P")
    if (state) {
        Sleep 1000
    } else {
        SendEvent "234{RButton}"
    }
}

Spam2() {
    state := GetKeyState("LButton", "P")
    if (state) {
        Sleep 1000
    } else {
        SendEvent "Q{LButton}"
    }
}

F7::
{
    global StartFlag2
    StartFlag2 := !StartFlag2

    SetKeyDelay 25, 25

    if (StartFlag2) {
        SetTimer OneKey, 300
        ;MsgBox "StartFlag is true"
        SoundBeep(15000)
    } else {
        SetTimer OneKey, 0
        ;MsgBox "Stop timer"
        SoundBeep(10000)
    }
    ;MsgBox "End"
}

OneKey() {
    SendEvent "{Space}"
}

^F12::
{
    ;MsgBox "Terminate All!"
    MsgBox "Not Working"
}
