# Devnets

The Platforms team maintains two parallel devnets. Protocol upgrades promote from one network to the next, until they are eventually deployed to our production Sepolia testnet. The devnets are:

- **Alphanet:** Contains production-bound protocol upgrades that will be scheduled in *some* upcoming hardfork. All updates are active at genesis. The purpose of this devnet is to deploy protocol upgrades earlier, and to decouple deployment from hardfork scheduling. Protocol upgrades **must** be deployed on Alphanet before being deployed on the Betanet.
- **Betanet:** Contains production-bound protocol upgrades that will be scheduled in the *next* hardfork. Upgrades are activated after genesis using hardfork timestamps. The purpose of this hardfork is to validate the upgrade process, and solidify the scope of a hardfork before activating it on our production testnet. Protocol upgrades **must** be deployed on the betanet before being deployed on testnet.

Alphanets and Betanets are deployed on an ad-hoc basis as features become ready for the next hardfork.

# Operations

Devnet coordination will be centered around this repostory. Devnet requests are raised to Platforms as features are developed by creating an issue in this repo using [this link](https://github.com/ethereum-optimism/devnets/issues/new?template=devnet-request.yml).

Protocol teams should reach out about devnet needs proactively, ideally at the start of new feature development. Waiting until late in the process impacts the Platform team’s ability to support in a timely and effective manner, which can delay feature validation and impact timelines.

For contracts changes in particular, please allow for at least a few days between a new contracts release and devnet spin up to leave enough time to validate and make a new corresponding op-deployer release.

Below is a set of questions to ask early during feature development:
- **Do I need a devnet for this feature?** Note that at minimum a betanet is required for features that go through the governance process (more info [here](https://docs.google.com/document/d/11dHFxW5YpVaCtIbDQLM1wBAUNKecMIevnUPsR2pMstg/edit?usp=sharing))
- **When will I need this devnet and at what stage of feature development?** In particular, please validate what you can locally with sysgo and strong test coverage before proceeding to a devnet
- **What are my testing needs and what do I intend to validate?** This will inform whether you need a one-off devnet (e.g., for an early experimental POC) vs. an alphanet or betanet that is production-bound, whether you’re running regular acceptance tests against the devnet vs. performance benchmarks, etc.
- **Are any topology changes expected?** For example, introducing a new OP Stack component like supervisor, the need to connect a sequencer to multiple EL clients instead of just one, etc. Topology changes need deeper involvement from Platforms and require tooling changes, so please reach out especially early to discuss these use cases

The recurring upgrades standups should also be leveraged as a regular forum for cross-team alignment around devnet needs.

## Issues

### Scoping Issue

Devnet scope is captured in GitHub issues in this repo and should include a list of features, each containing:

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
