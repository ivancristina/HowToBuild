# Local Manifest

Local manifest for S4 Active International (GT-I9525)

##How to build

###Setup the machine

Download any Debian based distro, burn it in a USB and install it or just create a virtual machine.
I advice you to install Ubuntu 16.04 Xenial. Don't install it on virtual machine if you've got a low specs PC.

Now, open a terminal and write the command:

	$ sudo apt-add-repository ppa:openjdk-r/ppa -y; sudo apt update -y; sudo apt install git-core python gnupg flex bison gperf libsdl1.2-dev libesd0-dev \
	squashfs-tools build-essential zip curl libncurses5-dev zlib1g-dev openjdk-8-jre openjdk-8-jdk pngcrush \
	schedtool libxml2 libxml2-utils xsltproc lzop libc6-dev schedtool g++-multilib lib32ncurses5-dev \
	gcc-multilib liblz4-* pngquant ncurses-dev texinfo gcc gperf patch libtool \
	automake g++ gawk subversion expat libexpat1-dev python-all-dev bc libcloog-isl-dev \
	libcap-dev autoconf libgmp-dev build-essential gcc-multilib g++-multilib pkg-config libmpc-dev libmpfr-dev lzma* \
	liblzma* w3m android-tools-adb maven ncftp htop repo lib32z1-dev -y

Note that this one is a SINGLE giant command. There isn't any wrap between. Once you did it, do it again.
If some package like `lib32z1-dev` causes `error code (1)`, just remove it from the command. Note that it could compromise the build, if it's an important one. I'd advice you to Google it for solving.

Now, you successfully setted up your building machine.

###Manage your repos

First of all we need to setup the repo binary, with the commands:

     $ mkdir ~/bin
     $ PATH=~/bin:$PATH
     $ curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
     $ chmod a+x ~/bin/repo

Now create a folder for the sources where you want. I created mine in a subfolder inside my home. To do so, open your terminal and type 

     $ mkdir LOS
Or change `LOS` to whatever you want.
Then enter in the folder just created with:

     $ cd "FOLDER NAME"

You have now to configure your github account. To do so:

	 $ git config --global user.name "YOUR NAME" 
	 $ git config --global user.email "YOUR EMAIL ADDRESS"

Now init the project, in this case I'll use the JDCTeam's project. To do so type in terminal
> repo init -u git://github.com/JDCTeam/manifests.git -b opt-cm-14.1

If you want to repo sync RR
> repo init -u https://github.com/ResurrectionRemix/platform_manifest.git -b nougat

Instead, for clean LienageOS
> repo init -u git://github.com/LineageOS/android.git -b cm-14.1

After this, you have to repo sync, with the command
> repo sync

It will take some hours, it depends by your connection speed.
When it will finish, repo sync again (just for being sure).

Now open any file manager (if you're on Ubuntu, it will be Nautilus), press CTRL+H, open the folder .repo, create a new folder called "local_manifests", open put my local_manifest.xml there.
Repo sync again.
If there are some duplicates, just comment them. To do so, put `!--` and `--` respectively before and after the duplicate paths.
So `<project *blablablahere* />` would become `<!--project *blablablahere* /-->`


Now, go to `LOS/device/samsung/jf-common` and open `BoardConfigCommon.mk`
Here, if `BOARD_RECOVERYIMAGE_PARTITION_SIZE :=` is not set to `11300000` or more, change it, otherwise the build will fail.

###Setting Ccache

This step should improve the building speed, but it require some space (just like a cache, considering that it IS a cache).

        $ echo "export USE_CCACHE=1" >> ~/.bashrc
        $ ~/RR/prebuilts/misc/linux-x86/ccache/ccache -M 100G

If you don't have so much space, I advice you to give 50G instead of 100G. Less is useless IMHO.

###Configure the repos

CyanogenMod (RIP) left the show to LineageOS. Unfortunately someone still didn't notice it. The sources, indeed, could still be setted up for CyanogenMod. Don't mind, it's not that difficult, we could solve together.

In terminal type:

        $ cd LOS/device/samsung
        $ ls
        
You should see `jactivelte`, `jf-common` and `qcom-common`. Well, if you don't, you missed some step. Now, open these folders. Rename any `cm.dependencies` into `lineage.dependencies`, without editing anything.
If there is `cm.mk` too (but it shouldn't), rename it `lineage.mk`, then open it and at the bottom replace `cm_jactivelte` with `lineage_jactivelte`.


###Building the ROM

Now, prepare yourself for the building itself. Type in the terminal:

        $ sudo -s

Write your password and press enter. This will enable the root access to every command. Type:

        $ export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX: +TiePurpleCompilation -Xmx4g"
        $ . build/envsetup.sh
        $ ./prebuilts/sdk/tools/jack-admin kill-server
        $ rm -rf /home/"yournamehere"/.jack-server
        $ export USE_PREBUILT_CACHE=1
        $ export ANDROID_JACK_VM_ARGS="-Xmx3g -Dfile.encoding=UTF-8 -XX:+TiePurpleCompilation"
        $ croot
        $ brunch jactivelte

Now wait some hours (or some minutes if your PC is a beast), and you'll get your ready-to-flash ROM zip!
You can find it in `home/LOS/out/target/product/jactivelte`

If you want to build again, with updated sources:

      $ make clean
      $ repo sync --force-sync
      $ . build/envsetup.sh && brunch jactivelte
      
Remember to put in your credit EVERYONE who helped you or provided you the sources, like CyanogenMod, LineageOS, XOSP, RR and so on and so on.

Remember also that if you want to publish a ROM, you also have to publish the sources, if you made some commits.

Have fun compiling!
