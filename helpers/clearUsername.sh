#!/bin/bash
#
# SPDX-FileCopyrightText: Splamei
# SPDX-License-Identifier: AGPL-3.0-only
#
# Usage: ./clearUsername.sh <username>
# - Use to clear a username from the used usernames database to allow use again
# - Made for Docker compose. You may be able to modify it for other purposes
# - WARNING! Make sure the user's account is deleted before to prevent issues!
# - WARNING! This makes deletions to the database. Always review before using

TARGET_USER="$1"
DB_NAME="misskey"
DB_USER="misskey"

set -eu

echo "--- Clear Username helper ---"
echo "Added by Splamei"
echo

if [ -z "$TARGET_USER" ]; then
    echo "Usage: ./export.sh <username>"
    echo "- Use to clear a username from the used usernames database to allow use again"
    echo "- Made for Docker compose. You may be able to modify it for other purposes"
    echo "- WARNING! Make sure the user's account is deleted before to prevent issues!"
    echo "- WARNING! This makes deletions to the database. Always review before using"

    exit 1
fi

echo "- Freeing the username"
docker compose exec db psql -U $DB_USER -d $DB_NAME -c "DELETE FROM used_username WHERE username = '$TARGET_USER';" 2>/dev/null

echo "- Clearing redis"
docker compose exec redis redis-cli FLUSHALL 2>/dev/null

echo "- Restarting the web UI"
docker compose restart web

echo
echo "--- Done! ---"
echo
echo "The username should now be free and usable"