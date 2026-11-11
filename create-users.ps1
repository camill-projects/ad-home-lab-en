# Creates fictional users per department and adds them to GRP-<department>.
# IT gets 9 new users because the test user jan.kowalski already exists (10 total).
# Initial password is for lab use only; users must change it at first logon.

$first = "Adam","Anna","Piotr","Maria","Jan","Katarzyna","Tomasz","Agnieszka","Michal","Ewa","Pawel","Magdalena","Marcin","Joanna","Krzysztof","Monika","Lukasz","Dorota","Marek","Barbara"
$last  = "Nowak","Wisniewski","Wojcik","Kowalczyk","Kaminski","Lewandowski","Zielinski","Szymanski","Wozniak","Dabrowski","Kozlowski","Jankowski","Mazur","Kwiatkowski","Krawczyk","Piotrowski","Grabowski","Pawlowski","Michalski","Zajac"

$plan = [ordered]@{ IT=9; HR=10; Sales=30; Finance=15; Operations=25; Management=10 }
$pass = ConvertTo-SecureString "Welcome123!" -AsPlainText -Force
$i = 1

foreach ($dept in $plan.Keys) {
    for ($n = 0; $n -lt $plan[$dept]; $n++) {
        $f = $first[$i % $first.Count]
        $l = $last[($i * 7 + $n) % $last.Count]

        # SamAccountName is limited to 20 characters
        $sam = ("{0}.{1}{2}" -f $f.Substring(0,1), $l, $i).ToLower()
        if ($sam.Length -gt 20) { $sam = $sam.Substring(0,20) }

        New-ADUser -Name "$f $l $i" -GivenName $f -Surname $l -SamAccountName $sam `
            -Path "OU=$dept,OU=Firma,DC=firma,DC=local" -AccountPassword $pass `
            -Enabled $true -ChangePasswordAtLogon $true
        Add-ADGroupMember -Identity "GRP-$dept" -Members $sam
        $i++
    }
}
