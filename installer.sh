#!/sbin/sh
# GDebloater

# Settings
OUTFD=$2
ui_print() {
    echo -n -e "ui_print $1\n" >> /proc/self/fd/$OUTFD
    echo -n -e "ui_print\n" >> /proc/self/fd/$OUTFD
}

# Mount
sleep 1;
ui_print "Mounting system...";
mount -t auto /system_root;
mount -o rw,remount /system_root;

# Path | Credit to wahyu6070 & TheHitMan7
if [ -f /system_root/system/build.prop ]; then
	SYSTEM=/system_root/system 
elif [ -f /system_root/build.prop ]; then
	SYSTEM=/system_root
elif [ -f /system/system/build.prop ]; then
	SYSTEM=/system/system
else
	SYSTEM=/system
fi

if [ ! -L $SYSTEM/vendor ]; then
	VENDOR=$SYSTEM/vendor
else
	VENDOR=/vendor
fi

if [ ! -L $SYSTEM/product ]; then
	PRODUCT=$SYSTEM/product
else
	PRODUCT=/product
fi

if [ ! -L $SYSTEM/system_ext ]; then
	SYSTEM_EXT=$SYSTEM/system_ext
else
	SYSTEM_EXT=/system_ext
fi

system_uninstall() {
  SYSTEM_APP="$SYSTEM/app"
  SYSTEM_PRIV_APP="$SYSTEM/priv-app"
}

product_uninstall() {
  SYSTEM_APP="$PRODUCT/app"
  SYSTEM_PRIV_APP="$PRODUCT/priv-app"
}

ext_uninstall() {
  SYSTEM_APP="$SYSTEM_EXT/app"
  SYSTEM_PRIV_APP="$SYSTEM_EXT/priv-app"
}

sleep 1;
ui_print "| Remove from /system/*/app & /system/*/priv-app... ";
post_install_wipe() {
  for i in \
Books CalculatorGooglePrebuilt GoogleCalendarSyncAdapter GoogleContactsSyncAdapter Gmail2 \
DevicePolicyPrebuilt Drive Chrome Chrome-Stub ChromeHomePage \
GoogleContacts GoogleTTS Hangouts LatinIMEGoogle* LocationHistoryPrebuilt \
MarkupGoogle Music2 Newsstand PlayGames Photos \
PlusOne PrebuiltBugle PrebuiltDeskClockGoogle SoundPickerPrebuilt TrichromeLibrary \
TrichromeLibrary-Stub Videos WebViewGoogle WebViewGoogle-Stub YouTube \
YouTubeMusicPrebuilt AndroidAutoStubPrebuilt Assistant CarrierServices DeviceIntelligenceNetworkPrebuilt \
DevicePersonalization* DocumentsUIGoogle FilesPrebuilt GoogleBackupTransport GoogleDialer \
GoogleLoginService GoogleMaps GoogleOneTimeInitializer GooglePartnerSetup GoogleServicesFramework \
HotwordEnrollmentOKGoogleHEXAGON HotwordEnrollmentXGoogleHEXAGON OTAConfigPrebuilt PartnerSetupPrebuilt Phonesky \
PlayGames PrebuiltGmsCore PrebuiltKeep QuickAccessWallet SettingsIntelligenceGooglePrebuilt \
TurboPrebuilt Velvet Wellbeing* GoogleFeedback NexusLauncherRelease \
StorageManagerGoogle WallpaperPickerGoogleRelease; do
    rm -rf $SYSTEM_APP/$i $SYSTEM_PRIV_APP/$i
  done
}

ui_print "| Remove from /system/product/overlay... ";
rm -rf $PRODUCT/overlay/FilesOverlay*;
rm -rf $PRODUCT/overlay/GmsContactsProviderOverlay*;
rm -rf $PRODUCT/overlay/GmsConfigOverlay*;
rm -rf $PRODUCT/overlay/GmsConfigOverlayComms*;
rm -rf $PRODUCT/overlay/GoogleWebViewOverlay*;
rm -rf $PRODUCT/overlay/PixelDocumentsUIGoogleOverlay*;
rm -rf $PRODUCT/overlay/PixelConfigOverlayCommon*;
rm -rf $PRODUCT/overlay/PixelFontConfigOverlay*;
rm -rf $PRODUCT/overlay/PixelRecentsProvider;
rm -rf $PRODUCT/overlay/SystemUIGXOverlay;
rm -rf $PRODUCT/overlay/ThemedIconsOverlay;
rm -rf $PRODUCT/overlay/TurboOverlay*;

sleep 1;
ui_print "| Remove from /system/product/framework... ";
rm -rf $PRODUCT/framework/com.google.android.dialer.support.jar;
rm -rf $PRODUCT/framework/com.google.android.maps.jar;
rm -rf $PRODUCT/framework/com.google.android.media.effects.jar;
rm -rf $PRODUCT/framework/com.google.widevine.software.drm.jar;

