# Creates one network share per department, accessible only to the department's security group.
# Run as Administrator on the domain controller (DC01).

$departments = "IT","HR","Sales","Finance","Operations","Management"

foreach ($d in $departments) {
    New-Item -Path "C:\Shares\$d" -ItemType Directory -Force
    New-SmbShare -Name $d -Path "C:\Shares\$d" -FullAccess "FIRMA\GRP-$d"

    # NTFS permissions: remove inheritance, group = Modify, Administrators and SYSTEM = Full Control.
    # ${d} is needed because "$d:" would be parsed as a drive-qualified variable.
    icacls "C:\Shares\$d" /inheritance:r /grant "FIRMA\GRP-${d}:(OI)(CI)M" "BUILTIN\Administrators:(OI)(CI)F" "SYSTEM:(OI)(CI)F"
}
