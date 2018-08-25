#!/bin/bash

## Setup
proc_make=4			# Processes to use for compiling
				# (usually 1.5...2 number of processors)
gcc_dir=/home/niklas/gcc	# $prefix from script build_gcc.sh
gcc_suff=-7.3.0			# suffix from script build_gcc.sh (-X.Y.Z.)

## Path to gcc bin
export PATH=$gcc_dir/gcc/bin:$PATH

## In case gcc forgets its libraries
export LD_LIBRARY_PATH=\
$gcc_dir/gmp/lib/:\
$gcc_dir/mpc/lib/:\
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

## Build it
cd silotest
autoreconf --verbose --install --force
./configure \
  --with-boost-python=/home/niklas/siloutil/thirdparty/boost\
  --with-python-headers=/usr/include/python2.7\
  --prefix=/home/niklas/siloutil
make clean
make -j $proc_make
cd ..
