Current version: 7240.2023.0102.1
Previous version: 7231.2022.1017-1

Command-Line Client's for Linux:

linux_f5cli.armhf.deb - Debian-based distribution on ARM architecture used mostly in mobile devices and netbooks. For example Ubuntu ARM, Debian ARM, and so on.
linux_f5cli.aarch64.deb - Debian-based distribution on aarch64 architecture used mostly in mobile devices and netbooks. For example Ubuntu aarch64, Debian aarch64, and so on.
linux_f5cli.x86_64.deb - Debian-based distributions. For example, Ubuntu, Debian, and so on.
linux_f5cli.x86_64.rpm - RPM-based distributions. For example, Fedora, CentOS, Redhat, and so on.

please uninstall the old installation first

Uninstallation:

old cli client:
sudo /usr/local/lib/F5Networks/uninstall_F5.sh or 

Debian-based uninstall:
sudo dpkg -l "f5c*"

sudo dpkg -r <package name> eg sudo dpkg -r f5cli

RPM-based uninstall:
sudo rpm -qa | grep f5cli

sudo rpm -e <package name> eg sudo rpm -e f5cli

Installation:

For Debian-based distributions, use the following command syntax to install the client:
dpkg -i <installer_filename>

For example:

dpkg -i linux_f5cli.x86_64.deb

For RPM-based distributions, enter the following command to install the client:
rpm –i linux_f5cli.x86_64.rpm

be careful and keep in mind the old install method and the old version's are no longer supported.

if you want to install the current version using the old method then do:
cd old-version
sudo ./Install.sh

if you want to install a older version from the archive then do:
cd old-version/archive/[versionsnumber] eg old-version/archive/7190.2020.0221.1
sudo ./Install.sh