Rem
IncBinPtr returns a byte pointer to the specified embedded binary file.
End Rem

SuperStrict

Incbin "incbinptr.bmx"

Local p:Byte Ptr = IncbinPtr("incbinptr.bmx")
Local bytes:Int = IncbinLen("incbinptr.bmx")

Local s:String = String.FromBytes(p,bytes)

Print "StringFromBytes(p,bytes)="+s
