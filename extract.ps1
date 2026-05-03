$outputFile = "frontend_mapping_summary.md"
$content = "# Bảng tra cứu Controller và Frontend JSPs`n`n"

$controllers = Get-ChildItem -Path "src\main\java" -Recurse -Filter "*Controller.java"
foreach ($controller in $controllers) {
    $fileLines = Get-Content $controller.FullName
    $controllerName = $controller.Name
    $baseMapping = ""
    $mappings = @()

    foreach ($line in $fileLines) {
        if ($line -match '@RequestMapping\("([^"]+)"\)') {
            $baseMapping = $matches[1]
        }
        
        if ($line -match '@(Get|Post|Put|Delete|Patch)Mapping\s*\(\s*"?([^"]*)"?\s*\)') {
            $methodType = $matches[1] + "Mapping"
            $subPath = $matches[2]
            if ($subPath -eq "") { $subPath = "/" }
            $obj = New-Object PSObject -Property @{
                Method = $methodType
                Path = $subPath
                View = ""
            }
            $mappings += $obj
        }
        
        if ($line -match 'return\s+"([^"]+)"') {
            $viewName = $matches[1]
            if (-not ($viewName -match "^redirect:")) {
                if ($mappings.Count -gt 0 -and $mappings[-1].View -eq "") {
                    $mappings[-1].View = $viewName
                }
            }
        }
    }

    if ($mappings.Count -gt 0) {
        $content += "## $controllerName`n"
        $content += "**Base Route:** `$baseMapping` `n`n"
        $content += "| HTTP Method | Route | Tên file JSP trả về (trong WEB-INF/views/) |`n"
        $content += "| :--- | :--- | :--- |`n"
        foreach ($map in $mappings) {
            $fullPath = $baseMapping + $map.Path
            if ($map.Path -eq "/") { $fullPath = $baseMapping }
            $view = $map.View
            if ($view -eq "") { 
                $viewStr = "*(Không trả về View/JSON/Redirect)*" 
            } else { 
                $viewStr = "`$view.jsp`" 
            }
            $methodType = $map.Method
            $content += "| $methodType | `$fullPath` | $viewStr |`n"
        }
        $content += "`n"
    }
}

$content | Out-File -FilePath $outputFile -Encoding utf8
Write-Output "Hoan thanh"
