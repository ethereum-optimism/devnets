# Devnets

The Platforms team maintains two parallel devnets. Protocol upgrades promote from one network to the next, until they are eventually deployed to our production Sepolia testnet. The devnets are:

- **Alphanet:** Contains production-bound protocol upgrades that will be scheduled in *some* upcoming hardfork. All updates are active at genesis. The purpose of this devnet is to deploy protocol upgrades earlier, and to decouple deployment from hardfork scheduling. Protocol upgrades **must** be deployed on Alphanet before being deployed on the Betanet.
- **Betanet:** Contains production-bound protocol upgrades that will be scheduled in the *next* hardfork. Upgrades are activated after genesis using hardfork timestamps. The purpose of this hardfork is to validate the upgrade process, and solidify the scope of a hardfork before activating it on our production testnet. Protocol upgrades **must** be deployed on the betanet before being deployed on testnet.

Alphanets and Betanets are deployed on an ad-hoc basis as features become ready for the next hardfork.

# Operations

Devnet coordination will be centered around this repostory.

## Issues

### Scoping Issue

Devnet requests are raised to Platforms as features are developed. The recurring upgrades standups act as a regular forum for cross-team alignment around devnet needs.

Devnet scope is captured in GitHub issues in this repo. Aspirationally, it should include a list of features, each containing:

- A short description of the feature
- Monitoring / alerting requirements, new metrics to be aware of
- Documentation of any api or operational changes
- Known issues / limitations
- Acceptance testing plan

### Support Issue

Devnets are public and we need a place to report issues for anyone participating in devnet testing.

## Files

### Manifest File

Before we deploy a devnet we will publish a deployment manifest, including:

- Devnet name
- L1 Config
- L2 Configs
  - Software versions (docker image tags ideally)
  - Contracts versions (can be a sha or tag)
  - Configuration flags that need to be set on node software

When we make changes to devnets, including bug fix deployments, etc we will update this file so external users can follow the upgrades.

See [MANIFEST.md](./MANIFEST.md) for the manifest file format and example.

### Artifact File

After the devnet is deployed we publish a deployment artifacts file, including:
- Public RPC urls
- Public Devnet health dashboard url
- Genesis / Rollup jsons
- Contract addresses

## Timeline


Alphanets and Betanets are deployed on an as-needed basis following a roughly 3-4 week lifecycle as outlined in the table below.

We are deliberately limiting the amount of time devnets stick around so folks do not rely on them long-term.

| Time | Activities |
|------|------------|
| D-5 | - Platforms and protocol define devnet scope + config |
| D-2 | - Pull request for devnet manifest is created, reviewed, merged. |
| D-1 | - Deploy the devnet<br>- Run basic network smoke tests |
| D-0 | - Create the devnet artifact file PR. Review and Merge.<br>- Devnet is made public |
| W1 | - Feature acceptance testing (prioritize feedback on feature quality so bug fixes can be made) |
| W2 | - Feature acceptance testing<br>- Fault injection testing (looking to see how we can break the network, test incident response runbooks, ensure monitoring and alerting is working) |
| W3 | - Feature acceptance testing<br>- Load testing (validate performance under stress) |
