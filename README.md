# 🦊 OpenFox

**Privacy-first browser fork of Firefox ESR 140.**

No telemetry. No tracking. No compromises.

## What's Different from Firefox

| Feature | Firefox ESR | OpenFox |
|---------|-------------|---------|
| Resist Fingerprinting | Off by default | **ON by default** |
| WebRTC | Enabled | **Disabled** (prevents IP leaks) |
| DNS-over-HTTPS | Cloudflare | **Quad9** (privacy-focused) |
| Safe Browsing | Sends URLs to Google | **Disabled** |
| Telemetry | Enabled | **Completely removed** |
| Pocket | Enabled | **Disabled** |
| HTTPS-Only | Off | **ON by default** |
| Container tabs | Off | **ON by default** |

## Privacy Levels

### Maximum (Default)
- Resist Fingerprinting (RFP) enabled
- Canvas noise injection
- WebGL disabled
- Font enumeration blocked
- Timezone spoofed to UTC
- WebRTC disabled
- Battery API disabled

### Enhanced
- Fingerprinting Protection (FPP) — less aggressive
- WebRTC enabled (for video calls)
- Better site compatibility

## Download

Pre-built binaries: [GitHub Releases](https://github.com/serverul/openfox/releases)

- Linux: `.tar.bz2`
- Windows: `.exe` installer
- macOS: `.dmg`

## Build from Source

### Prerequisites
- Python 3.11+
- Rust (latest stable)
- Node.js
- 30GB+ disk space
- 8GB+ RAM
- Platform-specific deps (see below)

### Linux (Debian/Ubuntu)
```bash
sudo apt-get install build-essential nodejs python3 python3-pip \
  yasm libasound2-dev libcurl4-openssl-dev libdbus-1-dev \
  libdrm-dev libfreetype6-dev libgtk-3-dev libpulse-dev \
  libx11-xcb-dev libxt-dev mesa-common-dev uuid-dev nasm

git clone --branch esr140 --depth 1 https://github.com/mozilla/gecko-dev.git
cd gecko-dev
bash ../scripts/apply-patches.sh
cp ../mozconfig .
./mach bootstrap
./mach build
./mach run
```

### Windows
```powershell
choco install mozilla-build nsis
git clone --branch esr140 --depth 1 https://github.com/mozilla/gecko-dev.git
cd gecko-dev
bash ../scripts/apply-patches.sh
cp ../mozconfig .
./mach bootstrap
./mach build
./mach package
```

### macOS
```bash
brew install autoconf@2.13 gawk ccache llvm yasm nasm
git clone --branch esr140 --depth 1 https://github.com/mozilla/gecko-dev.git
cd gecko-dev
bash ../scripts/apply-patches.sh
cp ../mozconfig .
./mach bootstrap
./mach build
./mach package
```

## Updating from Upstream

```bash
# Pull latest Firefox ESR changes
git fetch upstream
git merge upstream/esr140

# Re-apply OpenFox patches
bash scripts/apply-patches.sh

# Rebuild
./mach build
```

## Architecture

```
gecko-dev/                  # Firefox ESR 140 source
├── browser/
│   ├── app/profile/
│   │   └── firefox.js      # ← Privacy defaults patched here
│   └── branding/
│       └── openfox/         # ← OpenFox branding
├── netwerk/protocol/http/
│   └── nsHttpHandler.cpp    # ← User Agent patched here
├── scripts/
│   └── apply-patches.sh    # Privacy patch script
├── mozconfig               # Build configuration
└── .github/workflows/
    └── build.yml            # CI/CD pipeline
```

## Contributing

1. Fork the repo
2. Create a feature branch (`git checkout -b feature/my-feature`)
3. Make changes to Firefox ESR source
4. Test: `./mach build && ./mach run`
5. Submit a pull request

## License

MPL-2.0 (Mozilla Public License)

## Credits

- [Firefox ESR](https://www.mozilla.org/firefox/enterprise/) — Base browser
- [Mullvad Browser](https://mullvad.net/en/browser) — Privacy inspiration
- [LibreWolf](https://librewolf.net/) — Privacy browser inspiration
- [arkenfox/user.js](https://github.com/arkenfox/user.js) — Privacy settings inspiration
