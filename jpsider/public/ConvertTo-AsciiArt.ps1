function ConvertTo-AsciiArt
{
    <#
    .SYNOPSIS
        Converts a Text string to ASCII art.
    .DESCRIPTION
        Converts a Text string to ASCII art.
    .PARAMETER Text
        Please provide a text string.
    .PARAMETER FontName
        Please provide a FontName. Default: big
    .PARAMETER URL
        Please provide a URL. Default: http://artii.herokuapp.com/make
    .NOTES
        Requires Internet, with default url.
    .EXAMPLE
        ConvertTo-AsciiArt -Text "Check Meowt"
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
        [Parameter(Mandatory = $true)][String]$Text,
        [Parameter(Mandatory = $false)][String]$FontName = "big",
        [Parameter(Mandatory = $false)][String]$url = "http://artii.herokuapp.com/make"
    )
    if ($pscmdlet.ShouldProcess("Starting ConvertTo-AsciiArt function."))
    {
        try
        {
            # Convert the String
            $EncodedText = [uri]::EscapeDataString($Text)
            $url = "$url" + "?text=$EncodedText&font=$FontName"
            # Perform Rest Call
            Invoke-RestMethod -Uri $url
        }
        catch
        {
            $ErrorMessage = $_.Exception.Message
            $FailedItem = $_.Exception.ItemName
            Throw "ConvertTo-AsciiArt: $ErrorMessage $FailedItem"
        }
    }
    else
    {
        # -WhatIf was used.
        return $false
    }
}