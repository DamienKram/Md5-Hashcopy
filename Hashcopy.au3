#include <Crypt.au3>

$sSourceDir="E:\Temp\Input\"
$sDestDir="E:\Temp\Output\"
$sFileName = ""
$sFileHash = ""
$sExten=""
$sDestFile=""
ConsoleWrite($sSourceDir&@CRLF&$sDestDir&@CRLF)

_Crypt_Startup() 
Searcher()
 _Crypt_Shutdown() 

Func Searcher()
	FileChangeDir($sSourceDir)
	Local $hSearch = FileFindFirstFile("*.*")
        If $hSearch = -1 Then
                ConsoleWrite("Error: No files/directories")
                Return False
        EndIf

        While 1
                $sFileName = FileFindNextFile($hSearch)
                If @error Then ExitLoop
                ; ConsoleWrite( "File: " & $sFileName& @CRLF)
				Renamer()
		WEnd
			
	FileClose($hSearch)
EndFunc

Func Renamer()
	$sRead =$sFileName
	$sExten=StringTrimLeft($sRead, StringInStr($sRead, ".",0,-1))
	If FileExists($sRead) Then 
		$dHash = _Crypt_HashFile($sRead, 0x00008003) 
		;ConsoleWrite($dHash&@CRLF)
		$sFileHash = StringLower (StringTrimLeft($dHash, 2))
		$sDestFile = $sDestDir&$sFileHash&"."&$sExten
		;ConsoleWrite($sDestFile&@CRLF)
		;CheckAnomaly()
		FileCopy($sRead,$sDestFile,0)
	EndIf
	
EndFunc   ;==>Example

func CheckAnomaly()
	
EndFunc
