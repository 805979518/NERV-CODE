#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
INSTALL_DIR="$SCRIPT_DIR/dist"

echo "=== NERV CODE — Install ==="
echo ""

# 1. Check prerequisites
command -v node >/dev/null 2>&1 || { echo "Error: node is required (>=18)"; exit 1; }
command -v bun >/dev/null 2>&1 || { echo "Error: bun is required for building"; exit 1; }

NODE_MAJOR=$(node -e "console.log(process.versions.node.split('.')[0])")
if [ "$NODE_MAJOR" -lt 18 ]; then
  echo "Error: Node.js >= 18 required (found v$(node --version))"
  exit 1
fi

# 2. Install dependencies
echo "[1/4] Installing dependencies..."
cd "$SCRIPT_DIR"
bun install

# 3. Restore internal SDKs from sourcemap
echo "[2/4] Restoring internal SDKs..."
for pkg in bedrock-sdk vertex-sdk foundry-sdk; do
  if [ -d "node_modules_sourcemap/@anthropic-ai/$pkg" ]; then
    mkdir -p "node_modules/@anthropic-ai"
    cp -r "node_modules_sourcemap/@anthropic-ai/$pkg" "node_modules/@anthropic-ai/$pkg"
  fi
done

# 4. Build
echo "[3/4] Building..."
bun run build.ts

if [ ! -f "$INSTALL_DIR/cli.js" ]; then
  echo "Error: Build failed — dist/cli.js not found"
  exit 1
fi

# 5. Create nerv command
echo "[4/4] Creating nerv command..."
BIN_PATH="$HOME/.local/bin/nerv"
mkdir -p "$(dirname "$BIN_PATH")"
cat > "$BIN_PATH" << EOF
#!/bin/bash
exec node "$INSTALL_DIR/cli.js" "\$@"
EOF
chmod +x "$BIN_PATH"

# Ensure ~/.local/bin is in PATH for current shell
case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *)
    SHELL_NAME="$(basename "$SHELL")"
    case "$SHELL_NAME" in
      zsh)  RC_FILE="$HOME/.zshrc" ;;
      bash) RC_FILE="$HOME/.bashrc" ;;
      *)    RC_FILE="" ;;
    esac
    if [ -n "$RC_FILE" ] && ! grep -q '\.local/bin' "$RC_FILE" 2>/dev/null; then
      echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$RC_FILE"
      echo "  Added ~/.local/bin to PATH in $RC_FILE"
    fi
    export PATH="$HOME/.local/bin:$PATH"
    ;;
esac

echo ""
echo "✓ NERV CODE installed successfully!"
echo ""
echo "Usage:"
echo "  nerv              # Interactive mode"
echo "  nerv --version    # Show version"
echo "  nerv --help       # Show help"
echo "  nerv -p 'hello'   # Print mode"
echo ""
echo "Run 'nerv' to start. If command not found, restart your terminal."
