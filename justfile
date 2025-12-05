# Devnet management for devnets repository
#
# Creates devnets using cookiecutter templates from devnet-templates repo
# Templates are fetched via SSH from GitHub

TEMPLATES_REPO := "git@github.com:ethereum-optimism/devnet-templates.git"
TEMPLATES_BRANCH := "main"

# Default: show help
default:
    @just --list
    @echo ""
    @echo "Create devnets using cookiecutter templates from devnet-templates"
    @echo ""
    @echo "Usage: just create-devnet <alphanets|betanets> <name> <preset>"
    @echo ""
    @echo "Run 'just list-presets' to see available presets"
    @echo ""
    @echo "Examples:"
    @echo "  just create-devnet alphanets my-test alphanet"
    @echo "  just create-devnet betanets rehearsal-3 betanet"
    @echo "  just create-devnet alphanets reth-test reth"

# List available presets from the templates repo
list-presets:
    #!/usr/bin/env bash
    set -euo pipefail
    
    echo "Fetching presets from {{TEMPLATES_REPO}}..."
    echo ""
    
    TEMP_DIR=$(mktemp -d)
    trap "rm -rf $TEMP_DIR" EXIT
    
    git clone --depth 1 --branch {{TEMPLATES_BRANCH}} {{TEMPLATES_REPO}} "$TEMP_DIR" 2>/dev/null
    
    # Find the inventories directory
    INVENTORIES_DIR=$(find "$TEMP_DIR/cookiecutter-devnet" -type d -name "_inventories" 2>/dev/null | head -1)
    
    if [ -z "$INVENTORIES_DIR" ] || [ ! -d "$INVENTORIES_DIR" ]; then
        echo "Error: Could not find inventories directory"
        exit 1
    fi
    
    echo "Available presets:"
    for file in "$INVENTORIES_DIR"/*.yaml; do
        if [ -f "$file" ]; then
            preset=$(basename "$file" .yaml)
            printf "  %s\n" "$preset"
        fi
    done
    echo ""
    echo "Usage: just create-devnet <alphanets|betanets> <name> <preset>"

# Create a new devnet with the given name using a specific preset
create-devnet net_type name preset:
    #!/usr/bin/env bash
    set -euo pipefail
    
    # Check if cookiecutter is installed
    if ! command -v cookiecutter &> /dev/null; then
        echo "Error: cookiecutter is not installed"
        echo "Install it with: pip install cookiecutter"
        exit 1
    fi
    
    # Validate net_type
    if [[ "{{net_type}}" != "alphanets" && "{{net_type}}" != "betanets" ]]; then
        echo "Error: net_type must be 'alphanets' or 'betanets', got '{{net_type}}'"
        exit 1
    fi
    
    PRESET="{{preset}}"
    TARGET_DIR="{{net_type}}/{{name}}"
    
    # Check if directory already exists
    if [ -d "$TARGET_DIR" ]; then
        echo "Error: Devnet '{{name}}' already exists at $TARGET_DIR"
        exit 1
    fi
    
    echo "Creating {{net_type}} devnet '{{name}}' with preset '$PRESET'..."
    
    # Use the unified cookiecutter-devnet template with preset selection
    # Cookiecutter will validate the preset against cookiecutter.json choices
    if ! cookiecutter "{{TEMPLATES_REPO}}" \
        --checkout {{TEMPLATES_BRANCH}} \
        --directory "cookiecutter-devnet" \
        --no-input \
        --output-dir "{{net_type}}" \
        devnet_name="{{name}}" \
        preset="$PRESET" \
        description="$PRESET configuration for {{name}}" \
        flashblock_enabled=true 2>&1; then
        echo ""
        echo "Error: Failed to create devnet. Preset '$PRESET' may not exist."
        echo "Run 'just list-presets' to see available presets."
        exit 1
    fi
    
    echo ""
    echo "✓ Successfully created devnet: {{name}}"
    echo "  Location: $TARGET_DIR"
    echo "  Preset: $PRESET"
    echo ""
    echo "Next steps:"
    echo "  1. Edit $TARGET_DIR/manifest.yaml to configure your devnet"
    echo "  2. Edit $TARGET_DIR/inventory.yaml to configure nodes and services"
