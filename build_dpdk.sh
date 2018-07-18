#!/bin/bash

make config T=x86_64-native-linuxapp-gcc O=x86_64-native-linuxapp-gcc
cd x86_64-native-linuxapp-gcc/
sed -ri 's,(CONFIG_RTE_BUILD_SHARED_LIB=).*,\1y,' .config
sed -ri 's,(CONFIG_RTE_LIBRTE_PMD_PCAP=).*,\1y,' .config
sed -ri 's,(CONFIG_RTE_LIBRTE_MLX5_PMD=).*,\1y,' .config
cd ..
make -j12 install T=x86_64-native-linuxapp-gcc EXTRA_CFLAGS="-fPIC" DESTDIR=/usr/local
if [ $? -eq 0 ]; then 
	ldconfig
	echo "build ok"
else
	echo  "build failed"
fi

#create symbolic link to headers for odp
cd x86_64-native-linuxapp-gcc/include
ln -s ../include/ dpdk
cd ../../

