#!/bin/bash

## Dependencies git python python-dev

## Setup
prefix=/home/niklas/siloutil 	# Directory to use
proc_make=4			# Processes to use for compiling
				# (usually 1.5...2 number of processors)
gcc_dir=/home/niklas/gcc	# $prefix from script build_gcc.sh
gcc_suff=-7.3.0			# suffix from script build_gcc.sh (-X.Y.Z.)


## Remove earlier attempts
rm -rf zlib
rm -rf hdf5
rm -rf silo
rm -rf boost
rm -rf $prefix/thirdparty

## Make directories
mkdir $prefix/thirdparty
mkdir $prefix/thirdparty/log

## Path to gcc bin
export PATH=$gcc_dir/gcc/bin:$PATH

## In case gcc forgets its libraries
export LD_LIBRARY_PATH=\
$gcc_dir/gmp/lib:\
$gcc_dir/mpc/lib:\
$gcc_dir/mpfr/lib:\
$gcc_dir/gcc/lib64:\
$gcc_dir/gcc/lib

## gcc tools
export AR=gcc-ar$gcc_suff
export CC=gcc$gcc_suff
export CXX=g++$gcc_suff
export CXXCPP="g++$gcc_suff -E"
export CPP="g++$gcc_suff -E"
export CFLAGS="-fPIC"
export CPPFLAGS="-fPIC"
export CXXFLAGS="-fPIC"
export HDF5TestExpress=0

## Building zlib
printf "Downloading Zlib .....................................................\
..... "
(git clone https://github.com/siloutil/zlib)\
 > $prefix/thirdparty/log/zlib-0_download.log 2>&1
printf "done\n"
cd zlib
printf "Configuring ........ "
(./configure --static --prefix=$prefix/thirdparty/zlib)\
 > $prefix/thirdparty/log/zlib-1_conf.log 2>&1
printf "building ........ "
(make -j $proc_make) > $prefix/thirdparty/log/zlib-2_make.log 2>&1
printf "checking ........ "
(make -j $proc_make test) > $prefix/thirdparty/log/zlib-3_check.log 2>&1
printf "installing ....... "
(make install) > $prefix/thirdparty/log/zlib-4_install.log 2>&1
printf "done\n"
cd ..
rm -rf zlib

## Building hdf5
printf "Downloading HDF5 .....................................................\
..... "
(git clone https://github.com/siloutil/hdf5)\
 > $prefix/thirdparty/log/hdf5-0_download.log 2>&1
printf "done\n"
cd hdf5
printf "Configuring ........ "
(./configure --disable-shared\
  --with-zlib=$prefix/thirdparty/zlib/include,$prefix/thirdparty/zlib/lib\
  --prefix=$prefix/thirdparty/hdf5
) > $prefix/thirdparty/log/hdf5-1_conf.log 2>&1
printf "building ........ "
(make -j $proc_make) > $prefix/thirdparty/log/hdf5-2_make.log 2>&1
printf "checking ........ "
(make -j $proc_make test) > $prefix/thirdparty/log/hdf5-3_check.log 2>&1
printf "installing ....... "
(make install) > $prefix/thirdparty/log/hdf5-4_install.log 2>&1
printf "done\n"
cd ..
rm -rf hdf5

## Building silo
printf "Downloading SILO .....................................................\
..... "
(git clone https://github.com/siloutil/silo)\
 > $prefix/thirdparty/log/silo-0_download.log 2>&1
cd silo
printf "Configuring ........ "
(./configure --disable-fortran\
  --disable-shared\
  --with-zlib=$prefix/thirdparty/zlib/include,$prefix/thirdparty/zlib/lib\
  --with-hdf5=$prefix/thirdparty/hdf5/include,$prefix/thirdparty/hdf5/lib\
  --prefix=$prefix/thirdparty/silo
) > $prefix/thirdparty/log/silo-1_conf.log 2>&1
printf "building ........ "
(make -j $proc_make) > $prefix/thirdparty/log/silo-2_make.log 2>&1
printf "checking ........ "
cd tests
(make -j $proc_make check STARGS=DB_HDF5) > $prefix/thirdparty/log/silo-3_check.log 2>&1
cd ..
printf "installing ....... "
(make install) > $prefix/thirdparty/log/silo-4_install.log 2>&1
printf "done\n"
cd ..
rm -rf silo

## Building boost
ln -sf $CXX $gcc_dir/gcc/bin/g++-7.3 ## ughh boost
printf "Downloading boost ....................................................\
..... "
(git clone https://github.com/siloutil/boost)\
 > $prefix/thirdparty/log/boost-0_download.log 2>&1
printf "done\n"
cd boost
printf "Configuring ........ "
rm -rf $prefix/thirdparty/boost
mkdir $prefix/thirdparty/boost
(./bootstrap.sh --with-toolset=gcc\
  --libdir=$prefix/thirdparty/boost/lib\
  --includedir=$prefix/thirdparty/boost/include\
  --with-libraries=filesystem,python,test
) > $prefix/thirdparty/log/boost-1_conf.log 2>&1
printf "building ........ "
(./b2 install -q\
  link=static\
  cxxflags=-fPIC\
  --libdir=$prefix/thirdparty/boost/lib\
  --includedir=$prefix/thirdparty/boost/include\
  --toolset=gcc-7.3
) > $prefix/thirdparty/log/boost-2_make.log 2>&1
## Tests, because easy isn't boost-ish
printf "installing ....... checking ........ "
(
echo "Running test for filesystem library"
cd libs/filesystem/test
../../../b2 -q --toolset=gcc-7.3
cd ../../../
echo "Running test for python library"
cd libs/python/test
../../../b2 -q --toolset=gcc-7.3
cd ../../../
echo "Running test for test library"
./b2 headers
cd libs/test/test
../../../b2 -q --toolset=gcc-7.3
cd ../../../
) > $prefix/thirdparty/log/boost-3_check.log 2>&1
printf "done\n"
cd ..
rm -rf boost
rm $gcc_dir/gcc/bin/g++-7.3
