#!/bin/bash

WEBHOOK_URL="https://discord.com/api/webhooks/1381215630325317632/3b7vst9Skuxu9a6vujhsx28_UjcX7QI3kQze4c0FdfWstCksrHzAflGKaZwd1pSCfKKt"  # 여기에 본인의 웹훅 URL 입력
ERRORS=""

for name in redis1 mongodb1 zimeet-backend_backend_1 zimeet-backend_backend_2 zimeet-backend_backend_3 nginx; do
    STATUS=$(docker inspect -f '{{.State.Health.Status}}' $name 2>/dev/null)

    if [ -z "$STATUS" ] || [[ "$STATUS" != "healthy" && "$STATUS" != "running" ]]; then
        ERRORS+="❌ 컨테이너 ${name} 상태 이상 ❌: ${STATUS:-not found}\n"
    fi

done

if [ ! -z "$ERRORS" ]; then
  curl -H "Content-Type: application/json" \
       -X POST \
       -d "{\"content\": \"⚠️ 지밋 서버 컨테이너 상태 문제 발생:\n${ERRORS}\"}" \
       $WEBHOOK_URL
fi
