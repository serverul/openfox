#!/bin/bash
# OpenFox — Apply Privacy Patches to Firefox ESR 140 Source
# Run this from the gecko-dev root directory

set -e

echo "🦊 Applying OpenFox privacy patches to ESR 140..."

# 1. Set privacy defaults in firefox.js
echo "  → Setting privacy defaults..."
FIREFOX_JS="browser/app/profile/firefox.js"

if [ -f "$FIREFOX_JS" ]; then
    cat >> "$FIREFOX_JS" << 'EOF'

// ============================================================
// OPENFOX PRIVACY DEFAULTS — ESR 140
// ============================================================

// Resist Fingerprinting — enabled by default
pref("privacy.resistFingerprinting", true);
pref("privacy.resistFingerprinting.block_mozAddonManager", true);
pref("privacy.resistFingerprinting.letterboxing", true);
pref("privacy.resistFingerprinting.randomDataOnCanvasExtract", true);

// Fingerprinting Protection
pref("privacy.fingerprintingProtection", true);
pref("privacy.fingerprintingProtection.overrides", "");

// WebRTC — disable non-proxied UDP (prevent IP leaks)
pref("media.peerconnection.ice.proxy_only_if_behind_proxy", true);
pref("media.peerconnection.ice.default_address_only", true);
pref("media.peerconnection.ice.no_host", true);
pref("media.peerconnection.ice.proxy_only", true);

// Disable Battery API
pref("dom.battery.enabled", false);

// DNS-over-HTTPS — Quad9
pref("network.trr.mode", 2);
pref("network.trr.uri", "https://dns.quad9.net/dns-query");
pref("network.trr.bootstrapAddress", "9.9.9.9");
pref("network.trr.custom_uri", "https://dns.quad9.net/dns-query");

// HTTPS-Only Mode
pref("dom.security.https_only_mode", true);
pref("dom.security.https_only_mode_ever_enabled", true);

// Disable prefetching
pref("network.prefetch-next", false);
pref("network.dns.disablePrefetch", true);
pref("network.dns.disablePrefetchFromHTTPS", true);
pref("network.predictor.enabled", false);

// Disable WebRTC by default
pref("media.peerconnection.enabled", false);

// Disable Safe Browsing (sends URLs to Google)
pref("browser.safebrowsing.malware.enabled", false);
pref("browser.safebrowsing.phishing.enabled", false);
pref("browser.safebrowsing.downloads.enabled", false);
pref("browser.safebrowsing.downloads.remote.enabled", false);

// Disable telemetry
pref("toolkit.telemetry.unified", false);
pref("toolkit.telemetry.enabled", false);
pref("toolkit.telemetry.server", "data:,");
pref("datareporting.healthreport.uploadEnabled", false);
pref("datareporting.policy.dataSubmissionEnabled", false);

// Disable Pocket
pref("extensions.pocket.enabled", false);

// Disable Firefox accounts
pref("identity.fxaccounts.enabled", false);

// Disable crash reports
pref("breakpad.reportURL", "");
pref("browser.tabs.crashReporting.sendReport", false);

// Container tabs
pref("privacy.userContext.enabled", true);
pref("privacy.userContext.ui.enabled", true);

// Disable clipboard events
pref("dom.event.clipboardevents.enabled", false);

// Cross-origin referers
pref("network.http.referer.XOriginTrimmingPolicy", 2);
pref("network.http.referer.XOriginPolicy", 2);

// OpenFox branding
pref("openfox.privacy.level", "maximum");
pref("openfox.version", "140.0.0");
EOF
    echo "  ✅ Privacy defaults added to firefox.js"
else
    echo "  ❌ firefox.js not found!"
fi

# 2. Change User Agent
echo "  → Setting OpenFox User Agent..."
UA_FILE="netwerk/protocol/http/nsHttpHandler.cpp"
if [ -f "$UA_FILE" ]; then
    sed -i 's/Firefox\/[0-9.]*/OpenFox\/140.0/g' "$UA_FILE"
    echo "  ✅ User Agent updated"
else
    echo "  ⚠️  nsHttpHandler.cpp not found, UA not changed"
fi

# 3. Disable Pocket in build
echo "  → Disabling Pocket..."
POCKET_MK="browser/components/pocket/moz.build"
if [ -f "$POCKET_MK" ]; then
    echo "# OpenFox: Pocket disabled" > "$POCKET_MK"
    echo "  ✅ Pocket disabled"
fi

echo ""
echo "✅ OpenFox privacy patches applied for ESR 140!"
echo ""
