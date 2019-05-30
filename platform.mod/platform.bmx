' Copyright (c) 2019 Bruce A Henderson
'
' This software is provided 'as-is', without any express or implied
' warranty. In no event will the authors be held liable for any damages
' arising from the use of this software.
' 
' Permission is granted to anyone to use this software for any purpose,
' including commercial applications, and to alter it and redistribute it
' freely, subject to the following restrictions:
' 
'    1. The origin of this software must not be misrepresented; you must not
'    claim that you wrote the original software. If you use this software
'    in a product, an acknowledgment in the product documentation would be
'    appreciated but is not required.
' 
'    2. Altered source versions must be plainly marked as such, and must not be
'    misrepresented as being the original software.
' 
'    3. This notice may not be removed or altered from any source
'    distribution.
' 
SuperStrict

Rem
bbdoc: Platform utils
End Rem
Module BRL.Platform

Import BRL.TextStream
Import Pub.macos

?win32
Import "win32_glue.c"
?

Private
Global _version:String
Public

Rem
bbdoc: Returns a #String representation of the OS version.
about: On Linux, this will return something like "Ubuntu" or "Fedora".
On Windows and macOS, this will return the version number, such as "10.11"
End Rem
Function OSVersion:String()
	If _version Then
		Return _version
	End If
?linux
	Return LinuxVersion()
?macos
	Return MacOSVersion()
?win32
	Return WindowsVersion()
?
End Function

Function LinuxVersion:String()
?Not linux
	Return ""
?linux
	If _version Then
		Return _version
	End If
	
	Local rel:String[] = LoadText("/etc/os-release").Split("~n")
	For Local line:String = EachIn rel
		If line.StartsWith("NAME") Then
			Local parts:String[] = line.Split("=")
			If parts.length > 1 Then
				_version = parts[1].Replace("~q", "").Trim()
				Return _version
			End If
		End If
	Next
?
End Function

Function MacOSVersion:String()
?Not macos
	Return ""
?macos
	If _version Then
		Return _version
	End If

	Local major:Int, minor:Int, patch:Int
	NSOSVersion(major, minor, patch)
	_version = major + "." + minor + "." + patch
	Return _version
?
End Function

Private
?win32
Extern
	Function bmx_os_getwindowsversion(major:Int Var, minor:Int Var)
End Extern
?
Public

Function WindowsVersion:String()
?Not win32
	Return ""
?win32
	If _version Then
		Return _version
	End If

	Local major:Int
	Local minor:Int
	bmx_os_getwindowsversion(major, minor)
	_version = major + "." + minor
	Return _version
?
End Function
