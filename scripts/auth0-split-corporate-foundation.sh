#!/usr/bin/env bash
# Split Auth0 SPA callbacks by arm (Corporate vs Foundation).
# Requires: auth0 login (if refresh fails, remove ~/.config/auth0/ and login again)
set -euo pipefail

CORPORATE_ID="1WtUStGO3B4jrpeGCRTcoA2SwcNN93Q0"
FOUNDATION_ID="In43D8hfptI5B17Xo7XZX4aBkhfMuH56"

CORPORATE_CALLBACKS=(
  "https://coderic.com/callback/"
  "https://coderic.com/es/callback/"
  "https://financial.coderic.com/callback/"
  "https://financial.coderic.com/es/callback/"
  "https://coderic.cloud/callback/"
  "https://coderic.cloud/es/callback/"
  "https://coderic.store/callback/"
  "https://coderic.store/es/callback/"
)

FOUNDATION_CALLBACKS=(
  "https://coderic.org/callback/"
  "https://coderic.org/es/callback/"
  "https://coderic.dev/callback/"
  "https://coderic.dev/es/callback/"
  "https://coderic.net/callback/"
  "https://coderic.net/es/callback/"
  "https://io.coderic.net/callback/"
  "https://io.coderic.net/es/callback/"
)

join_by_comma() { local IFS=','; echo "$*"; }

corporate_cb=$(join_by_comma "${CORPORATE_CALLBACKS[@]}")
foundation_cb=$(join_by_comma "${FOUNDATION_CALLBACKS[@]}")

corporate_origins=(
  "https://coderic.com"
  "https://financial.coderic.com"
  "https://coderic.cloud"
  "https://coderic.store"
)
foundation_origins=(
  "https://coderic.org"
  "https://coderic.dev"
  "https://coderic.net"
  "https://io.coderic.net"
)

corporate_orig=$(join_by_comma "${corporate_origins[@]}")
foundation_orig=$(join_by_comma "${foundation_origins[@]}")

echo "Updating Corporate app ($CORPORATE_ID)..."
auth0 apps update "$CORPORATE_ID" \
  --name "Coderic" \
  --callbacks "$corporate_cb" \
  --origins "$corporate_orig" \
  --logout-urls "$corporate_orig" \
  --web-origins "$corporate_orig,http://localhost:4200"

echo "Updating Foundation app ($FOUNDATION_ID)..."
auth0 apps update "$FOUNDATION_ID" \
  --name "Coderic Foundation" \
  --callbacks "$foundation_cb" \
  --origins "$foundation_orig" \
  --logout-urls "$foundation_orig" \
  --web-origins "$foundation_orig"

echo "Done. Verify: auth0 apps show $CORPORATE_ID && auth0 apps show $FOUNDATION_ID"
