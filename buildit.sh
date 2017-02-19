#!/bin/bash

#
# Usage: ./buildit.sh
#


# Tell the environment not to use NINJA
#	export USE_NINJA=false

# Delete the JACK server located in /home/<USER>/.jack*
	rm -rf ~/.jack*

# Resize the JACK Heap size
	export ANDROID_JACK_VM_ARGS="-Xmx4g -Dfile.encoding=UTF-8 -XX:+TieredCompilation"

# Restart the JACK server
	./prebuilts/sdk/tools/jack-admin kill-server
	./prebuilts/sdk/tools/jack-admin start-server

# Optionally, you may want to clear CCACHE if you still have issues
	export USE_PREBUILT_CACHE=1
	ccache -C

# Make a clean build, building dirty after you have had jack issues may result in a failed build
	make clean
	rm -rf /home/ivan/RR/out
	echo Removed out directory.

# Compile the build
	make bootimage
