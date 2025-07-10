---
external help file: CreateLogs-help.xml
Module Name: CreateLogs
online version:
schema: 2.0.0
---

# ConvertFrom-Log

## SYNOPSIS
Convertit un fichier de log au format texte en objets PowerShell.

## SYNTAX

```
ConvertFrom-Log [-FilePath] <String> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
La fonction 'ConvertFrom-Log' lit un fichier texte contenant des lignes de logs formatées de type :
\`\[DATE\] ; \[CATEGORIE\] ; \[MESSAGE\]\`
Elle filtre uniquement les lignes valides (commençant par un crochet ouvrant), puis crée un objet
\`LogEntry\` pour chaque ligne.

La classe 'LogEntry' encapsule les informations d'un file de logs avec trois propriétés :
- Date : Date/heure du log
- Category : Catégorie (ex: Info, Warning, Error)
- Message : Contenu du message

La méthode '.ToString()' de la classe permet de reformater l'objet en ligne de log standard.

## EXAMPLES

### EXAMPLE 1
```
ConvertFrom-Log -FilePath 'C:\Labs\logs.txt'
```

## PARAMETERS

### -FilePath
{{ Fill FilePath Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
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

## NOTES
Le fichier d'entrée doit être au fromat suivant :
\[2025-07-09 10:00:00\] ; \[INFO\] ; \[Le script a démarré correctement\]
Les lignes qui ne sont pas formattées comme ceci seront ignorées.

## RELATED LINKS
