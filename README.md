Windows Cursor Hider
====================

Although Windows already has an option to hide the mouse cursor whilst typing, which can be found under Control Panel/Mouse, this is respected on a 'per application' basis.

Unfortunately, many applications, such as Visual Studio, do not respect this setting, and leave the mouse cursor visible whilst typing.

This can be quite annoying, as one tends to type exactly where one clicked, i.e., where the mouse cursor currently is, and especially in the case of developers, the IDE is particularly rich, meaning that the mouse cursor will normally also activate tooltips related to the item they are hovering over.

This is a small script written and compiled using AutoHotKey that hides the windows cursor when a user starts typing any alphanumeric (and certain coding-related) characters, and shows it again as soon as a mouse movement is detected.

You can either **get the latest executable from [here][1]**, or you can run it as an AutoHotKey script by downloading the AutoHotKey utility from [here][2]

[1]:https://github.com/Stefan-Z-Camilleri/Windows-Cursor-Hider/blob/master/executable/Hide%20Mouse%20Cursor%20on%20Idle.exe
[2]:http://www.autohotkey.com
