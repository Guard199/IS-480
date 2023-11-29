STIGS_CAT1_check.sh

###################################
This script will check for 5 CAT1 Vulnerabilities mentioned in STIGs for ubuntu and suggest possible fixes.
The script uses the following STIG group IDs:
1. V-251503
2. V-238201
3. V-238326
4. V-238327
5. V-238363
###################################
Github: https://github.com/Guard199/IS-480
###################################
Usage:

./STIG_CAT1_check.sh  # Run the Script
./STIG_CAT1_check.sh | grep -i "Detected" # Run the Script and print all findings
./STIG_CAT1_check.sh | grep -i "Missing"  # Run the Script and print all missing files
./STIG_CAT1_check.sh | grep -i "No"       # Run the Script and print all with no findings  
sudo ./STIG_CAT1_check.sh
