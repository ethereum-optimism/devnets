# Default Betanet Template

Multi-chain betanet template with two chains: one permissioned and one permissionless.

## Infrastructure

### Chains
- **Chain 0** (Permissioned)
- **Chain 1** (Permissionless with `fp-permissionless` feature)

### Nodes (per chain)
- **3 Sequencer nodes**
  - 2x op-geth (full)
  - 1x op-reth (full)
- **2 RPC nodes**
  - 1x op-geth (archive)
  - 1x op-reth (archive)
- **2 Snapsync nodes**
  - 1x op-geth (full)
  - 1x op-reth (full)

### Services (per chain)
- `op-proposer` - L2 output proposals
- `op-batcher` - Transaction batching to L1
- `op-challenger` - Dispute resolution
- `proxyd-public` - Public RPC load balancer
- `peer-mgmt-service` - P2P peer management
- `op-conductor-mon` - Conductor monitoring
- `op-conductor-ops` - Conductor operations
- `op-dispute-mon` - Dispute monitoring
- `op-faucet` - Testnet faucet

### Chain-Specific Services
- **Chain 1 only**: `op-challenger-runner` - Automated challenger

### Global Services
- `op-acceptor` - Test runner

## Configuration

### Manifest
- **Type**: betanet
- **L1**: Sepolia
- **Genesis offset**: `l2GenesisIsthmusTimeOffset: "0x0"`

### Components
Includes all standard betanet components:
- op-batcher
- op-challenger
- op-conductor
- op-geth
- op-node
- op-program
- op-proposer
- op-reth
- proxyd
