$backend_endpoints = @()

$javaFiles = Get-ChildItem -Path "d:\UYEN\TTCS\TutorCenterManagementSystem\src\main\java" -Recurse -Filter "*.java"

foreach ($file in $javaFiles) {
    $content = Get-Content $file.FullName
    $basePath = ""
    for ($i = 0; $i -lt $content.Length; $i++) {
        $line = $content[$i]
        if ($line -match '@RequestMapping\("([^"]+)"\)') {
            if ($line -match 'class ') {
                # sometimes mapping is before class, so we can't just check 'class' on same line
            }
            # For simplicity, if it's outside a method (we assume first RequestMapping is class level)
            if ($basePath -eq "") {
                $basePath = $matches[1]
            }
        }
    }

    for ($i = 0; $i -lt $content.Length; $i++) {
        $line = $content[$i]
        if ($line -match '@(GetMapping|PostMapping|PutMapping|DeleteMapping|PatchMapping|RequestMapping)\("([^"]+)"\)') {
            $methodType = $matches[1]
            $path = $matches[2]
            
            # if it's the class level mapping, skip it here if we already recorded it
            if ($methodType -eq "RequestMapping" -and $path -eq $basePath) {
                # it might be the class level one
                # But it could also be a method level one.
            }
            
            $fullPath = $path
            if ($path -ne $basePath) {
                if ($basePath -ne "") {
                    $fullPath = $basePath + $path
                }
            }
            
            $backend_endpoints += [PSCustomObject]@{
                File = $file.Name
                Method = $methodType
                Path = $fullPath
            }
        } elseif ($line -match '@(GetMapping|PostMapping|PutMapping|DeleteMapping|PatchMapping|RequestMapping)(?!\()') {
            $methodType = $matches[1]
            $fullPath = $basePath
            $backend_endpoints += [PSCustomObject]@{
                File = $file.Name
                Method = $methodType
                Path = $fullPath
            }
        }
    }
}

$backend_endpoints | ConvertTo-Json -Depth 3 | Out-File "d:\UYEN\TTCS\TutorCenterManagementSystem\scratch\backend_endpoints.json"
