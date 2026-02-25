#!/bin/bash
OPENCLAW="/Users/devtar/.nvm/versions/node/v24.2.0/bin/openclaw"

echo "Updating Cron Jobs to read from ACTIVE_TASKS.md..."

# Cleanup old jobs
$OPENCLAW cron rm morning-briefing 2>/dev/null
$OPENCLAW cron rm evening-briefing 2>/dev/null

# Morning Briefing - Read from ACTIVE_TASKS.md
MORNING_MSG="ทำตาม JARVIS_PLAN.md: 1. อ่านไฟล์ ACTIVE_TASKS.md ใน Workspace 2. ตรวจสอบ Git Log โปรเจกต์ ~/project_me/nova 3. สรุปงานที่ค้าง ⭕️ และงานที่เสร็จ ✅ 4. รายงาน AI Quota"
$OPENCLAW cron add --name "morning-briefing" --cron "0 9 * * 1-5" --model "gemini" --message "$MORNING_MSG" --channel "telegram" --to "7050919545" --announce --timeout 120000 --thinking "medium"

# Evening Briefing - Read from ACTIVE_TASKS.md
EVENING_MSG="ทำตาม JARVIS_PLAN.md (Evening): 1. อ่านไฟล์ ACTIVE_TASKS.md ใน Workspace 2. ตรวจสอบ Git Log วันนี้ของโปรเจกต์ ~/project_me/nova 3. สรุปงานที่เสร็จและถามขออนุมัติปิดงาน 4. รายงาน AI Quota"
$OPENCLAW cron add --name "evening-briefing" --cron "0 17 * * 1-5" --model "gemini" --message "$EVENING_MSG" --channel "telegram" --to "7050919545" --announce --timeout 120000 --thinking "medium"

echo "Jobs updated to use ACTIVE_TASKS.md"
$OPENCLAW cron list | grep -E "morning-briefing|evening-briefing"
