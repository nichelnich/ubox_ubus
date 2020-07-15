#!/bin/sh

TOPDIR=$PWD
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$TOPDIR/output/lib/pkgconfig"

build_jsonc()
{
cd $TOPDIR/json-c-0.12.1
autoreconf -ivf
./configure --prefix=$TOPDIR/output
make
make install
cd $TOPDIR/output/include
ln -s json-c json 
}

build_libubox()
{
mkdir -p $TOPDIR/libubox/build
cd $TOPDIR/libubox/build
cmake -DCMAKE_INSTALL_PREFIX=$TOPDIR/output -DBUILD_LUA=OFF ..
make
make install
}

build_ubus()
{
mkdir -p $TOPDIR/ubus/build
cd $TOPDIR/ubus/build
cmake -DCMAKE_INSTALL_PREFIX=$TOPDIR/output -DBUILD_LUA=OFF -DENABLE_SYSTEMD=OFF ..
make
make install
}


#build_jsonc
#build_libubox
build_ubus
