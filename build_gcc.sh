#!/bin/bash
## Dependencies gcc g++ make m4 gcc-multilib autogen

## Setup
prefix=/home/niklas/gcc # Directory to use
proc_make=4		# Processes to use for compiling (usually 1.5...2
			#                                 number of processors)
gmp_ver=6.1.2		# Version of GNU MP to download 
			# ! check url and filename in script for changes !
mpc_ver=1.1.0		# Version of GNU MPC to download 
			# ! check url and filename in script for changes !
mpfr_ver=4.0.1		# Version of GNU MPC to download 
			# ! check url and filename in script for changes !
gcc_ver=7.3.0		# Version of GNU MPC to download 
			# ! check url and filename in script for changes !

printf "Prepare directory ....................................................\
..... "

## Remove earlier attempts
rm -rf $prefix/log
rm -f *.tar.bz2
rm -f *.tar.gz

rm -rf $prefix/gmp
rm -rf gmp-$gmp_ver

rm -rf $prefix/mpfr
rm -rf mpfr-$mpc_ver

rm -rf $prefix/mpc
rm -rf mpc-$mpc_ver

rm -rf $prefix/gcc
rm -rf gcc-$gcc_ver

## Make log directory
mkdir $prefix/log

printf "done\n"

## Build GMP
printf "Downloading GNU MP version %s ........................................\
.. " "$gmp_ver"
(wget https://gmplib.org/download/gmp/gmp-$gmp_ver.tar.bz2
tar xf gmp-$gmp_ver.tar.bz2) > $prefix/log/gmp-0_download.log 2>&1
rm gmp-$gmp_ver.tar.bz2
cd gmp-$gmp_ver
printf "done\n"
printf "Configuring ........ "
(./configure --prefix=$prefix/gmp) > $prefix/log/gmp-1_conf.log 2>&1
printf "building ........ "
(make -j $proc_make) > $prefix/log/gmp-2_make.log 2>&1
printf "checking ........ "
(make check -j $proc_make) > $prefix/log/gmp-3_check.log 2>&1
printf "installing ....... "
(make install) > $prefix/log/gmp-4_install.log 2>&1
printf "done\n"
cd ..
rm -rf gmp-$gmp_ver

## Build MPFR
printf "Downloading GNU MPFR version %s ......................................\
.. " "$mpfr_ver"
(wget https://www.mpfr.org/mpfr-current/mpfr-$mpfr_ver.tar.gz
tar xf mpfr-$mpfr_ver.tar.gz) > $prefix/log/mpfr-0_download.log 2>&1
rm mpfr-$mpfr_ver.tar.gz
cd mpfr-$mpfr_ver
printf "done\n"
printf "Configuring ........ "
(./configure --prefix=$prefix/mpfr --with-gmp=$prefix/gmp
) > $prefix/log/mpfr-1_conf.log 2>&1
printf "building ........ "
(make -j $proc_make) > $prefix/log/mpfr-2_make.log 2>&1
printf "checking ........ "
(make check -j $proc_make) > $prefix/log/mpfr-3_check.log 2>&1
printf "installing ....... "
(make install) > $prefix/log/mpfr-4_install.log 2>&1
printf "done\n"
cd ..
rm -rf mpfr-$mpfr_ver

## Build MPC
printf "Downloading GNU MPC version %s .......................................\
.. " "$mpc_ver"
(wget https://ftp.gnu.org/gnu/mpc/mpc-$mpc_ver.tar.gz
tar xf mpc-$mpc_ver.tar.gz) > $prefix/log/mpc-0_download.log 2>&1
rm mpc-$mpc_ver.tar.gz
cd mpc-$mpc_ver
printf "done\n"
printf "Configuring ........ "
(./configure --prefix=$prefix/mpc --with-gmp=$prefix/gmp \
--with-mpfr=$prefix/mpfr) > $prefix/log/mpc-1_conf.log 2>&1
printf "building ........ "
(make -j $proc_make) > $prefix/log/mpc-2_make.log 2>&1
printf "checking ........ "
(make check -j $proc_make) > $prefix/log/mpc-3_check.log 2>&1
printf "installing ....... "
(make install) > $prefix/log/mpc-4_install.log 2>&1
printf "done\n"
cd ..
rm -rf mpc-$mpc_ver

## Export those libraries, so gcc can find them (even though we pass their path
##  as options)

export LD_LIBRARY_PATH=$prefix/gmp/lib:$prefix/mpc/lib:$prefix/mpfr/lib

## Build gcc
printf "Downloading GNU GCC version %s .......................................\
.. " "$gcc_ver"
(wget ftp://ftp.fu-berlin.de/unix/languages/gcc/releases/gcc-$gcc_ver/\
gcc-$gcc_ver.tar.gz
tar xf gcc-$gcc_ver.tar.gz) > $prefix/log/gcc-0_download.log 2>&1
rm gcc-$gcc_ver.tar.gz
cd gcc-$gcc_ver
printf "done\n"
printf "Configuring ........ "
(./configure\
  --prefix=$prefix/gcc\
  --with-gmp=$prefix/gmp\
  --with-mpfr=$prefix/mpfr\
  --with-mpc=$prefix/mpc\
  --program-suffix=-$gcc_ver\
  --enable-languages=c,c++\
 ) > $prefix/log/gcc-1_conf.log 2>&1
printf "building ........ "
(make -j $proc_make) > $prefix/log/gcc-2_make.log 2>&1
printf "checking ........ "
(make check -j $proc_make) > $prefix/log/gcc-3_check.log 2>&1
printf "installing ....... "
(make install) > $prefix/log/gcc-4_install.log 2>&1
printf "done\n"
cd ..
rm -rf gcc-$gcc_ver
