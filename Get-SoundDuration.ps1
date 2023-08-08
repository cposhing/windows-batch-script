##https://superuser.com/questions/704575/get-song-duration-from-an-mp3-file-in-a-script
## https://learn.microsoft.com/zh-cn/windows/win32/shell/scriptable-shell-objects-roadmap
##https://stackoverflow.com/questions/21894169/calculate-total-seconds-from-string-in-format-hhmmss-fff

<#
.SYNOPSIS
   获取 WAV 文件的时长并将其转换为秒数。

.DESCRIPTION
   此脚本通过使用 Windows Shell COM 对象来获取 WAV 文件的时长信息，然后将其转换为秒数。输入一个 WAV 文件的位置，脚本将输出该文件的时长（以秒为单位）。

.PARAMETER FilePath
   要获取时长的 WAV 文件的位置。输入此参数时，请提供 WAV 文件的完整路径。

.EXAMPLE
   .\Get-SoundDuration.ps1 -FilePath "C:\Users\Administrator\Desktop\Av355740303.wav"
   输出：WAV 文件时长（以秒为单位）

#>

param (
    [Parameter(Mandatory = $true, HelpMessage = "Specifies the full path of the sound file to be calculate")]
    [string]$FilePath
)

function Get-WavDuration {
	
	# Check file format
	if (-not (Test-Path $FilePath)) {
        Write-Host "The specified sound file does not exist: $FilePath" -ForegroundColor Red
        Exit 1
    }
	
	# Check file format
	$extension = [System.IO.Path]::GetExtension($FilePath).ToLower()
    if ($extension -ne ".wav") {
        Write-Host "The specified sound file does not a WAV file" -ForegroundColor Red
        Exit 1
    }

    $shell = New-Object -COMObject Shell.Application
    $folder = Split-Path $FilePath
    $file = Split-Path $FilePath -Leaf
    $shellfolder = $shell.Namespace($folder)
    $shellfile = $shellfolder.ParseName($file)

    $timeString = $shellfolder.GetDetailsOf($shellfile, 27)

    $timeSpan = [TimeSpan]::Parse($timeString)
    $seconds = $timeSpan.TotalSeconds

    return $seconds
}

Get-WavDuration