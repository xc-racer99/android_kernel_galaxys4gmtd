#!/bin/bash

# AntonX

# Before building, create kernel config by executing command:
# $./build.sh -config

# Use "$./build.sh -clean" to kill old .o

# change to your initramfs

INITRAMFS="/home/anton/SGS4G/initramfs"

# change to your toolchain

CROSS_COMPILE=/home/anton/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-

#

CPU_NUMBER=`grep 'processor' /proc/cpuinfo | wc -l`

#

BUILD_DIR="./"


##############################################################################

if [ "$1" == "-config" ] ; then
  KCONFIG=vibrantplus_antsvx_defconfig
  echo Creating $KCONFIG config...
  make $KCONFIG
  exit 0
fi

if [ "$1" == "-clean" ] ; then
  echo Cleaning project...
  rm $(find $BUILD_DIR -name '*.ko')
  rm $(find $BUILD_DIR -name '*.o')
  exit 0
fi

COMPILEONLY=0

if [ "$1" == "-co" ] ; then # compile only
  echo Compilinig only, no initramfs.
  COMPILEONLY=1
fi

#


TMP_INITRAMFS="/tmp/sgs4g_initramfs"

if [ ! -e $TMP_INITRAMFS ] ; then
  mkdir $TMP_INITRAMFS > /dev/null 2>&1
fi

# some cleanup

if [ $COMPILEONLY == 0 ] ; then
  echo Cleaning previous build...
  rm $(find $BUILD_DIR -name '*.ko')
fi

# run the build

echo Building...

make -j$CPU_NUMBER CROSS_COMPILE=$CROSS_COMPILE

#

if [ $COMPILEONLY == 0 ] ; then

  # replace kernel objects with newly build files

  echo Preparing initramfs...

  rm -rf "$TMP_INITRAMFS"
  cp -rf "$INITRAMFS" "$TMP_INITRAMFS"
  find "$TMP_INITRAMFS" -name '\.git' -o -name '\.gitignore' -o -name 'EMPTY_DIRECTORY' | xargs rm -rf

  echo Populating initramfs with updated kernel objects...

  cp $(find $BUILD_DIR -name '*.ko') $TMP_INITRAMFS/lib/modules/
  cp $(find $BUILD_DIR -name '*.ko') $INITRAMFS/lib/modules/

  rm -rf $BUILD_DIR/usr/{built-in.o,initramfs_data.{o,cpio*}}
  rm $BUILD_DIR/arch/arm/boot/Image > /dev/null 2>&1
  rm $BUILD_DIR/arch/arm/boot/zImage > /dev/null 2>&1

  # run make again to build zImage with latest kernel objects

  echo Rebuilding zImage...

  make -j$CPU_NUMBER CROSS_COMPILE=$CROSS_COMPILE

fi

echo Done.
