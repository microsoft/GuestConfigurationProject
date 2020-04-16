$errorActionPreference = 'Stop'
Set-StrictMode -Version 'Latest'

$script:moduleName = '<%=$PLASTER_PARAM_ProjectName%>'

Describe "<%=$PLASTER_PARAM_ProjectName%> Tests" {

    BeforeAll {
        $resourceModulePath = Join-Path -Path (Split-Path $PSScriptRoot -Parent) -ChildPath "Modules\<%=$PLASTER_PARAM_ProjectName%>\DscResources\<%=$PLASTER_PARAM_ProjectName%>\<%=$PLASTER_PARAM_ProjectName%>.psm1"
        Import-Module -Name $resourceModulePath -Force
    }

    InModuleScope '<%=$PLASTER_PARAM_ProjectName%>' {

        Context 'module manifest' {

            It 'Has a PowerShell module manifest that meets functional requirements' {
                Test-ModuleManifest -Path .\Modules\<%=$PLASTER_PARAM_ProjectName%>\<%=$PLASTER_PARAM_ProjectName%>.psd1 | Should Not BeNullOrEmpty
                $? | Should Be $true
            }
        }

        Context "<%=$PLASTER_PARAM_ProjectName%>\Get-Function1" {

            Context 'a simple function that gets information and formats it for Get-TargetResource' {

                BeforeAll {
                    $function1 = Get-Function1 -Property 'Value'
                }

                It 'Should return a hashtable that can be used by Get/Test' {
                    $function1 | Should -BeOfType 'Hashtable'
                }

                It 'Should have status of true' {
                    $function1.status | Should -BeTrue
                }

                It 'Should not have Reasons' {
                    $function1.reasons | Should -BeNullOrEmpty
                }
            }
        }

        Context "<%=$PLASTER_PARAM_ProjectName%>\Set-TargetResource" {

            It 'Should always throw' {
                { Set-TargetResource -Property 'Value' } | Should Throw
            }
        }

        Context 'when the system is in the desired state' {

            BeforeAll {
                Mock Get-Function1 { new-object -TypeName PSObject -Property @{
                        status  = $true
                        reasons = @()
                    } } -Verifiable
            }

            Context "<%=$PLASTER_PARAM_ProjectName%>\Get-TargetResource" {
                $get = Get-TargetResource -Property 'Value'

                It 'Should call the function that returns information' {
                    Assert-MockCalled Get-Function1
                }

                It 'Should return status as true' {
                    $get.status | Should -BeTrue
                }

                It 'Should return an empty array for the property Reasons' {
                    $get.reasons | Should -Be $null
                }
            }

            Context "<%=$PLASTER_PARAM_ProjectName%>\Test-TargetResource" {
                $test = Test-TargetResource -Property 'Value'

                It 'Should call the function that returns information' {
                    Assert-MockCalled Get-Function1
                }

                It 'Should pass Test' {
                    $test | Should -BeTrue
                }
            }
        }

        Context 'when the system is not in the desired state' {

            BeforeAll {
                Mock Get-Function1 { new-object -TypeName PSObject -Property @{
                        status  = $false
                        reasons = @(@{Code = "$script:moduleName:$script:moduleName:ReasonCode"; Phrase = 'test phrase' })
                    } } -Verifiable
            }

            Context "<%=$PLASTER_PARAM_ProjectName%>\Get-TargetResource" {
                $get = Get-TargetResource -Property 'Value'

                It 'Should call the function that returns information' {
                    Assert-MockCalled Get-Function1
                }

                It 'Should return status as true' {
                    $get.status | Should -BeFalse
                }

                It 'Should return a hashtable for the property Reasons' {
                    $get.Reasons | Should -BeOfType 'Hashtable'
                }

                It 'Should have at least one reasons code' {
                    $get.reasons[0] | ForEach-Object Code | Should -BeOfType 'String'
                    $get.reasons[0] | ForEach-Object Code | Should -Match "$script:moduleName:$script:moduleName:"
                }

                It 'Should have at least one reasons phrase' {
                    $get.reasons | ForEach-Object Phrase | Should -BeOfType 'String'
                }
            }

            Context "<%=$PLASTER_PARAM_ProjectName%>\Test-TargetResource" {
                $test = Test-TargetResource -Property 'Value'

                It 'Should call the function that returns information' {
                    Assert-MockCalled Get-Function1
                }

                It 'Should fail Test' {
                    $test | Should -BeFalse
                }

            }
        }
    }
}
