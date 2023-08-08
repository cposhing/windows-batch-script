##https://superuser.com/questions/704575/get-song-duration-from-an-mp3-file-in-a-script
## https://learn.microsoft.com/zh-cn/windows/win32/shell/scriptable-shell-objects-roadmap
##https://stackoverflow.com/questions/21894169/calculate-total-seconds-from-string-in-format-hhmmss-fff

<#
.SYNOPSIS
   ��ȡ WAV �ļ���ʱ��������ת��Ϊ������

.DESCRIPTION
   �˽ű�ͨ��ʹ�� Windows Shell COM ��������ȡ WAV �ļ���ʱ����Ϣ��Ȼ����ת��Ϊ����������һ�� WAV �ļ���λ�ã��ű���������ļ���ʱ��������Ϊ��λ����

.PARAMETER FilePath
   Ҫ��ȡʱ���� WAV �ļ���λ�á�����˲���ʱ�����ṩ WAV �ļ�������·����

.EXAMPLE
   .\Get-SoundDuration.ps1 -FilePath "C:\Users\Administrator\Desktop\Av355740303.wav"
   �����WAV �ļ�ʱ��������Ϊ��λ��

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