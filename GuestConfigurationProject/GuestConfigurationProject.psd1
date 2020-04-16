@{

# Version number of this module.
ModuleVersion = '0.1.4'

# ID used to uniquely identify this module
GUID = 'acdc41db-bc70-4a5e-8ee6-cc038109f6ee'

# Author of this module
Author = 'Michael Greene'

# Company or vendor of this module
CompanyName = 'Microsoft Corporation'

# Copyright statement for this module
Copyright = '2019'

# Description of the functionality provided by this module
Description = 'A Plaster template for scaffolding projects to author custom Azure Policy Guest Configuration packages.'

# Minimum version of the PowerShell engine required by this module
PowerShellVersion = '5.1.0'

# Modules that must be imported into the global environment prior to importing this module
RequiredModules = @('Plaster',
               'Pester', 
               'GuestConfiguration')

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'Plaster', 'GuestConfiguration', 'AzurePolicy', 'GC', 'DSC'

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/microsoft/GuestConfigurationProject/blob/master/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/microsoft/GuestConfigurationProject/'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = 'https://github.com/microsoft/GuestConfigurationProject/blob/master/CHANGELOG.md'

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

} # End of PrivateData hashtable

}

