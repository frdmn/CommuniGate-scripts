CommuniGate scripts
================================

This repository contains scripts for the CommuniGate Pro mail server system.

* listAndVerifyPasswords.pl
* bulkUpdatePasswords.pl

### Explanation

#### listAndVerifyPasswords.pl

This script lists all accounts and their specific (plain-text if possible) passwords.

#### bulkUpdatePasswords.pl

This script is useful, in case you updated the default password encryption method. It will update every single e-mail account with the current password. This way you can bulk update the password encryption method for ALL exisiting accounts.

### Installation

* Clone this repository
* Adjust the credential variables in the script
* Run it
