# Targetly CLI - Homebrew Tap

Official Homebrew tap for the Targetly CLI (`tly`).

## Installation

```bash
# Add the tap
brew tap Targetly-Labs/tly https://github.com/Targetly-Labs/brew-tly

# Install tly
brew install tly
```

## Demo

https://github.com/Targetly-Labs/brew-tly/assets/Targetly_Labs.mp4

> **Note**: If the video doesn't display above, you can [download it here](./Targetly_Labs.mp4) or visit the repository to view it.

## Updating

```bash
brew update
brew upgrade tly
```

## Usage

After installation, you can use the `tly` command:

```bash
tly login
tly deploy
```

## For Maintainers

### Repository Naming

> **Important**: For this to work as a Homebrew tap, this repository should be renamed from `brew-tly` to `homebrew-tly`. Homebrew requires the `homebrew-` prefix for tap repositories.

If you rename the repository to `homebrew-tly`, users can install with the shorter command:
```bash
brew tap Targetly-Labs/tly
brew install tly
```

### Release Process

When releasing a new version, follow these steps:

#### 1. Build binaries for all platforms

Build the `tly` binary for each platform and create tar.gz archives with the following naming pattern:
- `targetly-darwin-amd64-{version}.tar.gz` (macOS Intel)
- `targetly-darwin-arm64-{version}.tar.gz` (macOS Apple Silicon)
- `targetly-linux-amd64-{version}.tar.gz` (Linux x86_64)
- `targetly-linux-arm64-{version}.tar.gz` (Linux ARM64)

Each archive should contain a directory named `targetly-{platform}-{version}/` with:
- `tly` (the CLI binary)
- `targetly-api` (the API server binary - optional)
- `README.md` (optional documentation)

#### 2. Upload archives directly

You can upload your pre-built archives directly. Each archive should follow this structure:
```
targetly-darwin-arm64-1.0.0/
├── tly
├── targetly-api
└── README.md
```

#### 3. Calculate SHA256 checksums

```bash
shasum -a 256 targetly-darwin-amd64-1.0.0.tar.gz
shasum -a 256 targetly-darwin-arm64-1.0.0.tar.gz
shasum -a 256 targetly-linux-amd64-1.0.0.tar.gz
shasum -a 256 targetly-linux-arm64-1.0.0.tar.gz
```

#### 4. Create GitHub release

1. Go to https://github.com/Targetly-Labs/brew-tly/releases/new
2. Create a new tag (e.g., `v1.0.0`)
3. Upload all four `.tar.gz` files
4. Publish the release

#### 5. Update the formula

Edit `Formula/tly.rb`:
1. Update the `version` field
2. Replace the `PLACEHOLDER_SHA256_*` values with the actual SHA256 checksums
3. Commit and push the changes

Example:
```ruby
version "1.0.0"

on_macos do
  if Hardware::CPU.arm?
    url "https://github.com/Targetly-Labs/brew-tly/releases/download/v#{version}/tly-darwin-arm64.tar.gz"
    sha256 "abc123..." # Replace with actual checksum
  else
    url "https://github.com/Targetly-Labs/brew-tly/releases/download/v#{version}/tly-darwin-amd64.tar.gz"
    sha256 "def456..." # Replace with actual checksum
  end
end
```

### Testing Locally

Before releasing, you can test the formula locally:

```bash
# Install from local formula
brew install --build-from-source Formula/tly.rb

# Or test the formula
brew test tly
```

### Quick Release Script

Here's a helper script to calculate checksums after creating archives:

```bash
#!/bin/bash
echo "=== SHA256 Checksums ==="
echo ""
echo "Darwin AMD64:"
shasum -a 256 tly-darwin-amd64.tar.gz | awk '{print $1}'
echo ""
echo "Darwin ARM64:"
shasum -a 256 tly-darwin-arm64.tar.gz | awk '{print $1}'
echo ""
echo "Linux AMD64:"
shasum -a 256 tly-linux-amd64.tar.gz | awk '{print $1}'
echo ""
echo "Linux ARM64:"
shasum -a 256 tly-linux-arm64.tar.gz | awk '{print $1}'
```

Save this as `calculate-checksums.sh`, make it executable, and run it after creating your tar.gz files.
