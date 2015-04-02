#!/bin/bash
server=`grep  \"main_server\" ../../java-code/webkey/res/values/strings.xml | cut -d ">" -f 2 | cut -d "<" -f 1`
VER=`grep android:versionName= ../../java-code/webkey/AndroidManifest.xml | grep -o \".*\" | cut -d "\"" -f 2`
cat mongoose.c | sed -r "s/WEBKEYVERSION/$VER/g" | sed -r "s/WEBKEYSERVER/$server/g" > tmp_mongoose.c
# -fno-exceptions and -fno-rtti
../toolchains/arm-linux-androideabi-4.4.3/prebuilt/linux-x86/bin/arm-linux-androideabi-g++ -Wno-write-strings -mthumb -DANDROID -DNOCRYPT -DUSE_FILE32API -Wl,-rpath-link=../platforms/android-3/arch-arm/usr/lib/,-dynamic-linker=/system/bin/linker -I ../platforms/android-3/arch-arm/usr/include/ -I ../sources/cxx-stl/stlport/stlport/ -fno-short-enums -L ../platforms/android-3/arch-arm/usr/lib/ -lc -llog minizip/zip.c minizip/ioapi.c shellinabox/service.c shellinabox/launcher.c shellinabox/logging.c shellinabox/hashmap.c webkey.c suinput.c tmp_mongoose.c base64.c -fno-exceptions -fno-rtti ../tmp/ndk-digit/build/install/sources/cxx-stl/stlport/libs/armeabi/libstlport_static.a libpng12.a libjpeg.a -lz -o webkey -O2  && ../toolchains/arm-linux-androideabi-4.4.3/prebuilt/linux-x86/bin/arm-linux-androideabi-strip webkey && echo OK && cp -r -f keycodes.txt language_??.txt sqlite3 openssl ssleay.cnf ShellInABox.js beep.wav styles.css enabled.gif reganim.gif *.html favicon.ico fast_keys.txt *.png spec_keys.txt notify.txt ae_* client plugins /home/petya/work/Webkey/webkey/assets/webkey/ && cp webkey /home/petya/work/Webkey/webkey/assets/bin/ && cd /home/petya/work/Webkey/webkey && rm -rf bin gen && ant release && mv bin/webkey-release.apk ../webkey.apk && cd -
#../build/prebuilt/linux-x86/arm-eabi-4.4.0/bin/arm-eabi-g++ -DANDROID -Wl,-rpath-link=../build/platforms/android-3/arch-arm/usr/lib/,-dynamic-linker=/system/bin/linker -nostdlib -I ../build/platforms/android-3/arch-arm/usr/include/ -mfloat-abi=softfp -mfpu=vfp -L ../build/platforms/android-3/arch-arm/usr/lib/ -lc -llog crt0.o shellinabox/service.c shellinabox/launcher.c shellinabox/logging.c shellinabox/hashmap.c webkey.c suinput.c tmp_mongoose.c base64.c  ../build/prebuilt/linux-x86/arm-eabi-4.4.0/arm-eabi/lib/libstdc++.a libpng12.a libjpeg_x10.a -lz -o webkey -O2  && ../build/prebuilt/linux-x86/arm-eabi-4.4.0/bin/arm-eabi-strip webkey && echo OK && cp -r -f sqlite3 webkey ShellInABox.js beep.wav styles.css keyboard.png enabled.gif *.html favicon.ico fast_keys.txt *.png spec_keys.txt notify.txt ae_* client plugins /home/petya/work/Webkey/webkey/assets/webkey/ && cd /home/petya/work/Webkey/ && ./buildapk_petya.sh && cd -
