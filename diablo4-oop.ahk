/*
Used for Diablo 4 to autocast
Features:
1. Automatically cast skills and/or drinking potion or evade
2. Stop autocasting while walking
3. Press shortcut when game is not running will exit ahk script
4. Automatically pause/resume keystrokes when you lose/get game focus
5. Only one scripting instance can be running simultaneously
5. You can change to other apps using `AppClassName` and define your own keystrokes
*/
#Requires AutoHotkey v2.0
#SingleInstance Force

SetKeyDelay 10, 10

AppClassName := "Diablo IV Main Window Class"

class AutoSpam {
    __New(Spam, Interval) {
        this.SpamFunc := Spam

        this.Timer := this.WrapFunc.Bind(this)
        ; or use below
        ; this.Timer := ObjBindMethod(this, "WrapFunc")
    }
    StartFlag := false
    Interval := 100
    SpamFunc := () => {}

    Start() {
        this.StartFlag := true
        SetTimer this.Timer, this.Interval
        ;MsgBox "StartFlag is true"
        SoundBeep(1000, 200)
    }

    Stop() {
        this.StopNoBeep
        SoundBeep(500, 200)
    }

    StopNoBeep() {
        this.StartFlag := false
        SetTimer this.Timer, 0
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

    IsActive() {
        ; result := WinActive("ahk_class" AppClassName)
        ; MsgBox result

        if (WinActive("ahk_class" AppClassName) == 0) {
            return false
        }
        return true
    }

    WrapFunc() {
        if (this.IsActive()) {
            this.SpamFunc.Call()
        } else {
            Sleep 2000
        }
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
