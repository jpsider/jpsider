$script:ModuleName = 'jpsider'

$here = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'tests', "$script:ModuleName"
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Function Write-Output{}
Function Remove-Module{}
Function Update-Module{}
Function Import-Module{}

Describe "Reset-Module function for $moduleName" -Tags Build {
    It "Should Return $false when whatIf is used." {
        Reset-Module -Name "VMware.PowerCLI" -WhatIf | Should be $false
    }
    It "Should be null." {
        Mock -CommandName 'Write-Output' -MockWith {}
        Mock -CommandName 'Remove-Module' -MockWith {}
        Mock -CommandName 'Update-Module' -MockWith {}
        Mock -CommandName 'Import-Module' -MockWith {}
        Reset-Module -Name "VMware.PowerCLI" | Should be $null
        Assert-MockCalled -CommandName 'Write-Output' -Times 3 -Exactly
        Assert-MockCalled -CommandName 'Remove-Module' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Update-Module' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Import-Module' -Times 1 -Exactly
    }
    It "Should not throw." {
        Mock -CommandName 'Write-Output' -MockWith {}
        Mock -CommandName 'Remove-Module' -MockWith {}
        Mock -CommandName 'Update-Module' -MockWith {}
        Mock -CommandName 'Import-Module' -MockWith {}
        {Reset-Module -Name "VMware.PowerCLI"} | Should not Throw
        Assert-MockCalled -CommandName 'Write-Output' -Times 6 -Exactly
        Assert-MockCalled -CommandName 'Remove-Module' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Update-Module' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Import-Module' -Times 2 -Exactly
    }
    It "Should throw when Write-Output fails." {
        Mock -CommandName 'Write-Output' -MockWith {
            Throw "Unable to update console title."
        }
        Mock -CommandName 'Remove-Module' -MockWith {}
        Mock -CommandName 'Update-Module' -MockWith {}
        Mock -CommandName 'Import-Module' -MockWith {}
        {Reset-Module -Name "VMware.PowerCLI"} | Should Throw
        Assert-MockCalled -CommandName 'Write-Output' -Times 7 -Exactly
        Assert-MockCalled -CommandName 'Remove-Module' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Update-Module' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Import-Module' -Times 2 -Exactly
    }
    It "Should throw when Remove-Module fails." {
        Mock -CommandName 'Write-Output' -MockWith {}
        Mock -CommandName 'Remove-Module' -MockWith {
            Throw "Remove-Module failed"
        }
        Mock -CommandName 'Update-Module' -MockWith {}
        Mock -CommandName 'Import-Module' -MockWith {}
        {Reset-Module -Name "VMware.PowerCLI"} | Should Throw
        Assert-MockCalled -CommandName 'Write-Output' -Times 8 -Exactly
        Assert-MockCalled -CommandName 'Remove-Module' -Times 3 -Exactly
        Assert-MockCalled -CommandName 'Update-Module' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Import-Module' -Times 2 -Exactly
    }
    It "Should throw when Update-Module fails." {
        Mock -CommandName 'Write-Output' -MockWith {}
        Mock -CommandName 'Remove-Module' -MockWith {}
        Mock -CommandName 'Update-Module' -MockWith {
            Throw "Update-Module failed"
        }
        Mock -CommandName 'Import-Module' -MockWith {}
        {Reset-Module -Name "VMware.PowerCLI"} | Should Throw
        Assert-MockCalled -CommandName 'Write-Output' -Times 10 -Exactly
        Assert-MockCalled -CommandName 'Remove-Module' -Times 4 -Exactly
        Assert-MockCalled -CommandName 'Update-Module' -Times 3 -Exactly
        Assert-MockCalled -CommandName 'Import-Module' -Times 2 -Exactly
    }
    It "Should throw when Import-Module fails." {
        Mock -CommandName 'Write-Output' -MockWith {}
        Mock -CommandName 'Remove-Module' -MockWith {}
        Mock -CommandName 'Update-Module' -MockWith {}
        Mock -CommandName 'Import-Module' -MockWith {
            Throw "Import-Module failed"
        }
        {Reset-Module -Name "VMware.PowerCLI"} | Should Throw
        Assert-MockCalled -CommandName 'Write-Output' -Times 13 -Exactly
        Assert-MockCalled -CommandName 'Remove-Module' -Times 5 -Exactly
        Assert-MockCalled -CommandName 'Update-Module' -Times 4 -Exactly
        Assert-MockCalled -CommandName 'Import-Module' -Times 3 -Exactly
    }
}
