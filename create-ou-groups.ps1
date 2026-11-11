# Creates the OU structure and one global security group per department.
# Run as Administrator on the domain controller (DC01).

$base = "DC=firma,DC=local"

# Top-level OU for the company
New-ADOrganizationalUnit -Name "Firma" -Path $base

$departments = "IT","HR","Sales","Finance","Operations","Management"

foreach ($d in $departments) {
    New-ADOrganizationalUnit -Name $d -Path "OU=Firma,$base"
    New-ADGroup -Name "GRP-$d" -GroupScope Global -GroupCategory Security -Path "OU=$d,OU=Firma,$base"
}
