#!/usr/bin/env python3
import os
import json
import requests
import sys
import traceback

API_BASE = "https://api.cloudflare.com/client/v4"
TOKEN = os.environ.get("CF_API_TOKEN")
CONFIG_PATH = sys.argv[1]

if not TOKEN:
    print("⚠️  CF_API_TOKEN is not set", file=sys.stderr)
    sys.exit(1)

headers = {
    "Authorization": f"Bearer {TOKEN}",
    "Content-Type": "application/json"
}

def log(msg):
    print(f"[cloudflare-cnames] {msg}")

def get_zone_id(zone_name):
    log(f"🔍 Fetching zone ID for '{zone_name}'...")
    try:
        resp = requests.get(f"{API_BASE}/zones", headers=headers, params={"name": zone_name})
        resp.raise_for_status()
        result = resp.json()["result"]
        if not result:
            log(f"❌ No zone found for '{zone_name}'")
            return None
        return result[0]["id"]
    except Exception as e:
        log(f"❌ Failed to get zone ID for '{zone_name}': {e}")
        traceback.print_exc()
        return None

def update_record(zone_id, record, target, proxied=True):
    log(f"🔄 Updating CNAME '{record}' -> '{target}' (proxied={proxied}) in zone ID {zone_id}")
    try:
        # Check for existing record
        query = {"type": "CNAME", "name": record}
        resp = requests.get(f"{API_BASE}/zones/{zone_id}/dns_records", headers=headers, params=query)
        resp.raise_for_status()
        existing = resp.json()["result"]

        # Shared request payload
        payload = {
            "type": "CNAME",
            "name": record,
            "content": target,
            "ttl": 3600,
            "proxied": proxied
        }

        if existing:
            record_id = existing[0]["id"]
            method = requests.put
            url = f"{API_BASE}/zones/{zone_id}/dns_records/{record_id}"
        else:
            method = requests.post
            url = f"{API_BASE}/zones/{zone_id}/dns_records"

        resp = method(url, headers=headers, json=payload)
        resp.raise_for_status()
        log(f"✅ Successfully updated/created CNAME '{record}'")
        return True
    except Exception as e:
        log(f"❌ Failed to update record '{record}': {e}")
        traceback.print_exc()
        return False


# Load and process records
success = True

try:
    with open(CONFIG_PATH) as f:
        records = json.load(f)

    for r in records:
        zone_id = get_zone_id(r["zone"])
        if not zone_id:
            success = False
            continue

        # Extract proxied flag, default to True if not present
        proxied = r.get("proxied", True)
        ok = update_record(zone_id, r["record"], r["target"], proxied)
        if not ok:
            success = False


except Exception as e:
    log(f"❌ Unrecoverable error: {e}")
    traceback.print_exc()
    sys.exit(1)

if not success:
    log("⚠️  Some records failed to update.")
else:
    log("✅ All records processed successfully.")

