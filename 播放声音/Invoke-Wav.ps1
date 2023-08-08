<#
.SYNOPSIS
Invoke the playing of a wav audio file.

.DESCRIPTION
This script is used to play a wav audio file. You can specify the path of the wav file as an input parameter to play the audio.

.PARAMETER FilePath
Specifies the full path of the wav file to be played.

.EXAMPLE
.\Invoke-Audio.ps1 -FilePath "C:\path\to\your\audio.wav"
#>

param (
    [Parameter(Mandatory = $true, HelpMessage = "Specifies the full path of the wav file to be played")]
    [string]$FilePath,
    [Parameter(Mandatory=$false, HelpMessage = "Specifies the wav file play method")]
    [string]$method='Async'
)

function Invoke-Wav {
    # Check file exists
    if (-not (Test-Path $FilePath)) {
        Write-Host "The specified wav file does not exist: $FilePath" -ForegroundColor Red
        Exit 1
    }
	
	# Check file format
	$extension = [System.IO.Path]::GetExtension($FilePath).ToLower()
    if ($extension -ne ".wav") {
        Write-Host "The specified sound file does not a wav file" -ForegroundColor Red
        Exit 1
    }

    # Create and initialize the audio player
    $audioPlayer = New-Object System.Media.SoundPlayer
    $audioPlayer.SoundLocation = $FilePath
	
	 # Get the duration in seconds
	$duration = Get-WavDuration
	
    # Play the audio
    try {
        #$audioPlayer.Play()
        $audioPlayer.PlaySync()
        #Write-Host "Playing audio..."
		Start-Sleep -Seconds $duration
    }
    catch {
        Write-Host "Unable to play audio: $_" -ForegroundColor Red
        Exit 1
    }
}

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

# Main program
Invoke-Wav
