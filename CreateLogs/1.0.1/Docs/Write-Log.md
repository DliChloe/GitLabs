---
external help file: CreateLogs-help.xml
Module Name: CreateLogs
online version:
schema: 2.0.0
---

# Write-Log

## SYNOPSIS
Ecris des logs dans un fichier

## SYNTAX

### Set2 (Default)
```
Write-Log [-Category] <String> [-Message] <String> [-ToScreen] -FilePath <String> [-Encoding <String>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Set1
```
Write-Log [-Header] [-ToScreen] -FilePath <String> [-Encoding <String>] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

### Set3
```
Write-Log [-ToScreen] -FilePath <String> [-Encoding <String>] [-Footer] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Le script va écrire les logs dans un fichier de sortie, et si demandé, 
il peut l'afficher à l'écran avec les couleurs correspondantes
au message (Info - Cyan, Warning - Yellow, Erreur - Red)

## EXAMPLES

### EXAMPLE 1
```
Write-Log -Header -FilePath 'C:\Temp\logs.txt'
```

### EXAMPLE 2
```
Write-Log -Category Information -Message 'not sure' -FilePath "C:\Temp\logs.txt" -Encoding UTF8
```

## PARAMETERS

### -Header
HEADER

```yaml
Type: SwitchParameter
Parameter Sets: Set1
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Category
NORMAL MODE

```yaml
Type: String
Parameter Sets: Set2
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Message
{{ Fill Message Description }}

```yaml
Type: String
Parameter Sets: Set2
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -ToScreen
COMMON PARAMETERS

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath
\[Alias\] $Path,

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Encoding
{{ Fill Encoding Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Footer
FOOTER

```yaml
Type: SwitchParameter
Parameter Sets: Set3
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.String
## NOTES

## RELATED LINKS
