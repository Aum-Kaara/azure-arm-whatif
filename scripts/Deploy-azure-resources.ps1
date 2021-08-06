#Requires -Version 3.0

Param(
    [string] [Parameter(Mandatory=$true)] $ResourceGroupLocation,
    [string] $ResourceGroupName

)

    $TemplateFile = '../infra/whatif/azuredeploy.json'
    $TemplateParametersFile = '../infra/whatif/azuredeploy.parameters.json'

try {
    [Microsoft.Azure.Common.Authentication.AzureSession]::ClientFactory.AddUserAgent("VSAzureTools-$UI$($host.name)".replace(' ','_'), '3.0.0')
} catch { }

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version 3

$OptionalParameters = New-Object -TypeName Hashtable
$TemplateFile = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($PSScriptRoot, $TemplateFile))
$TemplateParametersFile = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($PSScriptRoot, $TemplateParametersFile))

$TemplateDeploymentResult = Get-AzResourceGroupDeploymentWhatIfResult `
                                -DeploymentName "deploy-01" `
                                -ResourceGroupName $ResourceGroupName `
                                -TemplateFile $TemplateFile `
                                -TemplateParameterFile $TemplateParametersFile `
                                -ResultFormat "FullResourcePayloads"


Write-Output '' + $TemplateDeploymentResult.Changes


