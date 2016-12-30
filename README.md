# local_manifest.xml

Local manifest for S4 Active International (GT-I9525)

##How to build

###Setup the machine

Download any Debian based distro, burn it in a USB and install it or just create a virtual machine.
I advice you to install Ubuntu 16.04 Xenial. Don't install it on virtual machine if you've got a low specs PC.

Now, open a terminal and write the commands
> sudo apt-add-repository ppa:openjdk-r/ppa -y

> sudo apt update -y

> sudo apt install git-core python gnupg flex bison gperf libsdl1.2-dev libesd0-dev \ squashfs-tools build-essential zip curl libncurses5-dev zlib1g-dev openjdk-8-jre openjdk-8-jdk pngcrush \ schedtool libxml2 libxml2-utils xsltproc lzop libc6-dev schedtool g++-multilib lib32ncurses5-dev \ gcc-multilib liblz4-* pngquant ncurses-dev texinfo gcc gperf patch libtool \ automake g++ gawk subversion expat libexpat1-dev python-all-dev bc libcloog-isl-dev \ libcap-dev autoconf libgmp-dev build-essential gcc-multilib g++-multilib pkg-config libmpc-dev libmpfr-dev lzma* \ liblzma* w3m android-tools-adb maven ncftp htop repo lib32z1-dev -y

If `lib32z1-dev` causes `error code (1)`, just remove it.

Now, you successfully setted up your building machine.

###Manage your repos

First of all create a folder where you want. I created mine in a subfolder inside my home. To do so, open your terminal and type `mkdir CM14.1` or change `CM14.1` to whatever you want.

Then enter in the folder just created with `cd CM.14.1` or `cd nameofthefolder`

Now init the project, in this case I'll use the JDCTeam's project. To do so type in terminal
> repo init -u git://github.com/JDCTeam/manifests.git -b opt-cm-14.1

After this, you have to repo sync, with the command
> repo sync

It will take some hours, it depends by your connection speed.
When it will finish, repo sync again (just for being sure).

Now open any file manager (if you're on Ubuntu, it will be Nautilus), press CTRL+H, open the folder .repo, create a new folder called "local_manifests", open put my local_manifest.xml there.
Repo sync again.
If there are some duplicates, just comment them. To do so, put `!--` and `--` respectively before and after the duplicate paths.
So `<project *blablablahere* />` would become `<!--project *blablablahere* /-->`


Now, go to `CM14.1/device/samsung/jf-common` and open BoardConfigCommon.mk
Here, set the `BOARD_RECOVERYIMAGE_PARTITION_SIZE :=` to `11300000` or more, otherwise the build will fail.

###Building the ROM

Now, prepare yourself for the building itself. Type in the terminal
> export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX: +TieredCompilation -Xmx4g"

> ./prebuilts/sdk/tools/jack-admin kill-server

> ./prebuilts/sdk/tools/jack-admin start-server

> . build/envsetup.sh

> lunch cm_jactivelte

If it fail, don't mind. Type
> ./prebuilts/sdk/tools/jack-admin kill-server

> rm -rf /home/"yournamehere"/.jack-server

> export USE_PREBUILT_CACHE=1

> export ANDROID_JACK_VM_ARGS="-Xmx3g -Dfile.encoding=UTF-8 -XX:+TieredCompilation"

> croot

> brunch launch -j*

Where `*` is the number of cores of your CPU (example: for 2 cores type `brunch launch -j2`)

Now wait some hours (or some minutes if your PC is a beast), and you'll get your ready-to-flash ROM zip!
