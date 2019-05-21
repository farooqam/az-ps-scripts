param(
        [Parameter(Mandatory=$true)]
        [string] $DisplayName,
        
        [Parameter(Mandatory=$true)]
        [string] $Password,

        [Parameter(Mandatory=$true)]
        [Guid] $SubscriptionId,

        [Parameter(Mandatory=$false)]
        [int] $ExpiresInDays = 90
)

$pw = ConvertTo-SecureString -String $Password -AsPlainText  -Force

$app = New-AzureRmADApplication `
    -DisplayName $DisplayName `
    -IdentifierUris $DisplayName `
    -HomePage $DisplayName `
    -Password $pw `
    -Verbose

New-AzureRmADServicePrincipal `
    -ApplicationId $app.ApplicationId `
    -DisplayName $DisplayName `
    -Password $pw `
    -Scope "/subscriptions/$($SubscriptionId)" `
    -Role Contributor `
    -StartDate ([datetime]::Now) `
    -EndDate $([datetime]::now.AddDays(90)) `
    -Verbose