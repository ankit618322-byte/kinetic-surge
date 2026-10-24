Add-Type -AssemblyName System.Drawing

function Generate-GameIcon([int]$size, [string]$outputPath) {
    $bmp = New-Object System.Drawing.Bitmap($size, $size)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

    # 1. Dark Neon Background
    $rect = New-Object System.Drawing.Rectangle(0, 0, $size, $size)
    $bgBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 3, 7, 18))
    $g.FillRectangle($bgBrush, $rect)

    # 2. Outer Glow Rings
    $penCyan = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(200, 34, 211, 238), [Math]::Max(2, [int]($size * 0.03)))
    $penMagenta = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(200, 217, 70, 239), [Math]::Max(2, [int]($size * 0.02)))

    $rOuter = [int]($size * 0.76)
    $g.DrawEllipse($penCyan, [int](($size - $rOuter)/2), [int](($size - $rOuter)/2), $rOuter, $rOuter)

    $rInner = [int]($size * 0.56)
    $g.DrawEllipse($penMagenta, [int](($size - $rInner)/2), [int](($size - $rInner)/2), $rInner, $rInner)

    # 3. Kinetic Player Arrow Ship
    $cx = [float]($size / 2.0)
    $cy = [float]($size / 2.0)
    $s = [float]($size * 0.38)

    $pTop = New-Object System.Drawing.PointF($cx, ($cy - $s * 0.75))
    $pRight = New-Object System.Drawing.PointF(($cx + $s * 0.7), ($cy + $s * 0.65))
    $pCenterNotch = New-Object System.Drawing.PointF($cx, ($cy + $s * 0.35))
    $pLeft = New-Object System.Drawing.PointF(($cx - $s * 0.7), ($cy + $s * 0.65))

    $shipPoints = [System.Drawing.PointF[]]@($pTop, $pRight, $pCenterNotch, $pLeft)

    $shipBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 6, 182, 212))
    $g.FillPolygon($shipBrush, $shipPoints)

    $penShipStroke = New-Object System.Drawing.Pen([System.Drawing.Color]::White, [Math]::Max(2, [int]($size * 0.02)))
    $g.DrawPolygon($penShipStroke, $shipPoints)

    # 4. Core Crystal
    $coreS = [float]($s * 0.45)
    $cTop = New-Object System.Drawing.PointF($cx, ($cy - $coreS * 0.5))
    $cRight = New-Object System.Drawing.PointF(($cx + $coreS * 0.45), ($cy + $coreS * 0.5))
    $cCenterNotch = New-Object System.Drawing.PointF($cx, ($cy + $coreS * 0.3))
    $cLeft = New-Object System.Drawing.PointF(($cx - $coreS * 0.45), ($cy + $coreS * 0.5))

    $coreBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
    $g.FillPolygon($coreBrush, [System.Drawing.PointF[]]@($cTop, $cRight, $cCenterNotch, $cLeft))

    # Save
    $dir = [System.IO.Path]::GetDirectoryName($outputPath)
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }
    $bmp.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)

    $bgBrush.Dispose()
    $penCyan.Dispose()
    $penMagenta.Dispose()
    $shipBrush.Dispose()
    $penShipStroke.Dispose()
    $coreBrush.Dispose()
    $g.Dispose()
    $bmp.Dispose()
}

# Generate Public Web/PWA Icons
Generate-GameIcon 192 "C:\Users\Kajod-pc\.gemini\antigravity\scratch\project\public\icon-192.png"
Generate-GameIcon 512 "C:\Users\Kajod-pc\.gemini\antigravity\scratch\project\public\icon-512.png"

# Generate Android Launcher Mipmap Icons
$mipmapSizes = @{
    "mipmap-mdpi" = 48
    "mipmap-hdpi" = 72
    "mipmap-xhdpi" = 96
    "mipmap-xxhdpi" = 144
    "mipmap-xxxhdpi" = 192
}

foreach ($key in $mipmapSizes.Keys) {
    $folder = "C:\Users\Kajod-pc\.gemini\antigravity\scratch\project\android\app\src\main\res\$key"
    Generate-GameIcon $mipmapSizes[$key] "$folder\ic_launcher.png"
    Generate-GameIcon $mipmapSizes[$key] "$folder\ic_launcher_round.png"
}

Write-Output "ALL_ICONS_GENERATED_SUCCESSFULLY"
