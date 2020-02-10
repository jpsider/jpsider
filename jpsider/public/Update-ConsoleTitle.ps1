function Update-ConsoleTitle
{
    <#
    .SYNOPSIS
        Changes the title in the Console.
    .DESCRIPTION
        Update-ConsoleTitle changes the title in the Console.
    .PARAMETER Title
        Please provide a new Console Title.
    .NOTES
        none
    .EXAMPLE
        Update-ConsoleTitle -Title "My New Title"
    .LINK
        http://www.invoke-automation.blog
    #>
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]
    [OutputType([String])]
    [OutputType([Boolean])]
    param(
        [Parameter(Mandatory = $true)][String]$Title
    )
    if ($pscmdlet.ShouldProcess("Starting Update-ConsoleTitle function."))
    {
        try
        {
            Write-Output "Updating Console title to: $Title"
            $Host.UI.RawUI.WindowTitle = "$Title"
        }
        catch
        {
            $ErrorMessage = $_.Exception.Message
            $FailedItem = $_.Exception.ItemName
            Throw "Update-ConsoleTitle: $ErrorMessage $FailedItem"
        }
    }
    else
    {
        # -WhatIf was used.
        return $false
    }
}