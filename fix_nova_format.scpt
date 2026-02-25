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
        set newBody to "# PROJECT NOVA - Issue Tracking

รายการงานจาก Google Sheet (อัปเดตล่าสุด: 2026-02-25 17:50)
โปรเจกต์: Board Game Nova

## 📋 รายการ Defect (ISSUES)

- [x] ✅ **DEFECT_001:** [Low] ฟอนต์เมนูบาร์ ไม่ได้ใช้ตัวหนา (NOT A DEFECT)
- [ ] ⭕️ **DEFECT_002:** [Low] ใช้เป็นภาษาอังกฤษในช่อง Search
- [x] ✅ **DEFECT_003:** [Low] คำว่า Reccommend ข้อความดีไซน์ต้องเป็นคำว่า Recommendation (✅ เสร็จแล้ว 25/02 - รอ Commit)
- [x] ✅ **DEFECT_004:** [Low] ตัวแบนเนอร์ และรูปภาพส่วนที่เป็นมุมต้องโค้ง (✅ เสร็จแล้ว 25/02 - ปรับเป็น radius_16)
- [ ] ⭕️ **DEFECT_005:** [Low] การเว้นระยะห่างแต่ละไอเท็มบอร์ดเกม ไม่เป็นไปตามดีไซน์
- [ ] ⭕️ **DEFECT_006:** [Low] เช็คขนาดฟอนต์ของหัวข้อและคำอธิบาย ลองเทียบดูมันเล็กกว่าดีไซน์
- [x] ✅ **DEFECT_007:** [High] กด location category จากหน้า Home ต้องไปหน้า location list (DONE)
- [ ] ⭕️ **DEFECT_008:** [Medium] Recommend บางข้อมูล เช่น review ,star ยัง Fix อยู่
- [ ] ⭕️ **DEFECT_009:** [Medium] item Recommend แต่ละรายการมีความสูง และช่องว่างที่มากเกินไป
- [ ] ⭕️ **DEFECT_010:** [Medium] item GM/GN แต่ละรายการมีการซ้อนทับกันของข้อมูล
- [ ] ⭕️ **DEFECT_011:** [Medium] item GM/GN ต้องเลื่อนในแบบแนวนอน
- [ ] ⭕️ **DEFECT_012:** [Medium] item Location ต้องแสดงแค่ 3 รายการ
- [ ] ⭕️ **DEFECT_013:** [Medium] Event Near me UI ไม่ตรง Figma
- [x] ✅ **DEFECT_014:** [High] ปิด tab bar เพื่อส่ง review ให้ผ่าน (DONE)
- [x] ✅ **DEFECT_015:** [High] ยิง api bookings แล้ว error ไปต่อหน้า checkout ไม่ได้ (DONE)
- [x] ✅ **DEFECT_016:** [High] รูปภาพยังไม่ส่งมาใน api (DONE)
- [x] ✅ **DEFECT_017:** [High] ปิด favorite button เพื่อส่ง review ให้ผ่านก่อน (DONE)
- [x] ✅ **DEFECT_018:** [High] ปิด icon favorite และ message ออก เพื่อส่ง Review (DONE)
- [ ] ⭕️ **DEFECT_019:** [Low] font Robot Crush ปรับเป็นตัวพิมพ์เล็กให้หมด
- [ ] ⭕️ **DEFECT_020:** [Low] หน้า profile ให้มีเมนู Delete account
- [x] ✅ **DEFECT_021:** [High] ปิดปุ่ม setting ไว้ เพื่อส่ง Review (DONE)
- [x] ✅ **DEFECT_022:** [Low] ต้องแสดง Eng ทั้งหมด และทำรองรับทั้ง 2 ภาษา (✅ เสร็จส่วน Localization Key - รอ Commit)
- [ ] ⭕️ **DEFECT_023:** [Low] เพิ่มเมนูเปลี่ยนภาษา
- [ ] ⭕️ **DEFECT_024:** [Medium] หน้า search ที่มาจาก category จะไม่มีข้อมูลใน tab อื่น
- [ ] ⭕️ **DEFECT_025:** [High] location list page ไม่มี banner
- [ ] ⭕️ **DEFECT_026:** [Low] ปรับให้ ระยะ distance มีทศนิยม 1 ตำแหน่ง
- [x] ✅ **DEFECT_027:** [High] ปิดหน้า map ไปก่อน เพื่อส่ง review (DONE)
- [x] ✅ **DEFECT_028:** [High] ปิดส่วน payment เพื่อส่ง review (DONE)
- [x] ✅ **DEFECT_029:** [High] แก้ไขคำว่า Payment success เป็น Booking success (DONE)
- [x] ✅ **DEFECT_030:** [High] ข้อมูลร้านที่จองต้องเป็นร้านที่เลือก (DONE)

---

**📝 หมายเหตุ:**
- ✅ = เสร็จสิ้นแล้ว (DONE)
- ⭕️ = ยังค้างอยู่ (Pending)
- อัปเดตล่าสุด: 2026-02-25
- โดย: Jarvis 🦾

*งาน DEFECT_003, 004, 022 เสร็จแล้ว แต่ยังรอ Commit โค้ด*"
        
        set body of targetNote to newBody
        return "อัปเดต Note เรียบร้อย!"
    else
        return "ไม่พบ Note"
    end if
end tell
