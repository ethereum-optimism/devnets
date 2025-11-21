# Show available commands and usage
default:
    @echo "Devnet Management Commands"
    @echo "=========================="
    @echo ""
    @echo "Usage: just <command> [arguments]"
    @echo ""
    @echo "Commands:"
    @echo "  list-templates"
    @echo "      List all available devnet templates"
    @echo ""
    @echo "  create-devnet <net_type> <name> <template>"
    @echo "      Create a new devnet"
    @echo "      - net_type: 'alphanets' or 'betanets' (required)"
    @echo "      - name: devnet name (required)"
    @echo "      - template: template to use (required)"
    @echo ""
    @echo "  create-default-devnet <name>"
    @echo "      Create a new alphanet devnet with default-alphanet template (backward compatibility)"
    @echo ""
    @echo "Examples:"
    @echo "  just list-templates"
    @echo "  just create-devnet alphanets my-test default-alphanet"
    @echo "  just create-devnet betanets rehearsal-3 default-betanet"
    @echo "  just create-devnet alphanets my-rust-test rust-stack"
    @echo ""
    @echo "Available templates:"
    @ls -1 templates/ 2>/dev/null | grep -v README | sed 's/^/  - /' || echo "  (run 'just list-templates' to see)"

# List available devnet templates
list-templates:
    @echo "Available devnet templates:"
    @ls -1 templates/ | sed 's/^/  - /'

# Create a new devnet with the given name using a specific template
create-devnet net_type name template:
    #!/usr/bin/env bash
    set -euo pipefail
    
    # Validate net_type
    if [[ "{{net_type}}" != "alphanets" && "{{net_type}}" != "betanets" ]]; then
        echo "Error: net_type must be 'alphanets' or 'betanets', got '{{net_type}}'"
        exit 1
    fi
    
    TEMPLATE_DIR="templates/{{template}}"
    TARGET_DIR="{{net_type}}/{{name}}"
    
    # Check if template exists
    if [ ! -d "$TEMPLATE_DIR" ]; then
        echo "Error: Template '{{template}}' not found at $TEMPLATE_DIR"
        echo ""
        echo "Available templates:"
        ls -1 templates/ | sed 's/^/  - /'
        exit 1
    fi
    
    # Check if directory already exists
    if [ -d "$TARGET_DIR" ]; then
        echo "Error: Devnet '{{name}}' already exists at $TARGET_DIR"
        exit 1
    fi
    
    # Create the devnet directory
    echo "Creating {{net_type}} devnet '{{name}}' from template '{{template}}'..."
    mkdir -p "$TARGET_DIR"
    
    # Copy default inventory.yaml
    if [ -f "$TEMPLATE_DIR/default-inventory.yaml" ]; then
        echo "  Copying inventory.yaml..."
        cp "$TEMPLATE_DIR/default-inventory.yaml" "$TARGET_DIR/inventory.yaml"
    fi
    
    # Copy default manifest.yaml and replace DEVNET_NAME placeholder
    if [ -f "$TEMPLATE_DIR/default-manifest.yaml" ]; then
        echo "  Copying manifest.yaml..."
        cp "$TEMPLATE_DIR/default-manifest.yaml" "$TARGET_DIR/manifest.yaml"
        sed -i '' "s/DEVNET_NAME/{{name}}/g" "$TARGET_DIR/manifest.yaml"
    fi
    
    echo "✓ Successfully created devnet: {{name}}"
    echo "  Network type: {{net_type}}"
    echo "  Template: {{template}}"
    echo "  Location: $TARGET_DIR"
    echo "  Files created:"
    [ -f "$TARGET_DIR/inventory.yaml" ] && echo "    - $TARGET_DIR/inventory.yaml"
    [ -f "$TARGET_DIR/manifest.yaml" ] && echo "    - $TARGET_DIR/manifest.yaml"
    echo ""
    echo "Next steps:"
    echo "  1. Edit $TARGET_DIR/manifest.yaml to configure your devnet"
    echo "  2. Edit $TARGET_DIR/inventory.yaml to configure nodes and services"

# Backward compatibility alias (defaults to alphanets with default-alphanet template)
create-default-devnet name: (create-devnet "alphanets" name "default-alphanet")
