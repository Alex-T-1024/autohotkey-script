#Requires AutoHotkey v2.0

#SingleInstance Force

StartFlag := false

F6::
{
    global StartFlag
    StartFlag := !StartFlag
    if (StartFlag) {
        SetTimer Spam, 80
        ;MsgBox "StartFlag is true"
    } else {
        SetTimer Spam, 0
        ;MsgBox "Stop timer"
    }
    ;MsgBox "End"
}

Spam() {
    SendInput "{Space}"
}
