# Define the service name you want to audit
$ServiceName = "wuauserv"

# List of workstations
$Workstations = @(
  "WS001",
  "WS002",
  "WS003"
)

# Create an array to store results
$Results = @()

foreach ($Computer in $Workstations) {
    Write-Host "Checking $ServiceName on $Computer..." -ForegroundColor Cyan
    try {
        $Service = Get-Service -ComputerName $Computer -Name $ServiceName -ErrorAction Stop
        $Results += [PSCustomObject]@{
            ComputerName = $Computer
            ServiceName  = $ServiceName
            Status       = $Service.Status
        }
    }
    catch {
        $Results += [PSCustomObject]@{
            ComputerName = $Computer
            ServiceName  = $ServiceName
            Status       = "Error: $_"
        }
    }
}

# Output the results to the console
$Results | Format-Table -AutoSize
