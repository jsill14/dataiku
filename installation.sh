# https://doc.dataiku.com/dss/latest/installation/custom/initial-install.html
# Start from the home directory of user account "dataiku"
# which will be used to run the Data Science Studio
# We will install DSS using data directory: /home/dataiku/dss_data

#Check if locale is installed
locale -a | grep "en_US.utf8"
if [ $? -eq 1 ]; then
  echo 'updating locale' &&  sudo locale-gen en_US.utf8 && sudo update-locale
else
  echo ' locale already installed'
fi);

export VERSION = 9.0.0
pwd
/home/dataiku
ls -l

#-rw-rw-r-- 1 dataiku dataiku 159284660 Feb  4 15:20 dataiku-dss-$VERSION.tar.gz
#-r-------- 1 dataiku dataiku       786 Jan 31 07:42 license.json

# Unpack distribution kit
tar xzf dataiku-dss-$VERSION.tar.gz

# Run installer, with data directory $HOME/dss_data and base port 10000
# This fails because of missing system dependencies
dataiku-dss-$VERSION/installer.sh -d /home/dataiku/dss_data -l /home/dataiku/license.json -p 10000

# Install dependencies with elevated privileges, using the command shown by the previous step
sudo -i "/home/dataiku/dataiku-dss-$VERSION/scripts/install/install-deps.sh"

# Rerun installer script, which will succeed this time
dataiku-dss-$VERSION/installer.sh -d /home/dataiku/dss_data -l /home/dataiku/license.json -p 10000

# Configure boot-time startup, using the command shown by the previous step
sudo -i "/home/dataiku/dataiku-dss-$VERSION/scripts/install/install-boot.sh" "/home/dataiku/dss_data" dataiku

# Manually start DSS, using the command shown by the installer step
/home/dataiku/dss_data/bin/dss start

# Connect to Data Science Studio by opening the following URL in a web browser:
#    http://HOSTNAME:10000
# Initial credentials : username = "admin" / password = "admin"