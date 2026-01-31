# Homebrew Tap for Security Verification Toolkit

This is a [Homebrew](https://brew.sh) tap for the Security Verification Toolkit.

## Installation

```bash
# Add the tap
brew tap brucedombrowski/security-toolkit

# Install the toolkit
brew install security-toolkit

# Optional: Update ClamAV virus definitions
freshclam
```

## Usage

After installation, these commands are available:

| Command | Description |
|---------|-------------|
| `security-scan` | Run all security scans on a directory |
| `security-tui` | Interactive menu interface |
| `security-inventory` | Collect host system inventory |
| `security-pii` | Scan for PII patterns (SSN, credit cards, etc.) |
| `security-secrets` | Scan for hardcoded secrets and API keys |
| `security-malware` | Run ClamAV malware scan |
| `security-kev` | Check against CISA KEV catalog |
| `security-containers` | Scan running Docker/Podman containers |

### Examples

```bash
# Scan a project directory
security-scan /path/to/project

# Interactive mode
security-tui

# Individual scans
security-pii /path/to/project
security-secrets /path/to/project
security-containers
```

## Updating

```bash
brew update
brew upgrade security-toolkit
```

## Uninstalling

```bash
brew uninstall security-toolkit
brew untap brucedombrowski/security-toolkit
```

## About

The Security Verification Toolkit provides security scanning capabilities aligned with federal standards:

- **NIST SP 800-53** - Security and Privacy Controls
- **NIST SP 800-171** - Protecting CUI
- **CISA KEV** - Known Exploited Vulnerabilities

For more information, see the [main repository](https://github.com/brucedombrowski/security-toolkit).
