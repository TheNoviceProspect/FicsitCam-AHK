#SingleInstance Force
#Hotstring NoMouse
Persistent

;; These values can be configured
SecondsPerFrame := 5
CamPrefix := "TLcam"
;; Only change below code if you understand what you are doing

; Here we store the amount of currently existing cameras
; If the file doesn't exist, it gets pre-populated with 0 cameras
TLiniFile := A_ScriptDir "\TimelapseConfig.ini"
if not (FileExist(TLiniFile)) {
    IniWrite(0, TLiniFile, "TimelapseCams", "CamCount")
}

; Now read the value from the initfile to CamCount
CamCount := IniRead(TLiniFile, "TimelapseCams", "CamCount")

;; These are the script commands that one triggers in-game
; Ensure these HotStriongs only work if Satisfactory is running
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

; Here we create a new camera and increase the amount of existing cameras (through return
CreateCam(x) {
    NewCount := x + 1
    Send "/fic timelapse create " CamPrefix NewCount " " SecondsPerFrame "{Enter}"
    return NewCount
}

; Loop through all cameras and send the start command
StartCams(x) {
    loop x {
        Send "/fic timelapse start " CamPrefix A_Index "{Enter}"
        Sleep 1000 ;Sleep here for client to catch up
        ; if we've NOT reached the cameracount open a new chat window and wait for it
        if not (A_Index = x) {
            Send "{Enter}"
            Sleep 200
        }
    }
}

; Loop through all cameras and send the stop command
StopCams(x) {
    loop x {
        Send "/fic timelapse stop " CamPrefix A_Index "{Enter}"
        Sleep 1000 ;Sleep here for client to catch up
        ; if we've NOT reached the cameracount open a new chat window and wait for it
        if not (A_Index = x) {
            Send "{Enter}"
            Sleep 200
        }
    }
}

; Loop through all cameras, delete them and decrease the cameracount accordingly (ideally we always should return 0)
DeleteCams(x) {
    NewCount := x
    loop x {
        Send "/fic timelapse delete " CamPrefix A_Index "{Enter}"
        Sleep 1000 ;Sleep here for client to catch up
        ; if we've NOT reached the cameracount open a new chat window and wait for it
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

; Writing CameraCount into ini file
SaveCams(x) {
    IniWrite(x, TLiniFile, "TimelapseCams", "CamCount")
}