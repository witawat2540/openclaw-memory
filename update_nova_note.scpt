tell application "Notes"
    activate
    
    set targetNote to missing value
    repeat with aNote in notes
        if name of aNote starts with "# PROJECT NOVA - Issue Tracking" then
            try
                set test to body of aNote
                set targetNote to aNote
                exit repeat
            end try
        end if
    end repeat
    
    if targetNote is not missing value then
        set currentBody to body of targetNote as string
        
        -- Replace DEFECT_003
        set AppleScript's text item delimiters to "- [ ] ⭕️ **DEFECT_003:** [Low] คำว่า Reccommend ต้องเป็น Recommendation"
        set textItems to text items of currentBody
        set AppleScript's text item delimiters to "- [x] ✅ **DEFECT_003:** [Low] คำว่า Reccommend ต้องเป็น Recommendation (✅ เสร็จแล้ว 25/02 - รอ Commit)"
        set currentBody to textItems as string
        
        -- Replace DEFECT_004
        set AppleScript's text item delimiters to "- [ ] ⭕️ **DEFECT_004:** [Low] ตัวแบนเนอร์และรูปภาพส่วนมุมต้องโค้ง"
        set textItems to text items of currentBody
        set AppleScript's text item delimiters to "- [x] ✅ **DEFECT_004:** [Low] ตัวแบนเนอร์และรูปภาพส่วนมุมต้องโค้ง (✅ เสร็จแล้ว 25/02 - ปรับ radius_16)"
        set currentBody to textItems as string
        
        -- Replace DEFECT_022
        set AppleScript's text item delimiters to "- [ ] ⭕️ **DEFECT_022:** [Low] ต้องแสดง Eng ทั้งหมด และรองรับ 2 ภาษา"
        set textItems to text items of currentBody
        set AppleScript's text item delimiters to "- [x] ✅ **DEFECT_022:** [Low] ต้องแสดง Eng ทั้งหมด และรองรับ 2 ภาษา (✅ เสร็จส่วน Localization - รอ Commit)"
        set currentBody to textItems as string
        
        -- Reset
        set AppleScript's text item delimiters to ""
        
        set body of targetNote to currentBody
        return "อัปเดต Note เดิมสำเร็จ!"
    else
        return "ไม่พบ Note"
    end if
end tell
