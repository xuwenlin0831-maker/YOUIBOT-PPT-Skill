param(
    [Parameter(Mandatory = $true)][string]$Source,
    [Parameter(Mandatory = $true)][string]$Plan,
    [Parameter(Mandatory = $true)][string]$Output,
    [switch]$Overwrite
)

$ErrorActionPreference = "Stop"
$sourcePath = (Resolve-Path -LiteralPath $Source).Path
$planPath = (Resolve-Path -LiteralPath $Plan).Path
$outputPath = [System.IO.Path]::GetFullPath($Output)

if ($sourcePath -eq $outputPath) {
    throw "Output must differ from the retained source template."
}
if ((Test-Path -LiteralPath $outputPath) -and -not $Overwrite) {
    throw "Output already exists. Choose a new path or pass -Overwrite."
}

$outputDir = Split-Path -Parent $outputPath
if (-not (Test-Path -LiteralPath $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
}
Copy-Item -LiteralPath $sourcePath -Destination $outputPath -Force
$deckPlan = Get-Content -Raw -Encoding UTF8 -LiteralPath $planPath | ConvertFrom-Json
if (-not $deckPlan.slides -or $deckPlan.slides.Count -lt 1) {
    throw "The plan must contain at least one slide."
}

function Get-LeafShapes($shapes) {
    $result = @()
    for ($i = 1; $i -le $shapes.Count; $i++) {
        $shape = $shapes.Item($i)
        if ($shape.Type -eq 6) {
            $result += Get-LeafShapes $shape.GroupItems
        } else {
            $result += $shape
        }
    }
    return $result
}

function Get-Text($shape) {
    try {
        if ($shape.HasTextFrame -and $shape.TextFrame.HasText) {
            return [string]$shape.TextFrame.TextRange.Text
        }
    } catch {}
    return ""
}

function Set-SlideText($slide, $spec) {
    $mode = if ($spec.mode) { [string]$spec.mode } else { "exact" }
    $occurrence = if ($spec.occurrence) { [int]$spec.occurrence } else { 1 }
    $required = if ($null -eq $spec.required) { $true } else { [bool]$spec.required }
    $matches = @()

    foreach ($shape in (Get-LeafShapes $slide.Shapes)) {
        $current = Get-Text $shape
        if (-not $current) { continue }
        $isMatch = if ($mode -eq "contains") {
            $current.Contains([string]$spec.match)
        } else {
            $current.Trim() -eq ([string]$spec.match).Trim()
        }
        if ($isMatch) { $matches += $shape }
    }

    if ($matches.Count -lt $occurrence) {
        $message = "Slide $($slide.SlideIndex): text match not found: $($spec.match) occurrence $occurrence"
        if ($required) { throw $message }
        Write-Warning $message
        return
    }
    $matches[$occurrence - 1].TextFrame.TextRange.Text = [string]$spec.text
}

function Replace-Picture($slide, $spec) {
    $path = (Resolve-Path -LiteralPath ([string]$spec.path)).Path
    $pictures = @(Get-LeafShapes $slide.Shapes | Where-Object { $_.Type -eq 13 } | Sort-Object Top, Left)
    $index = [int]$spec.index
    if ($index -lt 1 -or $index -gt $pictures.Count) {
        throw "Slide $($slide.SlideIndex): picture index $index is out of range."
    }
    $picture = $pictures[$index - 1]
    $left, $top, $width, $height = $picture.Left, $picture.Top, $picture.Width, $picture.Height
    $picture.Delete()
    $slide.Shapes.AddPicture($path, $false, $true, $left, $top, $width, $height) | Out-Null
}

function Update-Table($slide, $spec) {
    $tables = @(Get-LeafShapes $slide.Shapes | Where-Object { $_.HasTable })
    $index = [int]$spec.index
    if ($index -lt 1 -or $index -gt $tables.Count) {
        throw "Slide $($slide.SlideIndex): table index $index is out of range."
    }
    $table = $tables[$index - 1].Table
    foreach ($cell in $spec.cells) {
        $table.Cell([int]$cell.row, [int]$cell.column).Shape.TextFrame.TextRange.Text = [string]$cell.text
    }
}

function Set-Notes($slide, [string]$notes) {
    try {
        for ($i = 1; $i -le $slide.NotesPage.Shapes.Placeholders.Count; $i++) {
            $placeholder = $slide.NotesPage.Shapes.Placeholders.Item($i)
            if ($placeholder.PlaceholderFormat.Type -eq 2) {
                $placeholder.TextFrame.TextRange.Text = $notes
                return
            }
        }
    } catch {
        Write-Warning "Slide $($slide.SlideIndex): speaker notes could not be updated."
    }
}

$powerPoint = $null
$presentation = $null
try {
    $powerPoint = New-Object -ComObject PowerPoint.Application
    $powerPoint.DisplayAlerts = 0
    $powerPoint.Visible = -1
    $presentation = $powerPoint.Presentations.Open($outputPath, $false, $false, $true)
    $originalCount = $presentation.Slides.Count

    foreach ($slideSpec in $deckPlan.slides) {
        $sourceNumber = [int]$slideSpec.source_slide
        if ($sourceNumber -lt 1 -or $sourceNumber -gt $originalCount) {
            throw "Source slide $sourceNumber is out of range 1..$originalCount."
        }
        $presentation.Slides.Item($sourceNumber).Copy()
        Start-Sleep -Milliseconds 150
        $presentation.Slides.Paste($presentation.Slides.Count + 1) | Out-Null
        $slide = $presentation.Slides.Item($presentation.Slides.Count)

        if ($slideSpec.replacements) {
            foreach ($replacement in $slideSpec.replacements) { Set-SlideText $slide $replacement }
        }
        if ($slideSpec.pictures) {
            foreach ($picture in $slideSpec.pictures) { Replace-Picture $slide $picture }
        }
        if ($slideSpec.tables) {
            foreach ($table in $slideSpec.tables) { Update-Table $slide $table }
        }
        if ($slideSpec.notes) { Set-Notes $slide ([string]$slideSpec.notes) }
    }

    for ($i = $originalCount; $i -ge 1; $i--) {
        $presentation.Slides.Item($i).Delete()
    }
    $presentation.Save()
    Write-Output $outputPath
} finally {
    if ($presentation) {
        try { $presentation.Close() } catch {}
        [System.Runtime.InteropServices.Marshal]::ReleaseComObject($presentation) | Out-Null
    }
    if ($powerPoint) {
        try { $powerPoint.Quit() } catch {}
        [System.Runtime.InteropServices.Marshal]::ReleaseComObject($powerPoint) | Out-Null
    }
    [GC]::Collect()
    [GC]::WaitForPendingFinalizers()
}
