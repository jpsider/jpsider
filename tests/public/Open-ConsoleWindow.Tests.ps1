$script:ModuleName = 'jpsider'

$here = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'tests', "$script:ModuleName"
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Function Write-Output{}
Function Start-Process{}

Describe "Open-ConsoleWindow function for $moduleName" -Tags Build {
    It "Should Return $false when whatIf is used." {
        Open-ConsoleWindow -Count 2 -Executable PowerShell.exe -WhatIf | Should be $false
    }
    It "Should Return null." {
        Mock -CommandName 'Write-Output' -MockWith {}
        Mock -CommandName 'Start-Process' -MockWith {}
        Open-ConsoleWindow -Count 2 -Executable PowerShell.exe | Should be $null
        Assert-MockCalled -CommandName 'Write-Output' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Start-Process' -Times 2 -Exactly
    }
    It "Should not throw with PowerShell.exe." {
        Mock -CommandName 'Write-Output' -MockWith {}
        Mock -CommandName 'Start-Process' -MockWith {}
        {Open-ConsoleWindow -Count 2 -Executable PowerShell.exe} | Should not Throw
        Assert-MockCalled -CommandName 'Write-Output' -Times 4 -Exactly
        Assert-MockCalled -CommandName 'Start-Process' -Times 4 -Exactly
    }
    It "Should not throw with pwsh.exe." {
        Mock -CommandName 'Write-Output' -MockWith {}
        Mock -CommandName 'Start-Process' -MockWith {}
        {Open-ConsoleWindow -Count 2 -Executable pwsh.exe} | Should not Throw
        Assert-MockCalled -CommandName 'Write-Output' -Times 6 -Exactly
        Assert-MockCalled -CommandName 'Start-Process' -Times 6 -Exactly
    }
    It "Should throw when Write-Output fails." {
        Mock -CommandName 'Write-Output' -MockWith {
            Throw "Unable to update console title."
        }
        Mock -CommandName 'Start-Process' -MockWith {}
        {Open-ConsoleWindow -Count 2 -Executable PowerShell.exe} | Should Throw
        Assert-MockCalled -CommandName 'Write-Output' -Times 7 -Exactly
        Assert-MockCalled -CommandName 'Start-Process' -Times 6 -Exactly
    }
    It "Should throw when Start-Process fails." {
        Mock -CommandName 'Write-Output' -MockWith {}
        Mock -CommandName 'Start-Process' -MockWith {
            Throw "Unable to start new process"
        }
        {Open-ConsoleWindow -Count 2 -Executable PowerShell.exe} | Should Throw
        Assert-MockCalled -CommandName 'Write-Output' -Times 8 -Exactly
        Assert-MockCalled -CommandName 'Start-Process' -Times 7 -Exactly
    }
}