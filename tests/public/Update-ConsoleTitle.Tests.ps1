$script:ModuleName = 'jpsider'

$here = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'tests', "$script:ModuleName"
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Function Write-Output{}

Describe "Update-ConsoleTitle function for $moduleName" -Tags Build {
    It "Should Return $false when whatIf is used." {
        Update-ConsoleTitle -Title "My new Console title" -WhatIf | Should be $false
    }
    It "Should Return null." {
        Mock -CommandName 'Write-Output' -MockWith {}
        Update-ConsoleTitle -Title "My new Console title" | Should be $null
        Assert-MockCalled -CommandName 'Write-Output' -Times 1 -Exactly
    }
    It "Should not throw." {
        Mock -CommandName 'Write-Output' -MockWith {}
        {Update-ConsoleTitle -Title "My new Console title"} | Should not Throw
        Assert-MockCalled -CommandName 'Write-Output' -Times 2 -Exactly
    }
    It "Should throw when Write-Output fails." {
        Mock -CommandName 'Write-Output' -MockWith {
            Throw "Unable to update console title."
        }
        {Update-ConsoleTitle -Title "My new Console title"} | Should Throw
        Assert-MockCalled -CommandName 'Write-Output' -Times 3 -Exactly
    }
}
