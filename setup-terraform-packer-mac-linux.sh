#!/usr/bin/env bash
TV=0.9.1
PV=0.12.3
MT=`uname -m`
MOS=`uname`

#Make the directories
mkdir -p /opt/local/terraform/$TV
mkdir -p /opt/local/packer/$PV

# Move in to the dir
cd /opt/local/terraform/$TV

#Check for machine type
# Download Terraform. URI: https://www.terraform.io/downloads.html

if [ "${MT}" == "i686" ] && [ "${MOS}" == "Linux" ]; then
printf  "This is 32-bit Linux\n"
printf "So we are installing the Linux 32 bit binary\n"
curl -O https://releases.hashicorp.com/terraform/{$TV}/terraform_{$TV}_linux_386.zip 
unzip terraform*.zip

elif [ "${MT}" == "x86_64" ] && [ "${MOS}" == "Linux" ]; then
printf "This is a 64-bit Linux\n"
printf "So we are installing the Linux 64 bit binary\n"
curl -O https://releases.hashicorp.com/terraform/{$TV}/terraform_{$TV}_linux_amd64.zip 
unzip terraform*.zip

elif [ "${MOS}" == "Darwin" ]; then
printf "This looks like a Mac\n"
printf "So we are installing the Darwin binary\n"
curl -O https://releases.hashicorp.com/terraform/{$TV}/terraform_{$TV}_darwin_amd64.zip
unzip terraform*.zip

else 
printf "OS type not found....\n"
fi

cd /opt/local/packer/$PV

# Download Packer. URI: https://www.packer.io/downloads.html

if [ "${MT}" == "i686" ] && [ "${MOS}" == "Linux" ]; then
echo "This is 32-bit Linux"
printf "So we are installing the Linux 32 bit binary\n"
curl -O https://releases.hashicorp.com/packer/{$PV}/packer_{$PV}_linux_386.zip 
unzip packer_*_linux_386.zip

elif [ "${MT}" == "x86_64" ] && [ "${MOS}" == "Linux" ]; then
printf "This is a 64-bit Linux\n"
printf "So we are installing the Linux 64 bit binary\n"
curl -O https://releases.hashicorp.com/packer/{$PV}/packer_{$PV}_linux_amd64.zip 
unzip packer_*_linux_amd64.zip

elif [ "${MOS}" == "Darwin" ]; then
printf "This looks like a Mac\n"
printf "So we are installing the Darwin binary\n"
curl -O https://releases.hashicorp.com/packer/{$PV}/packer_{$PV}_darwin_amd64.zip 
unzip packer_*_darwin_amd64.zip

else 
printf "OS type not found....\n"
fi

echo '
# Terraform & Packer Paths.
export PATH=/opt/local/terraform/'$TV'/:/opt/local/packer/'$PV'/:$PATH
' >>~/.bash_profile

source ~/.bash_profile

#Remove the zips 
rm /opt/local/terraform/*/*.zip 
rm /opt/local/packer/*/*.zip 

# verify we're all set to terraform and packer.
printf "Lets see if the binary's work by running them\n"
terraform
packer
