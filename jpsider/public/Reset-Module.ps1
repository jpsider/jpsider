function Reset-Module
{
    <#
    .SYNOPSIS
        Updates a module, and Re-imports it.
    .DESCRIPTION
        Updates a module, and Re-imports it.
    .PARAMETER Name
        Please provide a valid module Name.
    .EXAMPLE
        Reset-Module -Name VMware.PowerCLI
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
        [Parameter(Mandatory = $true)][string]$Name
    )
    if ($pscmdlet.ShouldProcess("Starting Reset-Module function."))
    {
        try
        {
            # Remove the Module from the Session/Console
            Write-Output "Removing Module $Name from Console/Session."
            Remove-Module -Name $Name -Force -Confirm:$false

            # Update the Module
            Write-Output "Updating Module $Name"
            Update-Module -Name $Name -Force -Confirm:$false

            # Import the Module to the Session/Console
            Write-Output "Importing Module $Name to Console/Session."
            Import-Module -Name $Name -Force
        }
        catch
        {
            $ErrorMessage = $_.Exception.Message
            $FailedItem = $_.Exception.ItemName
            Throw "Reset-Module: $ErrorMessage $FailedItem"
        }
    }
    else
    {
        # -WhatIf was used.
        return $false
    }
}