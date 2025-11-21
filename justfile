# Import all devnet management commands from templates
import 'templates/justfile'

# Default recipe delegates to imported justfile
[private]
@_default:
    just default
