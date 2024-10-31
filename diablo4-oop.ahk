#Requires AutoHotkey v2.0
#SingleInstance Force

SetKeyDelay 10, 10

AppClassName := "Diablo IV Main Window Class"

class AutoSpam {
    __New(Spam, Interval) {
        this.Func := Spam
    }
    StartFlag := false
    Interval := 100
    Func := () => {}

    Start() {
        this.StartFlag := true
        SetTimer this.Func, this.Interval
        ;MsgBox "StartFlag is true"
        SoundBeep(1000, 200)
    }

    Stop() {
        this.StopNoBeep
        SoundBeep(500, 200)
    }

    StopNoBeep() {
        this.StartFlag := false
        SetTimer this.Func, 0
        ;MsgBox "StartFlag is false"
    }

    Toggle() {
        this.CheckExist()
        if (this.StartFlag) {
            this.Stop()
        } else {
            this.Start()
        }
    }

    CheckExist() {
        global AppClassName
        ;MsgBox "Checking if app is running"
        if (WinExist("ahk_class" AppClassName) == 0) {
            ;MsgBox "App is not running, exiting"
            SoundBeep(300, 800)
            ExitApp
        }
        return true
    }
}

AttackSpam() {
    State := GetKeyState("LButton", "P")
    if (State) {
        Sleep 1000
    } else {
        SendEvent "1234{RButton}"
    }
}

PotionSpam() {
    State := GetKeyState("LButton", "P")
    if (State) {
        Sleep 1000
    } else {
        SendEvent "Q"
    }
}

SpaceSpam() {
    SendEvent "{Space}"
}

AutoAtk := AutoSpam(AttackSpam, 20)
AutoPotion := AutoSpam(PotionSpam, 9000)
AutoSpace := AutoSpam(SpaceSpam, 300)

F1::
{
    AutoAtk.Toggle
    ; AutoPotion.Toggle
}

F2::
{
    AutoSpace.Toggle
    AutoPotion.Toggle
}

Enter::
{
    SendEvent "{Enter}"
    AutoAtk.StopNoBeep
    AutoPotion.StopNoBeep
    AutoSpace.StopNoBeep
}

F12::
{
    ;MsgBox "Terminate All!"
    AutoAtk.StopNoBeep
    AutoPotion.StopNoBeep
    AutoSpace.StopNoBeep
    SoundBeep(500, 1000)
}
