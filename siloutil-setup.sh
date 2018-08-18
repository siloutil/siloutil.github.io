#!/bin/bash

rm -rf zlib
rm -rf hdf5
rm -rf silo
rm -rf binaries

export CC=gcc-8.2
export CXX=g++-8.2
export CFLAGS="-fPIC"
export LD_LIBRARY_PATH=/home/niklas/gcc/lib:/home/niklas/gcc/gmp/lib:/home/niklas/gcc/mpc/lib:/home/niklas/gcc/mpfr/lib
export LIBS="-ldl"
export HDF5TestExpress=0

mkdir binaries

prefix=$PWD
logfile=setup.log

(
git clone https://github.com/siloutil/zlib
cd zlib
./configure --static --prefix=$prefix/binaries/zlib
make
make test
make install
cd ..

git clone https://github.com/siloutil/hdf5
cd hdf5
./configure --disable-shared --with-zlib=$prefix/binaries/zlib/include,$prefix/binaries/zlib/lib --prefix=$prefix/binaries/hdf5
make
make check
make install
cd ..

git clone https://github.com/siloutil/silo
cd silo
./configure --disable-fortran \
            --disable-shared \
            --with-zlib=$prefix/binaries/zlib/include,$prefix/binaries/zlib/lib \
            --with-hdf5=$prefix/binaries/hdf5/include,$prefix/binaries/hdf5/lib \
            --prefix=$prefix/binaries/silo
make
cd tests
make check STARGS=DB_HDF5
cd ..
make install
cd ..

mkdir lib64
mkdir includes

cp binaries/zlib/lib/libz.a lib64/

cp binaries/hdf5/lib/libhdf5.a lib64/

cp binaries/silo/include/silo.h includes/
cp binaries/silo/include/silo_exports.h includes/
cp binaries/silo/lib/libsiloh5.a lib64/

rm -rf zlib
rm -rf hdf5
rm -rf silo
rm -rf binaries
) > $logfile 2>&1
