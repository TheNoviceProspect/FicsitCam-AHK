#SingleInstance Force
#Hotstring NoMouse

Persistent

TLiniFile := A_ScriptDir "\TimelapseConfig.ini"

if not (FileExist(TLiniFile)) {
    IniWrite(0, TLiniFile, "TimelapseCams", "CamCount")
}

CamCount := IniRead(TLiniFile, "TimelapseCams", "CamCount")

SecondsPerFrame := 5
CamPrefix := "TLcam"

#HotIf WinActive("ahk_exe FactoryGame-Win64-Shipping.exe")
::tlc::
{
    CamCount := IniRead(TLiniFile, "TimelapseCams", "CamCount")
    SaveCams(CreateCam(CamCount))
}

::tls::
{
    CamCount := IniRead(TLiniFile, "TimelapseCams", "CamCount")
    StartCams(CamCount)
}

::tlf::
{
    CamCount := IniRead(TLiniFile, "TimelapseCams", "CamCount")
    StopCams(CamCount)
}

::tld::
{
    CamCount := IniRead(TLiniFile, "TimelapseCams", "CamCount")
    SaveCams(DeleteCams(CamCount))
}

::tll::
{
    ListCams()
}
#HotIf


CreateCam(x) {
    NewCount := x + 1
    Send "/fic timelapse create " CamPrefix NewCount " " SecondsPerFrame "{Enter}"
    return NewCount
}

StartCams(x) {
    loop x {
        Send "/fic timelapse start " CamPrefix A_Index "{Enter}"
        Sleep 1000
        if not (A_Index = x) {
            Send "{Enter}"
            Sleep 200
        }
    }
}

StopCams(x) {
    loop x {
        Send "/fic timelapse stop " CamPrefix A_Index "{Enter}"
        Sleep 1000
        if not (A_Index = x) {
            Send "{Enter}"
            Sleep 200
        }
    }
}

DeleteCams(x) {
    NewCount := x
    loop x {
        Send "/fic timelapse delete " CamPrefix A_Index "{Enter}"
        Sleep 1000
        if not (A_Index = x) {
            Send "{Enter}"
            Sleep 200
        }
        NewCount -= 1
    }
    return NewCount
}

ListCams() {
    Send "/fic timelapse list{Enter}"
}

SaveCams(x) {
    IniWrite(x, TLiniFile, "TimelapseCams", "CamCount")
}