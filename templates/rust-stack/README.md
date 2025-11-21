# Rust Stack Template

Minimal devnet using only Rust-based execution clients (op-reth).

## Description

This template creates a lightweight devnet using exclusively op-reth as the execution layer client. It's designed for testing Rust stack components and validating op-reth functionality.

## Infrastructure

### Nodes
- **1 Sequencer node**
  - op-reth (full)
  - op-node
- **1 RPC node**
  - op-reth (archive)
  - op-node

### Services
- `op-proposer` - L2 output proposals
- `op-batcher` - Transaction batching to L1
- `op-challenger` - Dispute resolution

### Environment Variables
- `OP_NODE_LOG_LEVEL: info`
- `RUST_LOG: info`

## Configuration

### Network
- L1: Sepolia

### Components
Focus on Rust stack:
- op-reth (execution layer)
- op-node (consensus layer)
- Core L2 services only