sleep 1;
ui_print "| Remove from /system/product/etc... ";
rm -rf $PRODUCT/etc/permissions/com.android.systemui.plugin.globalactions.wallet.xml;
rm -rf $PRODUCT/etc/permissions/com.android.vending.xml;
rm -rf $PRODUCT/etc/permissions/com.google.android.apps.googleassistant.xml;
rm -rf $PRODUCT/etc/permissions/com.google.android.apps.nbu.files.xml;
rm -rf $PRODUCT/etc/permissions/com.google.android.apps.recorder.xml;
rm -rf $PRODUCT/etc/permissions/com.google.android.apps.turbo.xml;
rm -rf $PRODUCT/etc/permissions/com.google.android.apps.wellbeing.xml;
rm -rf $PRODUCT/etc/permissions/com.google.android.apps.work.oobconfig.xml;
rm -rf $PRODUCT/etc/permissions/com.google.android.as.xml;
rm -rf $PRODUCT/etc/permissions/com.google.android.dialer.support.xml;
rm -rf $PRODUCT/etc/permissions/com.google.android.documentsui.xml;
rm -rf $PRODUCT/etc/permissions/com.google.android.googlequicksearchbox.xml;
rm -rf $PRODUCT/etc/permissions/com.google.android.gms.xml;
rm -rf $PRODUCT/etc/permissions/com.google.android.ims.xml;
rm -rf $PRODUCT/etc/permissions/com.google.android.keep.xml;
rm -rf $PRODUCT/etc/permissions/com.google.android.maps.xml;
rm -rf $PRODUCT/etc/permissions/com.google.android.media.effects.xml;
rm -rf $PRODUCT/etc/permissions/com.google.android.partnersetup.xml;
rm -rf $PRODUCT/etc/permissions/com.google.android.projection.gearhead.xml;
rm -rf $PRODUCT/etc/permissions/com.google.widevine.software.drm.xml;
rm -rf $PRODUCT/etc/permissions/NikGapps-privapp-permissions-google.xml;
rm -rf $PRODUCT/etc/permissions/privapp-permissions-com.google.android.as.oss.xml;
rm -rf $PRODUCT/etc/permissions/privapp-permissions-com.google.android.as.xml;
rm -rf $PRODUCT/etc/permissions/privapp-permissions-google-comms-suite.xml;
rm -rf $PRODUCT/etc/permissions/privapp-permissions-google-p.xml;
rm -rf $PRODUCT/etc/permissions/privapp-permissions-google-product.xml;
rm -rf $PRODUCT/etc/permissions/privapp-permissions-google-system-ext.xml;
rm -rf $PRODUCT/etc/preferred-apps/google.xml;
rm -rf $PRODUCT/etc/sysconfig/google.xml;
rm -rf $PRODUCT/etc/sysconfig/google_build.xml;
rm -rf $PRODUCT/etc/sysconfig/google_vr_build.xml;
rm -rf $PRODUCT/etc/sysconfig/nexus.xml;
rm -rf $PRODUCT/etc/sysconfig/wellbeing.xml;
rm -rf $PRODUCT/etc/sysconfig/pixel.xml;
rm -rf $PRODUCT/etc/sysconfig/pixel_2019_exclusive.xml;
rm -rf $PRODUCT/etc/sysconfig/pixel_experience_2017.xml;
rm -rf $PRODUCT/etc/sysconfig/pixel_experience_2018.xml;
rm -rf $PRODUCT/etc/sysconfig/pixel_experience_2019.xml;
rm -rf $PRODUCT/etc/sysconfig/pixel_experience_2019_midyear.xml;
rm -rf $PRODUCT/etc/sysconfig/pixel_experience_2020.xml;
rm -rf $PRODUCT/etc/sysconfig/pixel_experience_2020_midyear.xml;

sleep 1;
ui_print "| Remove from /system/system_ext/etc... ";
rm -rf $SYSTEM_EXT/etc/permissions/com.google.android.apps.nexuslauncher.xml;
rm -rf $SYSTEM_EXT/etc/permissions/com.google.android.apps.wallpaper.xml;
rm -rf $SYSTEM_EXT/etc/permissions/com.google.android.feedback.xml;
rm -rf $SYSTEM_EXT/etc/permissions/com.google.android.storagemanager.xml;
rm -rf $SYSTEM_EXT/etc/permissions/privapp-permissions-com.google.android.apps.nexuslauncher.xml;
rm -rf $SYSTEM_EXT/etc/sysconfig/hiddenapi-whitelist-com.google.android.apps.nexuslauncher.xml;
rm -rf $SYSTEM_EXT/etc/sysconfig/preinstalled-packages-platform-overlays.xml;

