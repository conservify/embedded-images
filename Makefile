#
#
#
default: all

clean:
	pwd

all: build

build: buildroot-2018.08/output/images/sdcard.img

buildroot-2018.08:
	wget http://buildroot.uclibc.org/downloads/buildroot-2018.08.tar.gz
	tar xf buildroot-2018.08.tar.gz
	cd buildroot-2018.08 && patch -p1 < ../br.patch
	for a in package/*; do                               \
		name=`basename $$a`                               ;\
		if [ -d buildroot-2018.08/package/$$name ]; then   \
			echo "Merging $$name..."                        ;\
			cp -ar $$a/* buildroot-2018.08/package/$$name;   \
		fi                                                 \
	done

buildroot-2018.08/output/images/sdcard.img: buildroot-2018.08
	cd buildroot-2018.08 && make BR2_EXTERNAL=../ conservify-wifi-station_defconfig && make
