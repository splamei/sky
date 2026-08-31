#!/bin/bash
#
# SPDX-FileCopyrightText: Splamei
# SPDX-License-Identifier: AGPL-3.0-only
#
# Usage: ./export.sh <username>
# - Use to export almost all user data (except secret keys)
# - Made for Docker compose. You may be able to modify it for other purposes

TARGET_USER="$1"
DB_NAME="misskey"
DB_USER="misskey"

USER_CHECKED_NAMES="'userId', 'followerId', 'authorId', 'targetUserId', 'assigneeId', 'recipientId', 'fromUserId', 'ownerId', 'muterId', 'createdById', 'usedById', 'blockerId', 'muterId', 'user1Id', 'user2Id', 'mentionedUserIds'"

# Data not encluded for security like authentication information. DO NOT INCLUDE IT TO PREVENT EXPOSING SENSITIVE DATA!
EXCLUDED_TABLES="'access_token', 'auth_session', 'password_reset_request', 'user_keypair', 'user_security_key', 'user_publickey'"
EXCLUDED_KEYS="ARRAY['password', 'twoFactorSecret', 'token', 'secret', 'privateKey', 'hash', 'securityKey']"
EXPORT_DIR="misskeyDataExport_${TARGET_USER}"

set -eu

echo "--- Exporter helper ---"
echo "Added by Splamei"
echo

if [ -z "$TARGET_USER" ]; then
    echo "Usage: ./export.sh <username>"
    echo "- Use to export almost all user data (except secret keys)"
    echo "- Made for Docker compose. You may be able to modify it for other purposes"

    exit 1
fi

if ! which zip &> /dev/null; then
    echo
    echo "ERR: Package 'zip' not found! Is it installed on your system?"
    exit 1
fi

echo "- Fetching UID for $TARGET_USER"

USER_ID=$(docker compose exec -T db psql -U $DB_USER -d $DB_NAME -t -A -c "SELECT id FROM \"user\" WHERE username = '$TARGET_USER';")

if [ -z "$USER_ID" ]; then
    echo
    echo "ERR: '$TARGET_USER' was not found! Is the name correct and was there account deleted?"
    exit 1
fi

echo "- Got UID $USER_ID"
echo "- Preparing the DB queries"
echo "  - Due to the queries being made, it make take a while depeding on the data being stored"

mkdir -p "${EXPORT_DIR}/drive"

FULL_USER_TABLES=$(docker compose exec -T db psql -U $DB_USER -d $DB_NAME -t -A -c \
"SELECT table_name || ':' || column_name 
    FROM information_schema.columns 
    WHERE table_schema = 'public' 
        AND column_name IN ($USER_CHECKED_NAMES) 
        AND table_name NOT IN ($EXCLUDED_TABLES);")

DB_QUERY="SELECT (jsonb_build_object('user_account', (SELECT row_to_json(u)::jsonb - $EXCLUDED_KEYS FROM \"user\" u WHERE id = '$USER_ID'))"

for pair in $FULL_USER_TABLES; do
    TABLE="${pair%%:*}"
    COL="${pair##*:}"

    DB_QUERY+=" || jsonb_build_object('$TABLE', (SELECT coalesce(jsonb_agg(row_to_json(t)::jsonb - $EXCLUDED_KEYS), '[]'::jsonb) FROM \"$TABLE\" t WHERE \"$COL\" = '$USER_ID'))"
done

DB_QUERY+=");"

echo "- Fetching the user's data and saving"
docker compose exec -T db psql -U $DB_USER -d $DB_NAME -t -A -c "$DB_QUERY" > "${EXPORT_DIR}/data.json"

echo "- Fetching the user's drive"
ACCESS_KEYS=$(docker compose exec -T db psql -U $DB_USER -d $DB_NAME -t -A -c \
    "SELECT \"accessKey\" FROM \"drive_file\" WHERE \"userId\" = '$USER_ID' AND \"accessKey\" IS NOT NULL;")

for key in $ACCESS_KEYS; do
    docker compose exec -T web sh -c "cat /misskey/files/$key 2>/dev/null" > "${EXPORT_DIR}/drive/$key" 2>/dev/null
done

echo "- Zipping everything up!"
zip -r -q "${EXPORT_DIR}.zip" "${EXPORT_DIR}"
rm -rf "${EXPORT_DIR}"

echo
echo "--- Done! ---"
echo
echo "The resuling zip can be found at ${EXPORT_DIR}.zip"