sleep 1;
ui_print "| Remove libs, configs, addons & other files... ";
rm -rf $SYSTEM/addon.d;
rm -rf $PRODUCT/lib/libjni_latinimegoogle.so;
rm -rf $PRODUCT/lib64/libjni_latinimegoogle.so;
rm -rf $SYSTEM/usr/share/ime;
rm -rf $SYSTEM/usr/srec;
rm -rf $PRODUCT/lib/libarcore_sdk_c.so;
rm -rf $PRODUCT/lib/libarcore_sdk_jni.so;
rm -rf $PRODUCT/lib/libgmm-jni.so;
rm -rf $PRODUCT/lib/libmappedcountercacheversionjni.so;
rm -rf $PRODUCT/lib/libnative_crash_handler_jni.so;
rm -rf $PRODUCT/lib64/libarcore_sdk_c.so;
rm -rf $PRODUCT/lib64/libarcore_sdk_jni.so;
rm -rf $PRODUCT/lib64/libgmm-jni.so;
rm -rf $PRODUCT/lib64/libmappedcountercacheversionjni.so;
rm -rf $PRODUCT/lib64/libnative_crash_handler_jni.so;

sleep 1;
ui_print "| Remove apps data from /data/data... ";
rm -rf /data/data/com.android.chrome;
rm -rf /data/data/com.android.providers.contacts.gms.overlay;
rm -rf /data/data/com.android.settings.turbo.overlay;
rm -rf /data/data/com.android.systemui.plugin.globalactions.wallet;
rm -rf /data/data/com.google.android.apps.googleassistant;
rm -rf /data/data/com.google.android.apps.docs;
rm -rf /data/data/com.google.android.apps.maps;
rm -rf /data/data/com.google.android.apps.messaging;
rm -rf /data/data/com.google.android.apps.nexuslauncher;
rm -rf /data/data/com.google.android.apps.photos;
rm -rf /data/data/com.google.android.apps.recorder;
rm -rf /data/data/com.google.android.apps.restore;
rm -rf /data/data/com.google.android.apps.turbo;
rm -rf /data/data/com.google.android.apps.wallpaper;
rm -rf /data/data/com.google.android.apps.work.clouddpc;
rm -rf /data/data/com.google.android.apps.work.oobconfig;
rm -rf /data/data/com.google.android.apps.youtube.music;
rm -rf /data/data/com.google.android.as;
rm -rf /data/data/com.google.android.as.oss;
rm -rf /data/data/com.google.android.calculator;
rm -rf /data/data/com.google.android.calendar;
rm -rf /data/data/com.google.android.contacts;
rm -rf /data/data/com.google.android.deskclock;
rm -rf /data/data/com.google.android.dialer;
rm -rf /data/data/com.google.android.documentsui;
rm -rf /data/data/com.google.android.documentsui.theme.pixel;
rm -rf /data/data/com.google.android.feedback;
rm -rf /data/data/com.google.android.flipendo;
rm -rf /data/data/com.google.android.files.theme.pixel;
rm -rf /data/data/com.google.android.gm;
rm -rf /data/data/com.google.android.gms;
rm -rf /data/data/com.google.android.gms.policy_sidecar_aps;
rm -rf /data/data/com.google.android.googlequicksearchbox;
rm -rf /data/data/com.google.android.gsf;
rm -rf /data/data/com.google.android.ims;
rm -rf /data/data/com.google.android.keep;
rm -rf /data/data/com.google.android.markup;
rm -rf /data/data/com.google.android.overlay.gmsconfig.*;
rm -rf /data/data/com.google.android.overlay.googlewebview;
rm -rf /data/data/com.google.android.overlay.pixelconfigcommon;
rm -rf /data/data/com.google.android.partnersetup;
rm -rf /data/data/com.google.android.play.games;
rm -rf /data/data/com.google.android.projection.gearhead;
rm -rf /data/data/com.google.android.settings.intelligence;
rm -rf /data/data/com.google.android.soundpicker;
rm -rf /data/data/com.google.android.storagemanager;
rm -rf /data/data/com.google.android.syncadapters.calendar;
rm -rf /data/data/com.google.android.syncadapters.contacts;
rm -rf /data/data/com.google.android.systemui.gxoverlay;
rm -rf /data/data/com.google.android.trichromelibrary*;
rm -rf /data/data/com.google.android.tts;
rm -rf /data/data/com.google.android.webview;
rm -rf /data/data/com.google.android.youtube;
rm -rf /data/data/com.google.ar.lens;
rm -rf /data/data/com.hentai.android.overlay.hentaiconfig;
rm -rf /data/data/com.romcontrolicons.nexuslauncher;
rm -rf /data/data/xyz.paphonb.quickswitch.overlay;

if [ ! -f "$SYSTEM/test.enttn" ]; then
ui_print "| Totally cleaning..."
  ext_uninstall
  post_install_wipe
  product_uninstall
  post_install_wipe
  system_uninstall
  post_install_wipe
fi

rm -rf $SYSTEM/test.enttn
ui_print "Done! ";