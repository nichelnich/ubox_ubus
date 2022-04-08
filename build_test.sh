#!/bin/sh

TOPDIR=$PWD
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$TOPDIR/output/lib/pkgconfig"

build_jsonc()
{
cd $TOPDIR/json-c-0.12.1
autoreconf -ivf || exit 0
./configure --prefix=$TOPDIR/output CFLAGS="-Wno-implicit-fallthrough" || exit 0
make || exit 0
make install || exit 0
cd $TOPDIR/output/include
ln -s json-c json 
}

build_libubox()
{
mkdir -p $TOPDIR/libubox/build
cd $TOPDIR/libubox/build
cmake -DCMAKE_INSTALL_PREFIX=$TOPDIR/output -DBUILD_LUA=OFF .. || exit 0
make || exit 0
make install || exit 0
}

build_ubus()
{
mkdir -p $TOPDIR/ubus/build
cd $TOPDIR/ubus/build
cmake -DCMAKE_INSTALL_PREFIX=$TOPDIR/output -DBUILD_LUA=OFF -DENABLE_SYSTEMD=OFF .. || exit 0
make || exit 0
make install || exit 0
}

build_uci()
{
mkdir -p $TOPDIR/uci/build
cd $TOPDIR/uci/build
cmake -DCMAKE_INSTALL_PREFIX=$TOPDIR/output -DBUILD_LUA=OFF .. || exit 0
make || exit 0
make install || exit 0
}


build_jsonc
build_libubox
build_uci
build_ubus
