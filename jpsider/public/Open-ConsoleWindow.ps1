function Open-ConsoleWindow
{
    <#
    .SYNOPSIS
        Opens a specified number of Console Windows.
    .DESCRIPTION
        Opens a specified number of Console Windows.
    .PARAMETER Count
        Please provide a new Console Title.
    .PARAMETER Executable
        Please provide an Executable. (Powershell.exe is default.)
    .EXAMPLE
        Open-ConsoleWindow -Count 2 -Executable PowerShell.exe
    .EXAMPLE
        Open-ConsoleWindow -Count 2 -Executable pwsh.exe
    .LINK
        http://www.invoke-automation.blog
    .NOTES
        none
    #>
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]
    [OutputType([String])]
    [OutputType([Boolean])]
    param(
        [Parameter(Mandatory = $true)][int]$Count,
        [ValidateSet("PowerShell.exe", "pwsh.exe")]
        [Parameter(Mandatory = $false)][string]$Executable = "PowerShell.exe"
    )
    if ($pscmdlet.ShouldProcess("Starting Open-ConsoleWindow function."))
    {
        try
        {
            $thisCount = 1
            do {
                Write-Output "Opening Conosle Window: $thisCount"
                if ($Executable -like 'PowerShell.exe'){
                    Start-Process -WindowStyle Normal "$Executable" "-NoExit Update-ConsoleTitle -Title Console:$thisCount"
                } else {
                    Start-Process -WindowStyle Normal "$Executable"
                }
                $thisCount++
            } while ($thisCount -le $Count)
        }
        catch
        {
            $ErrorMessage = $_.Exception.Message
            $FailedItem = $_.Exception.ItemName
            Throw "Open-ConsoleWindow: $ErrorMessage $FailedItem"
        }
    }
    else
    {
        # -WhatIf was used.
        return $false
    }
}