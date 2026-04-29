$frontend_apis = @()

$jspFiles = Get-ChildItem -Path "d:\UYEN\TTCS\TutorCenterManagementSystem\src\main\webapp\WEB-INF\views" -Recurse -Filter "*.jsp"
$jsFiles = Get-ChildItem -Path "d:\UYEN\TTCS\TutorCenterManagementSystem\src\main\resources\static\js" -Recurse -Filter "*.js"

$allFiles = $jspFiles + $jsFiles

foreach ($file in $allFiles) {
    $content = Get-Content $file.FullName
    for ($i = 0; $i -lt $content.Length; $i++) {
        $line = $content[$i]
        if ($line -match "fetch\(['\"`]?([^'\"`,]+)['\"`]?") {
            $frontend_apis += [PSCustomObject]@{
                File = $file.Name
                Line = $i + 1
                Call = $line.Trim()
                UrlMatch = $matches[1]
            }
        } elseif ($line -match "\`([^\`]+)\`") {
            if ($line -match "fetch\(") {
                $frontend_apis += [PSCustomObject]@{
                    File = $file.Name
                    Line = $i + 1
                    Call = $line.Trim()
                    UrlMatch = $matches[1]
                }
            }
        }
    }
}

$frontend_apis | ConvertTo-Json -Depth 3 | Out-File "d:\UYEN\TTCS\TutorCenterManagementSystem\scratch\frontend_apis.json"
