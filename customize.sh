case $ARCH in
    arm)   F_ARCH=$ARCH;;
    arm64)   F_ARCH=$ARCH;;
    *)     ui_print "Unsupported architecture: $ARCH"; abort;;
esac

ui_print "- Detected architecture: $F_ARCH"
ui_print "- Extracting module files"

F_TARGETDIR="$MODPATH/system/bin"
UNZIP="/data/adb/magisk/busybox unzip"

mkdir -p "$F_TARGETDIR"
$UNZIP -qq -o "$ZIPFILE" "files/tailscaled-$F_ARCH" -j -d "$F_TARGETDIR"
$UNZIP -qq -o "$ZIPFILE" "files/tailscale-$F_ARCH" -j -d "$F_TARGETDIR"

mv "$F_TARGETDIR/tailscaled-$F_ARCH" "$F_TARGETDIR/tailscaled"
mv "$F_TARGETDIR/tailscale-$F_ARCH" "$F_TARGETDIR/tailscale"

ui_print "- Extracted files to $F_TARGETDIR"

ui_print "- Setting permissions"

set_perm_recursive $MODPATH 0 0 0755 0644
set_perm_recursive $F_TARGETDIR 0 2000 0755 0755
set_perm $MODPATH/service.sh 0 0 0755

ui_print "- Cleaning up"

rm -r "$F_TARGETDIR/files" # cleanup

ui_print "*******************"
ui_print " Instructions       "
ui_print "*******************"
ui_print "1. Reboot your device."
ui_print "2. Open the Teminal."
ui_print "3. Run 'su' to gain root access."
ui_print "4. Run 'tailscale login' to login to your Tailscale account."
ui_print "5. Open url in browser to authorize your device."
ui_print "6. Run 'tailscale status' to check Tailscale connection."
ui_print "*******************"
ui_print " Troubleshooting    "
ui_print "*******************"
ui_print "1. Check logs in /data/local/tmp/tailscaled.log."
ui_print "*******************"
ui_print " Notice            "
ui_print "*******************"
ui_print "- Tailscale has some bug."
ui_print "- To login tailscale you need go to tmp directory."
ui_print "- You can use this commands:"
ui_print "$ su"
ui_print "$ cd /data/local/tmp/"
ui_print "$ tailscale login"
ui_print "*******************"


