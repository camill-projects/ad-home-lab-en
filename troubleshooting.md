# Troubleshooting log

## 1. VM booted into the installer again after installation
- **Symptom:** After the install finished, the VM showed the Windows Setup screen again.
- **Cause:** I pressed a key at "Press any key to boot from CD or DVD", so the VM booted from the ISO again.
- **Fix:** Powered off the VM, removed the ISO from the virtual optical drive (Settings, Storage) and started it again. It booted from disk.

## 2. Black screen with frozen dots on first boot after DC promotion
- **Symptom:** The VM seemed frozen on the Windows loading screen for many minutes.
- **Cause:** The first boot after promoting a server to a domain controller is very slow (AD and DNS initialization).
- **Fix:** Waited. It recovered on its own. Lesson: do not reset during this first boot.

## 3. Typo in a PowerShell cmdlet
- **Symptom:** `Get -ADDomain` returned `CommandNotFoundException`.
- **Cause:** A space instead of a hyphen in the cmdlet name.
- **Fix:** `Get-ADDomain`.

## 4. Cannot paste commands into the VM
- **Cause:** Shared clipboard does not work without Guest Additions.
- **Fix:** Installed Guest Additions and set Devices, Shared Clipboard, Bidirectional.

## 5. User accounts not created: "not a properly formed account name"
- **Symptom:** The bulk script created 91 of 100 users. Errors: `The name provided is not a properly formed account name` and `Cannot find an object with identity`.
- **Cause:** `SamAccountName` is limited to 20 characters. Long first name + surname + number exceeded it, so those accounts failed, and adding them to groups failed afterwards.
- **Fix:** Shortened the login format (first letter of the first name + surname + number, capped at 20 characters).

## 6. Duplicate accounts (191 instead of 101)
- **Symptom:** After re-running the corrected script there were 191 users.
- **Cause:** The login format changed, so the "does the user already exist" check did not recognize the old accounts and created everyone again.
- **Fix:** Removed all users in the Firma OU except the test user with `Remove-ADUser`, then ran one corrected script. Final count: 100.
- **Lesson:** Test scripts on a few users first and take snapshots before bulk changes.

## 7. PowerShell ParserError: "Variable reference is not valid. ':' was not followed by a valid variable name character"
- **Symptom:** A loop using `"FIRMA\GRP-$d:(OI)(CI)M"` failed with `InvalidVariableReferenceWithDrive` and nothing was created.
- **Cause:** In a double-quoted string, `$d:` is parsed as a drive-qualified variable (like `$env:PATH`).
- **Fix:** Delimit the variable name with braces: `${d}:`.

## 8. Windows 10 client constantly at 100% CPU after installation
- **Symptom:** CLIENT01 was very slow right after installation, the CPU stayed at 100%.
- **Cause:** A fresh Windows 10 runs background tasks for a while (Windows Update, Defender scans, indexing), and the VM had only 2 vCPUs.
- **Fix:** Shut the VM down properly, raised the CPU count to 4 in VirtualBox (Settings, System, Processor) and waited until the background activity finished.
