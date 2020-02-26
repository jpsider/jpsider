---
external help file: jpsider-help.xml
Module Name: jpsider
online version: http://www.invoke-automation.blog
schema: 2.0.0
---

# Open-ConsoleWindow

## SYNOPSIS
Opens a specified number of Console Windows.

## SYNTAX

```
Open-ConsoleWindow [-Count] <Int32> [[-Executable] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Opens a specified number of Console Windows.

## EXAMPLES

### EXAMPLE 1
```
Open-ConsoleWindow -Count 2 -Executable PowerShell.exe
```

### EXAMPLE 2
```
Open-ConsoleWindow -Count 2 -Executable pwsh.exe
```

## PARAMETERS

### -Count
Please provide a new Console Title.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Executable
Please provide an Executable.
(Powershell.exe is default)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: PowerShell.exe
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String

### System.Boolean

## NOTES
none

## RELATED LINKS

[http://www.invoke-automation.blog](http://www.invoke-automation.blog)

