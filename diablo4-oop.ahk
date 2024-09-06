#Requires AutoHotkey v2.0
#SingleInstance Force

SetKeyDelay 30, 40

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
        if (this.StartFlag) {
            this.Stop()
        } else {
            this.Start()
        }
    }
}

AttackSpam() {
    State := GetKeyState("LButton", "P")
    if (State) {
        Sleep 1000
    } else {
        SendEvent "234{RButton}"
    }
}

PotionSpam() {
    State := GetKeyState("LButton", "P")
    if (State) {
        Sleep 1000
    } else {
        SendEvent "Q{LButton}"
    }
}

SpaceSpam() {
    SendEvent "{Space}"
}

AutoAtk := AutoSpam(AttackSpam, 150)
AutoPotion := AutoSpam(PotionSpam, 3500)
AutoSpace := AutoSpam(SpaceSpam, 300)

F6::
{
    AutoAtk.Toggle
    AutoPotion.Toggle
}

F7::
{
    AutoSpace.Toggle
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
