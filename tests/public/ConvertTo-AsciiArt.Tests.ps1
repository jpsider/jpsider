$script:ModuleName = 'jpsider'

$here = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'tests', "$script:ModuleName"
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Function Invoke-RestMethod {}
Function Start-Process {}

Describe "ConvertTo-AsciiArt function for $moduleName" -Tags Build {
    It "Should Return $false when whatIf is used." {
        ConvertTo-AsciiArt -Text "My Text" -WhatIf | Should be $false
    }
    It "Should Return not return null." {
        Mock -CommandName 'Invoke-RestMethod' -MockWith {
            return "Ascii Art, lots of text!"
        }
        ConvertTo-AsciiArt -Text "My Text" | Should -not -be $null
        Assert-MockCalled -CommandName 'Invoke-RestMethod' -Times 1 -Exactly -Scope It
    }
    It "Should not not throw." {
        Mock -CommandName 'Invoke-RestMethod' -MockWith {
            return "Ascii Art, lots of text!"
        }
        { ConvertTo-AsciiArt -Text "My Text" } | Should not Throw
        Assert-MockCalled -CommandName 'Invoke-RestMethod' -Times 1 -Exactly -Scope It
    }
    It "Should throw when the rest call fails." {
        Mock -CommandName 'Invoke-RestMethod' -MockWith {
            Throw
        }
        { ConvertTo-AsciiArt -Text "My Text" } | Should Throw
        Assert-MockCalled -CommandName 'Invoke-RestMethod' -Times 1 -Exactly -Scope It
    }
}