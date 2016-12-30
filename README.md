# local_manifest.xml

Local manifest for S4 Active International (GT-I9525)

##How to build

After repo syncing, go to device/samsung/jf-common and open BoardConfigCommon.mk
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

Where * is the number of cores of your CPU (example: 2 cores= `brunch launch -j2`)
