#!/bin/bash
# Build Observer v18 - agilist_e_from
# ตรวจจับตามแผนใหม่: หน้าแก้ไข, version app, xcode

TELEGRAM_TO="7050919545"
OPENCLAW_BIN="/Users/devtar/.nvm/versions/node/v24.2.0/bin/openclaw"

# Android Dashboard
ANDROID_APPID="195"

# State tracking
SEEN_ANDROID=false
SEEN_WEB=false
SEEN_IOS=false

# Counter for sustained detection
ANDROID_COUNTER=0
WEB_COUNTER=0
IOS_COUNTER=0

# Threshold (seconds)
THRESHOLD=30

echo "$(date): Build Observer v18 (agilist_e_from) started"
echo "Pattern: Android edit page, Web version, Xcode"

while true; do
    # Get current browser URL
    CURRENT_URL=$(osascript -e 'tell application "Google Chrome" to get URL of active tab of first window' 2>/dev/null || osascript -e 'tell application "Safari" to get URL of current tab of front window' 2>/dev/null)
    
    # --- Android Detection ---
    # ตรวจจับเฉพาะหน้าแก้ไขของ appid=195
    if [[ "$CURRENT_URL" == *"appid=$ANDROID_APPID"* ]]; then
        # ต้องเป็นหน้า edit/modify/update
        if [[ "$CURRENT_URL" == *"edit"* ]] || [[ "$CURRENT_URL" == *"modify"* ]] || [[ "$CURRENT_URL" == *"update"* ]] || [[ "$CURRENT_URL" == *"add"* ]]; then
            ANDROID_COUNTER=$((ANDROID_COUNTER + 1))
            if [ $ANDROID_COUNTER -ge $THRESHOLD ] && ! $SEEN_ANDROID; then
                SEEN_ANDROID=true
                echo "$(date): Android Upload detected (edit page, appid=$ANDROID_APPID)"
            fi
        else
            ANDROID_COUNTER=0
        fi
    else
        ANDROID_COUNTER=0
    fi
    
    # --- Web Detection ---
    # เช็คที่ version app (e-form.gbhcenter.com)
    if [[ "$CURRENT_URL" == *"e-form.gbhcenter.com"* ]]; then
        # ต้องเป็นหน้า version หรือ deploy
        if [[ "$CURRENT_URL" == *"version"* ]] || [[ "$CURRENT_URL" == *"deploy"* ]] || [[ "$CURRENT_URL" == *"release"* ]]; then
            WEB_COUNTER=$((WEB_COUNTER + 1))
            if [ $WEB_COUNTER -ge $THRESHOLD ] && ! $SEEN_WEB; then
                SEEN_WEB=true
                echo "$(date): Web Upload detected (version/deploy page)"
            fi
        else
            WEB_COUNTER=0
        fi
    else
        WEB_COUNTER=0
    fi
    
    # --- iOS Detection ---
    # ดูว่าเข้าไปอัปโหลดใน xcode ยัง (App Store Connect build/upload page)
    if [[ "$CURRENT_URL" == *"appstoreconnect.apple.com"* ]]; then
        # ต้องเป็นหน้า builds หรือ upload
        if [[ "$CURRENT_URL" == *"builds"* ]] || [[ "$CURRENT_URL" == *"upload"* ]] || [[ "$CURRENT_URL" == *"submit"* ]]; then
            IOS_COUNTER=$((IOS_COUNTER + 1))
            if [ $IOS_COUNTER -ge $THRESHOLD ] && ! $SEEN_IOS; then
                SEEN_IOS=true
                echo "$(date): iOS Upload detected (Xcode/App Store Connect)"
            fi
        else
            IOS_COUNTER=0
        fi
    else
        IOS_COUNTER=0
    fi
    
    # --- Alert Phase ---
    if $SEEN_ANDROID || $SEEN_WEB || $SEEN_IOS; then
        echo "$(date): Upload activity confirmed. Waiting 5 minutes..."
        
        # Wait 5 minutes
        for i in {1..300}; do
            sleep 1
            
            CHECK_URL=$(osascript -e 'tell application "Google Chrome" to get URL of active tab of first window' 2>/dev/null || osascript -e 'tell application "Safari" to get URL of current tab of front window' 2>/dev/null)
            
            # Continue checking
            if [[ "$CHECK_URL" == *"appid=$ANDROID_APPID"* ]] && [[ "$CHECK_URL" == *"edit"* ]]; then
                SEEN_ANDROID=true
            fi
            if [[ "$CHECK_URL" == *"e-form.gbhcenter.com"* ]] && [[ "$CHECK_URL" == *"version"* ]]; then
                SEEN_WEB=true
            fi
            if [[ "$CHECK_URL" == *"appstoreconnect.apple.com"* ]] && [[ "$CHECK_URL" == *"builds"* ]]; then
                SEEN_IOS=true
            fi
        done
        
        # Build alert
        PENDING=""
        if $SEEN_ANDROID && ! $SEEN_WEB; then
            PENDING="$PENDING [Web: e-form.gbhcenter.com/version]"
        fi
        if $SEEN_ANDROID && ! $SEEN_IOS; then
            PENDING="$PENDING [iOS: Xcode/App Store Connect]"
        fi
        if $SEEN_WEB && ! $SEEN_ANDROID; then
            PENDING="$PENDING [Android: Dashboard edit]"
        fi
        
        if [ -n "$PENDING" ]; then
            MSG="🚀 เจ้านายครับ! ตรวจพบการ Upload โปรเจกต์ agilist_e_from แล้ว แต่ $PENDING ยังไม่ได้ upload นะครับ! 🦾"
            echo "Sending alert: $MSG"
            $OPENCLAW_BIN message send --target "$TELEGRAM_TO" --message "$MSG" --channel telegram 2>/dev/null
        else
            echo "$(date): All platforms uploaded. No alert needed."
        fi
        
        # Reset
        SEEN_ANDROID=false
        SEEN_WEB=false
        SEEN_IOS=false
        ANDROID_COUNTER=0
        WEB_COUNTER=0
        IOS_COUNTER=0
        
        echo "$(date): Cycle finished. Waiting 5 minutes..."
        sleep 300
    fi
    
    sleep 1
done
