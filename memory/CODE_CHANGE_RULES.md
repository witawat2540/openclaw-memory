# Code Change Rules - กฎการแก้ไขโค้ด

## 🚨 สำคัญมาก! Workflow ต้องทำตามนี้ทุกครั้ง

### 📋 Code Change Workflow (MUST FOLLOW)

**Step 1: แก้ไขโค้ด**
- ✅ แก้ไขโค้ดตามที่เจ้านายสั่ง
- ✅ **ตรวจสอบ warnings** และแก้ไขให้หมด
  - ถ้า comment code ต้อง comment imports และ methods ที่ไม่ใช้ด้วย
  - ไม่ปล่อยให้มี unused imports/variables/methods

**Step 2: รายงานผล**
- ✅ รายงานผลให้เจ้านายทราบว่าแก้อะไรบ้าง
- ✅ แสดงโค้ดที่แก้ไขให้เจ้านายตรวจสอบ

**Step 3: รอการยืนยัน**
- ✅ **รอการยืนยันจากเจ้านาย** ก่อน commit
- ❌ **ห้าม commit อัตโนมัติ** โดยไม่ได้รับการยืนยัน
- รอจนกว่าเจ้านายพูดว่า "ok", "commit", "โอเค", "ยืนยัน", "ถูกต้อง" ฯลฯ

**Step 4: Commit**
- ✅ ถ้าได้รับการยืนยัน → commit ได้
- ❌ ถ้าเจ้านายบอก "แก้ไข" → กลับไป Step 1

---

## 🔍 การแก้ Warning (เมื่อ comment code)

**ตัวอย่าง:** ถ้า comment `map()` widget ต้องทำด้วย:
1. Comment imports ที่เกี่ยวข้อง
2. Comment variables ที่ไม่ใช้ (apiKey, mapKey, currentLat, currentLong)
3. Comment methods ที่ไม่ใช้ (markLocation, invisibleLayer, ฯลฯ)

**ตัวอย่างโค้ด:**
```dart
// ❌ ไม่ดี - ทิ้ง warning ไว้
Widget mapAndShop() {
  return Stack(children: [/*map()*/, gameBox(), shopList()]);
}

// ✅ ดี - comment ทุกอย่างที่เกี่ยวข้อง
// DEFECT_027: Temporarily commented out for review
// final String apiKey = BuildConfig.instance.config.longdoApiMapKey;
// final mapKey = GlobalKey<LongdoMapState>();
// ... (comment all unused code)
```

---

## 🚫 ข้อยกเว้น

**สามารถ commit ได้เลย (ไม่ต้องรอยืนยัน):**
- ถ้าเจ้านายสั่งชัดเจนว่า "commit เลย" หรือ "push เลย"
- ถ้าเป็น config หรือ documentation ที่ไม่ใช่โค้ดหลัก

---

## 🤖 Sub-Agent Behavior

- Sub-agent ต้องรายงานผลกลับมาให้ main session
- Main session จะเป็นคนถามเจ้านายเพื่อยืนยัน
- ถ้าเจ้านายไม่ยืนยัน ให้ revert หรือเก็บ changes ไว้ใน staged state

---

**Created:** 2026-02-20  
**Updated:** 2026-02-20 (เพิ่ม workflow และการแก้ warning)  
**Reason:** เจ้านายต้องการตรวจสอบโค้ดก่อนทุกครั้ง และต้องไม่มี warning
