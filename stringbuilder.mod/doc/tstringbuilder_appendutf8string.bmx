SuperStrict

Framework BRL.StringBuilder
Import brl.standardio

Local sb:TStringBuilder = New TStringBuilder()

Local b:Byte Ptr = "Привет, мир!".ToUTF8String()

sb.AppendUTF8String(b)

MemFree(b)

Print sb.ToString()
