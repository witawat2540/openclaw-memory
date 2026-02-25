#!/bin/bash
OPENCLAW="/Users/devtar/.nvm/versions/node/v24.2.0/bin/openclaw"

echo "Updating Cron Jobs with EXTENDED Gateway Timeout..."

# Cleanup
$OPENCLAW cron rm morning-briefing 2>/dev/null
$OPENCLAW cron rm evening-briefing 2>/dev/null

# Morning Briefing - Added --timeout for Gateway stability
MORNING_MSG="ทำตาม JARVIS_PLAN.md: 1. ใช้ browser tool เข้าไปอ่าน Apple Note ชื่อ '# PROJECT NOVA - Issue Tracking' 2. ตรวจสอบ Git Log ย้อนหลัง 24 ชม. 3. สรุปความคืบหน้า DEFECT ต่างๆ 4. รายงาน AI Quota"
$OPENCLAW cron add --name "morning-briefing" --cron "0 9 * * 1-5" --model "gemini" --message "$MORNING_MSG" --channel "telegram" --to "7050919545" --announce --timeout 120000 --thinking "medium"

# Evening Briefing - Added --timeout for Gateway stability
EVENING_MSG="ทำตาม JARVIS_PLAN.md (Evening): 1. ใช้ browser tool เข้าไปอ่าน Apple Note '# PROJECT NOVA - Issue Tracking' 2. ตรวจสอบ Git Log ของวันนี้ 3. สรุปงานที่เสร็จและถามขออนุมัติปิดงานใน Note 4. รายงาน AI Quota"
$OPENCLAW cron add --name "evening-briefing" --cron "0 17 * * 1-5" --model "gemini" --message "$EVENING_MSG" --channel "telegram" --to "7050919545" --announce --timeout 120000 --thinking "medium"

echo "Jobs updated with 120,000ms Gateway timeout."
$OPENCLAW cron list
