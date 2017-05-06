#!/bin/sh
# 
# File:   arm-tool-install.sh
# Author: Bruno de Lacheisserie
#
# Created on Jan 1, 2015, 6:39:30 PM
#

mkdir ~/tmp
cd ~/tmp

# install toolchain
#wget http://max.kellermann.name/download/xcsoar/devel/x-tools/x-tools-arm-i386-2013-12-11.tar.xz
#tar xJfC x-tools-arm-i386-2013-12-11.tar.xz /home/user
#export PATH=/home/user/x-tools/arm-unknown-linux-gnueabi/bin:$PATH

# install zlib ( 1.2.11 - 2017-01-15)
wget http://zlib.net/zlib-1.2.11.tar.gz
tar -xvzf zlib-1.2.11.tar.gz 
cd zlib-1.2.11
CC=arm-unknown-linux-gnueabi-gcc CFLAGS="-O3 -march=armv7-a -mfpu=neon -ftree-vectorize -mvectorize-with-neon-quad -ffast-math -funsafe-math-optimizations -funsafe-loop-optimizations" \
./configure --prefix=/opt/kobo/arm-unknown-linux-gnueabi
make all
sudo make install
cd ..

# install zziplib ( 0.13.62 - 2012-03-11)
wget http://liquidtelecom.dl.sourceforge.net/project/zziplib/zziplib13/0.13.62/zziplib-0.13.62.tar.bz2
tar xvjf zziplib-0.13.62.tar.bz2 
mkdir zzipbuild
cd zzipbuild
CFLAGS="-O3 -march=armv7-a -mfpu=neon -ftree-vectorize -mvectorize-with-neon-quad -ffast-math -funsafe-math-optimizations -funsafe-loop-optimizations" \
../zziplib-0.13.62/configure --host=arm-unknown-linux-gnueabi --target=arm-unknown-linux-gnueabi --prefix=/opt/kobo/arm-unknown-linux-gnueabi --with-zlib
make all
sudo PATH=/home/user/x-tools/arm-unknown-linux-gnueabi/bin:$PATH \
    make install
cd ..

# install boostlib ( 1.64.0 - 2017-04-19 )
wget https://dl.bintray.com/boostorg/release/1.64.0/source/:boost_1_64_0.tar.gz
tar xzf boost_1_64_0.tar.gz
cd boost_1_64_0
./bootstrap.sh
echo "using gcc : arm : arm-unknown-linux-gnueabi-g++ : cxxflags=-O3 -march=armv7-a -mfpu=neon -ftree-vectorize -mvectorize-with-neon-quad -ffast-math -funsafe-math-optimizations -funsafe-loop-optimizations ;" > user-config.jam
sudo PATH=/home/user/x-tools/arm-unknown-linux-gnueabi/bin:$PATH \
    ./bjam toolset=gcc target-os=linux variant=release link=shared runtime-link=shared --prefix=/opt/kobo/arm-unknown-linux-gnueabi --user-config=user-config.jam install
cd ..

# install libpng ( 1.6.29 - 2017-03-16 )
wget http://sourceforge.net/projects/libpng/files/libpng16/1.6.29/libpng-1.6.29.tar.gz
tar xzf libpng-1.6.29.tar.gz
mkdir libpng-build
cd libpng-build
../libpng-1.6.29/configure \
    --host=arm-unknown-linux-gnueabi \
    CC=arm-unknown-linux-gnueabi-gcc \
    AR=arm-unknown-linux-gnueabi-ar \
    STRIP=arm-unknown-linux-gnueabi-strip \
    RANLIB=arm-unknown-linux-gnueabi-ranlib \
    CPPFLAGS="-O3 -march=armv7-a -mfpu=neon -ftree-vectorize -mvectorize-with-neon-quad -ffast-math -funsafe-math-optimizations -funsafe-loop-optimizations -I/opt/kobo/arm-unknown-linux-gnueabi/include" \
    LDFLAGS="-L/opt/kobo/arm-unknown-linux-gnueabi/lib"  \
    --prefix=/opt/kobo/arm-unknown-linux-gnueabi 
make
sudo PATH=/home/user/x-tools/arm-unknown-linux-gnueabi/bin:$PATH \
    make install
cd ..

# install freetype2 ( 2.7.1 - 2016-12-30 )
wget http://download.savannah.gnu.org/releases/freetype/freetype-2.7.1.tar.gz
tar xzf freetype-2.7.1.tar.gz
mkdir freetype-build
cd freetype-build
CFLAGS="-O3 -march=armv7-a -mfpu=neon -ftree-vectorize -mvectorize-with-neon-quad -ffast-math -funsafe-math-optimizations -funsafe-loop-optimizations" \
LDFLAGS="-L/opt/kobo/arm-unknown-linux-gnueabi/lib"  \
../freetype-2.7.1/configure \
    --host=arm-unknown-linux-gnueabi \
    --target=arm-unknown-linux-gnueabi \
    --prefix=/opt/kobo/arm-unknown-linux-gnueabi \
    --without-harfbuzz \
    PKG_CONFIG_LIBDIR=/opt/kobo/arm-unknown-linux-gnueabi/lib/pkgconfig
make
sudo PATH=/home/user/x-tools/arm-unknown-linux-gnueabi/bin:$PATH \
    make install
cd ..

# install Geographiclib ( 1.48 - 2017-04-09 )
wget https://netcologne.dl.sourceforge.net/project/geographiclib/distrib/GeographicLib-1.48.tar.gz
tar xzf GeographicLib-1.48.tar.gz
mkdir GeographicLib-build
cd GeographicLib-build
CFLAGS="-O3 -march=armv7-a -mfpu=neon -ftree-vectorize -mvectorize-with-neon-quad -ffast-math -funsafe-math-optimizations -funsafe-loop-optimizations" \
LDFLAGS="-L/opt/kobo/arm-unknown-linux-gnueabi/lib"  \
../GeographicLib-1.48/configure \
    --host=arm-unknown-linux-gnueabi \
    --prefix=/opt/kobo/arm-unknown-linux-gnueabi \
    PKG_CONFIG_LIBDIR=/opt/kobo/arm-unknown-linux-gnueabi/lib/pkgconfig
make
sudo PATH=/home/user/x-tools/arm-unknown-linux-gnueabi/bin:$PATH \
    make install
cd ..
