class LogEntry {
    [DateTime]$Date
    [String]$Category
    [String]$Message

    #Constructeur
    LogEntry ([DateTime]$Date, [String]$Category, [String]$Message)
        {
        $this.Date = [DateTime]$Date
        $this.Category = [String]$Category
        $this.Message = [String]$Message
    }

    # Retrouner la valeur de la fonction 'ConvertFrom-Log'
    [string]ToString() {
        return "[{0}] [{1}] [{2}]" -f $this.Date, $this.Category, $this.Message
    }
}


function Write-Log {

 <#
.SYNOPSIS
   Ecris des logs dans un fichier
.DESCRIPTION
   Le script va écrire les logs dans un fichier de sortie, et si demandé, 
   il peut l'afficher à l'écran avec les couleurs correspondantes
   au message (Info - Cyan, Warning - Yellow, Erreur - Red)
.EXAMPLE
   Write-Log -Header -FilePath 'C:\Temp\logs.txt'
.EXAMPLE
   Write-Log -Category Information -Message 'not sure' -FilePath "C:\Temp\logs.txt" -Encoding UTF8
#>

    [CmdletBinding(DefaultParameterSetName='Set2', 
                  PositionalBinding=$true,
                  HelpUri = 'http://www.microsoft.com/')]
    [OutputType([String])]
    Param
    (
        ## HEADER
        [Parameter(Mandatory, ParameterSetName='Set1')]
        [switch]$Header,


        ## NORMAL MODE
        [Parameter(Mandatory, ParameterSetName='Set2', Position = 0)]
        [ValidateSet("Information", "Warning", "Error")]
        [string]$Category,

        [Parameter(Mandatory, ParameterSetName='Set2', Position = 1, ValuefromPipeline)]
        [string]$Message,


        ## COMMON PARAMETERS
        [switch]$ToScreen,

        [Parameter(Mandatory)]
        #[Alias] $Path,
        [string]$FilePath,

        [Parameter(Mandatory=$false)]
        [ValidateSet("UTF8", "UTF16")]
        [string]$Encoding,
        

        ## FOOTER
        [Parameter(Mandatory, ParameterSetName='Set3')]
        [switch]$Footer

    )

    #$PSDefaultParameterValues['*:Encoding'] = 'utf8BOM'
    [string]$Username = $env:COMPUTERNAME +'\' + $env:USERNAME
    [string]$CurrentDate = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    [string]$ComputerName = $env:COMPUTERNAME
    [CimInstance]$computerOS = Get-CimInstance CIM_OperatingSystem -ComputerName $computer
    [string]$OS = "$($computerOS.Caption), Service Pack: $($computerOS.ServicePackMajorVersion)"
    [string]$OSArchitecture = $computerOS.OSArchitecture
    [char]$Delimiter = ';'
    [HashTable]$HashTable = @{
                Information = 'Cyan'
                Warning = 'Yellow'
                Error = 'Red'
                }

    Switch ($PSCmdlet.ParameterSetName) {
        'Set1' {

              [string]$head = 
@'
+----------------------------------------------------------------------------------------+
Script fullname          : {0}
When generated           : {1}
Current user             : {2}
Current computer         : {3}
Operating System         : {4}
OS Architecture          : {5}
+----------------------------------------------------------------------------------------+    
'@ -f $PSCommandPath, $CurrentDate, $UserName,$ComputerName,$OS,$OSArchitecture
           $head | Out-File $FilePath
        if ($ToScreen) {
            Write-Host $head
            }
        }

        'Set2' {

            [string]$messageformatted = '[{0}]{3}[{1}]{3}{2}' -f $CurrentDate, $Category, $Message, $Delimiter
            $messageformatted | Out-File $FilePath -Append
            if ($ToScreen) {
                Write-Host $messageformatted -ForegroundColor $HashTable[$Category]
            }
            
        }

        'Set3' { 
            [string[]]$file = Get-Content $FilePath
            if ($file | Where-Object {$_ -match 'When generated\s+:\s{1}(?<Date>.+)'}) {
            [DateTime]$StartDate = $Matches.Date -as [datetime]
            [TimeSpan]$totalduration = (Get-Date) - $StartDate
            [Int]$Minuts = $totalduration.Minutes
            [Int]$Seconds = $totalduration.Seconds
            }
            [string] $Foot =
@'
+----------------------------------------------------------------------------------------+
End time                 : {0}
Total duration (minutes) : {1}
Total duration (secondes) : {2}
+----------------------------------------------------------------------------------------+
'@ -f (Get-Date), $Minuts, $Seconds

            $Foot | Out-File $FilePath -Append
            if ($ToScreen) {
                Write-Host $Foot
            } 
        } 
    } # End Switch
}


function ConvertFrom-Log {

<#
.SYNOPSIS
   Convertit un fichier de log au format texte en objets PowerShell.

.DESCRIPTION
   La fonction 'ConvertFrom-Log' lit un fichier texte contenant des lignes de logs formatées de type :
   `[DATE] ; [CATEGORIE] ; [MESSAGE]`
   Elle filtre uniquement les lignes valides (commençant par un crochet ouvrant), puis crée un objet
   `LogEntry` pour chaque ligne.

   La classe 'LogEntry' encapsule les informations d'un file de logs avec trois propriétés :
   - Date : Date/heure du log
   - Category : Catégorie (ex: Info, Warning, Error)
   - Message : Contenu du message

   La méthode '.ToString()' de la classe permet de reformater l'objet en ligne de log standard.

.EXAMPLE
   ConvertFrom-Log -FilePath 'C:\Labs\logs.txt'

.NOTES
   Le fichier d'entrée doit être au fromat suivant :
   [2025-07-09 10:00:00] ; [INFO] ; [Le script a démarré correctement]
   Les lignes qui ne sont pas formattées comme ceci seront ignorées.
#>

    param(
        [Parameter(Mandatory)]
        [ValidateScript({Test-Path $_})]
        [string] $FilePath
        )
       
        $object = Get-Content -Path $FilePath
        $LogEntry = @()

        $lines = $object | Where-Object {$_ -match '^\['}

        foreach ($line in $lines) {
            $entry = $line.Split(';')
            $Date = $entry[0].Trim('[', ']')
            $Category = $entry[1].Trim('[', ']')
            $Message = $entry[2].Trim('[', ']')

            <#
            # Sortie via la fonction
            $LogEntry += [PSCustomObject]@{
                'Date' = [DateTime]$date
                'Category' = [String]$cat
                'Message' = [String]$msg
            }
            #>
            
            # Sortie via la classe
            [LogEntry]::new($Date, $Category, $Message)
        }
        # Afficher les results de la fonction dans le prompt
        #$LogEntry
}
