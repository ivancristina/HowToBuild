# local_manifest.xml

Local manifest for S4 Active International (GT-I9525)

##How to build

First of all create a folder where you want. I created mine in a subfolder inside my home. To do so, open your terminal and type
> mkdir CM14.1

Then enter in the folder just created
> cd CM.14.1

Now init the project, in this case the JDCTeam's project. To do so type in terminal
> repo init -u git://github.com/JDCTeam/manifests.git -b opt-cm-14.1

After this, you have to repo sync, with the command
> repo sync
It will take some time, it depends by your connection speed.
When it will finish, repo sync again (just for being sure).

Nautilus, CTRL+H, cd repo, mkdir local_manifests, copy mine

Repo sync again

Now, go to device/samsung/jf-common and open BoardConfigCommon.mk
Here, set the "BOARD_RECOVERYIMAGE_PARTITION_SIZE :=" to "11300000" or more, otherwise the build will fail.

Now, prepare yourself for the building itself. Type in the terminal

> export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX: +TieredCompilation -Xmx4g"

>./prebuilts/sdk/tools/jack-admin kill-server

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

Where * is the number of cores of your CPU (example: for 2 cores type `brunch launch -j2`)
