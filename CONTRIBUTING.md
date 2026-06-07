# Contributing to OpenFox

Thank you for your interest in contributing to OpenFox!

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone git@github.com:YOUR_USERNAME/openfox.git`
3. Create a branch: `git checkout -b feature/my-feature`
4. Make your changes
5. Test: `./mach build && ./mach run`
6. Commit: `git commit -m "Description of changes"`
7. Push: `git push origin feature/my-feature`
8. Open a Pull Request

## Development Setup

### Prerequisites
- Python 3.11+
- Rust (latest stable)
- Node.js
- 30GB+ disk space
- 8GB+ RAM

### Building
```bash
# Apply OpenFox patches
bash scripts/apply-patches.sh

# Configure
cp mozconfig.example mozconfig

# Bootstrap dependencies
./mach bootstrap

# Build
./mach build

# Run
./mach run
```

## Code Style

- Follow Mozilla's coding standards
- Use meaningful commit messages
- Test your changes before submitting

## Privacy Changes

When making privacy-related changes:
1. Document the change in `PRIVACY-PATCHES.md`
2. Update `scripts/apply-patches.sh` if needed
3. Test with fingerprinting tools (coveryourtracks.eff.org)

## Reporting Issues

- Use GitHub Issues
- Include steps to reproduce
- Include your OS and build version

## License

MPL-2.0 (Mozilla Public License)
