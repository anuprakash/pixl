#!/bin/bash

# variables
TMP_DIR='/tmp/pixl_build'
INCLUDE_DIR='usr/include/pixl'
BIN_DIR='usr/bin'
LIB_DIR='usr/lib'

# build
cd ../../
cmake -DCMAKE_BUILD_TYPE=Release
make pixl pixl-cli

# create temporary build folder
mkdir -p $TMP_DIR/pixl
mkdir -p $TMP_DIR/pixl/usr/lib
mkdir -p $TMP_DIR/pixl/usr/bin
mkdir -p $TMP_DIR/pixl/usr/include/pixl

# copy descirptor file
cp -r pkg/debian/DEBIAN $TMP_DIR/pixl/
# copy shared library
install libpixl.so $TMP_DIR/pixl/$LIB_DIR
# copy tool
install bin/pixl-cli $TMP_DIR/pixl/$BIN_DIR/pixl
# copy header files
install src/pixl/pixl.h $TMP_DIR/pixl/$INCLUDE_DIR
install src/pixl/debug.h $TMP_DIR/pixl/$INCLUDE_DIR
install src/pixl/errors.h $TMP_DIR/pixl/$INCLUDE_DIR
install src/pixl/image.h $TMP_DIR/pixl/$INCLUDE_DIR
install src/pixl/io.h $TMP_DIR/pixl/$INCLUDE_DIR
install src/pixl/operations.h $TMP_DIR/pixl/$INCLUDE_DIR
install src/pixl/types.h $TMP_DIR/pixl/$INCLUDE_DIR
install src/pixl/utils.h $TMP_DIR/pixl/$INCLUDE_DIR

# build .db package
dpkg --build $TMP_DIR/pixl
cp $TMP_DIR/pixl.deb pkg/debian/pixl-0.1.0a.deb