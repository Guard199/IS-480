#!/bin/bash

# Author: Seth Jablonowski
# IS 480
# 11/9/2023

#################################################################
# This script will check for 5 CAT1 Vulnerabilities mentioned in STIGs for ubuntu and suggest possbile fixes.
#################################################################

# V-251503
echo "(V-251503) Checking the /etc/shadow file for blank passwords"
q=$(sudo awk -F: '!$2 {print $1}' /etc/shadow)

if [ -n "$q" ]; then
	echo "Finding Detected! (V-251503)"
	read -p "Would you like to fix this with a password reset? (y/n): " answer
	if [ $answer == "y" ]; then
		sudo passwd
	else
		echo "Skipping the password reset."
	fi
else
	echo "No Findings (V-251503)"
fi

# V-238201 
echo "(V-238201) Verifying that use_mappers is set to pwent in /etc/pam_pkcs11/pam_pkcs11.conf file"
q=$(grep use_mappers /etc/pam_pkcs11/pam_pkcs11.conf 2>/dev/null)
p="/etc/pam_pkcs11/pam_pkcs11.conf"
a="use_mappers = pwent"
if [ ! -e "$p" ]; then
	echo "File Missing! (V-238201)"
else
	if [ "$q" == "$a" ]; then
		echo "No Findings (V-238201)"
	else
		echo "Finding Detected! (V-238201)"
	fi
fi

# V-238326
echo "(V-238326) Verifying that the telnet package is not installed on the Ubuntu operating system"
dpkg -l | grep telnetd | sed "s/ //" > temp.txt
if [ -n temp.txt ]; then
	echo "No Findings (V-238326)"
else
	echo "Finding Detected! (V-238326)"
	read -p "Would you like to fix this by removing the telnet package? (y/n): " answer
	if [ $answer == "y" ]; then
		sudo apt-get remove telnetd
	else
		echo "The telnet package was not removed from the ubuntu system!"
	fi
fi
rm temp.txt

# V-238327
echo "(V-238327) Verifying the rsh-server package is installed"
dpkg -l | grep rsh-server > temp.txt
if [ -n temp.txt ]; then
	echo "No Findings (V-238327)"
else
	echo "Finding Detected! (V-238327)"
	read -p "Would you like to fix this by removing the rsh-server package? (y/n): " answer
	if [ $answer == "y" ]; then
		sudo apt-get remove rsh-server
	else
		echo "rsh-server package was not removed!"
	fi
fi
rm temp.txt

# V-238363
echo "(V-238363) Verifying the system is configured to run in FIPS mode"
q=$(grep -i 1 /proc/sys/crypto/fips_enabled 2>/dev/null)
p="/proc/sys/crpyto/fips_enabled"
a="1"

if [ ! -e "$p" ]; then
	echo "File Missing! (V-238363)"
else
	if [ "$q" == "$a" ]; then
		echo "No Findings (V-238363)"
	else
		echo "Finding Detected (V-238363)"
		read -p "Would you like to fix this by configuring the system to run in FIPS mode? (y/n): " answer
		if [ $answer == "y" ]; then
			echo "Please follow the Ubuntu Server 18.04 FIPS 140-2 security policy document instructions"
		else
			echo  "FIPS mode has not been enabled!"
		fi
	fi
fi

