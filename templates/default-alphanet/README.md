# Default Alphanet Template

Full-featured alphanet template with comprehensive infrastructure for production-like testing.

## Description

This is the standard template for creating production-like alphanets. It provides a complete environment with multiple nodes, redundancy, and all standard services.

## Infrastructure

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
- `op-challenger-runner` - Challenger automation

### Global Services
- `op-acceptor` - Test runner

## Configuration

### Environment Variables
- `OP_NODE_LOG_LEVEL: info`
- `GETH_LOG_LEVEL: info`
- `OP_CONDUCTOR_LOG_LEVEL: info`

### Network
- L1: Sepolia
