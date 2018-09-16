#
#
#
default: all

clean:
	pwd

all: buildroot-2018.08/output/images/sdcard.img

buildroot-2018.08:
	wget http://buildroot.uclibc.org/downloads/buildroot-2018.08.tar.gz
	tar xf buildroot-2018.08.tar.gz
	cd buildroot-2018.08 && git apply ../br.patch

buildroot-2018.08/output/images/sdcard.img: buildroot-2018.08
	cd buildroot-2018.08 && make BR2_EXTERNAL=../ conservify-glacier_defconfig && make
