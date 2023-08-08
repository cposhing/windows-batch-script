param(
    [string]$WallpaperPath
)
<#
 
    .SYNOPSIS
    Applies a specified wallpaper to the current user's desktop
    
    .PARAMETER WallpaperPath
    Provide the exact path to the image
  
    .EXAMPLE
    Set-WallPaper -WallpaperPath "C:\Users\Administrator\Desktop\RE4wB7a.jpg"
  
#>

Add-Type @"
    using System.Runtime.InteropServices;

    public class WallpaperChanger {
		
		public const int SetDesktopWallpaper = 20;
		public const int UpdateIniFile = 0x01;
		public const int SendWinIniChange = 0x02;
		[DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
		
		private static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
		public static void SetWallpaper(string path){
			SystemParametersInfo(SetDesktopWallpaper, 0, path, UpdateIniFile | SendWinIniChange);
	    }
    }
"@

[WallpaperChanger]::SetWallpaper($WallpaperPath)