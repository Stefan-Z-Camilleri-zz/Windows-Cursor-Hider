; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         Stefan Z Camilleri - stefan@camilleri.me

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Initialize the mouse cursor
SystemCursor("Init")

; Get the current mouse position, and store its coordinates
MouseGetPos mX0, mY0

; Set a timer to check if the mouse is still idle every 250ms
SetTimer, CheckIdle, 250

; Register the keys you want to listen on
keys = ``1234567890-=qwertyuiop[]\asdfghjkl;'zxcvbnm,./

; For every defined key, register a call to hide the mouse cursor
Loop Parse, keys
   HotKey ~*%A_LoopField%, Hoty
return

; Checks if the mouse has moved, and if so, shows it and records the new position
CheckIdle:
MouseGetPos mX, mY
if (mX0 != mX && mY0 != mY)
{
    SystemCursor("On")
    mX0 := mX, mY0 := mY
}
return

; Hides the mouse cursor
Hoty:
   SystemCursor("Off")
return

; Ensure the cursor is made visible when the script exits.
#Persistent
    OnExit, ShowCursor
return

; Shows the mouse cursor
ShowCursor:
SystemCursor("On")
ExitApp

; Function to hide or show the mouse cursor
SystemCursor(OnOff=1)   ; INIT = "I","Init"; OFF = 0,"Off"; TOGGLE = -1,"T","Toggle"; ON = others
{
    static AndMask, XorMask, $, h_cursor
        ,c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13 ; system cursors
        , b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13   ; blank cursors
        , h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11,h12,h13   ; handles of default cursors

    if (OnOff = "Init" or OnOff = "I" or $ = "")       ; init when requested or at first call
    {
        $ = h                                          ; active default cursors
        VarSetCapacity( h_cursor,4444, 1 )
        VarSetCapacity( AndMask, 32*4, 0xFF )
        VarSetCapacity( XorMask, 32*4, 0 )
        system_cursors = 32512,32513,32514,32515,32516,32642,32643,32644,32645,32646,32648,32649,32650
        StringSplit c, system_cursors, `,
        Loop %c0%
        {
            h_cursor   := DllCall( "LoadCursor", "uint",0, "uint",c%A_Index% )
            h%A_Index% := DllCall( "CopyImage",  "uint",h_cursor, "uint",2, "int",0, "int",0, "uint",0 )
            b%A_Index% := DllCall("CreateCursor","uint",0, "int",0, "int",0
                , "int",32, "int",32, "uint",&AndMask, "uint",&XorMask )
        }
    }

    if (OnOff = 0 or OnOff = "Off" or $ = "h" and (OnOff < 0 or OnOff = "Toggle" or OnOff = "T"))
        $ = b  ; use blank cursors
    else
        $ = h  ; use the saved cursors

    Loop %c0%
    {
        h_cursor := DllCall( "CopyImage", "uint",%$%%A_Index%, "uint",2, "int",0, "int",0, "uint",0 )
        DllCall( "SetSystemCursor", "uint",h_cursor, "uint",c%A_Index% )
    }
}