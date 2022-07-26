# FicsitCam-AHK
This is an AutoHotKey (v2!) script, that manages timelapses through the Ficsit-Cam Mod for Satisfactory

## Requirements and Notes

This script is written from the ground up for AHK v2 (although its still beta).
So please ensure you have downloaded the correct version of [AutoHotKey](https://www.autohotkey.com/)

I have written (and tested) this based on Satisfactory U6 (Experiment Branch) with a pre-release version of
the [Ficsit-Cam](https://github.com/Panakotta00/FicsIt-Cam) mod

## How it works

First of all, this script is "dumb", the only way I could figure out a way to store the amount of cameras, is in an
INI file.

So that's what happens when you create a Timelapse Camera; It increases a number in an INI file and then generates the chat commands to spawn that camera in game.

I have created a few "HotStrings" in AHK which act as "commands" to create/start/stop and delete timelapse cameras

### Configuration

One can change two variables to influence the behaviour of the script:

```
SecondsPerFrame := 5 ;(Default)
CamPrefix := "TLcam" ;(Default)
```

*SecondsPerFrame:* Can be anything really, depending on your timelapse needs
*CamPrefix:* A string naming your timelapse cameras, the script will add a number after this prefix

### Commands

`tlc` \
This creates a timelapse camera at the players position.
The name is based on the prefix in the script and the index of the current camera \
*generated command structure:* `/fic timelapse create <Prefix><CurrentIndex> <SecondsPerFrame>`

`tls` \
This starts all existing Timelapse Cameras \
*generated command structure:* `/fic timelapse start <Prefix><1-MaxCams>`

`tlf` \
This stops all existing Timelapse Cameras \
*generated command structure:* `/fic timelapse stop <Prefix><1-MaxCams>`

`tld` \
This deletes all existing Timelapse Cameras \
*generated command structure:* `/fic timelapse delete <Prefix><1-MaxCams>`

`tll` \
This lists the existing Timelapse Cameras \
*generated command structure:* `/fic timelapse list`

### Additional Notes

I had to add delays inbetween chat commands as otherwise the client would ignore all 
but the first line of chat commands

If one wants to, they can change these delays, I would recommend however, that the client be left enough time
after sending a chat command to process the command and be ready for another...

Granted, my delay values are probably conservative, but for me they work
