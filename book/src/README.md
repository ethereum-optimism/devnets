# Devnet Process

The OP Labs team maintains two parallel devnets. Protocol upgrades promote from one network to the next, until they
are eventually deployed to our production Sepolia testnet. The devnets are:

- **Alphanet:** Contains production-bound protocol upgrades that will be scheduled in *some* upcoming hardfork. All
  updates are active at genesis. The purpose of this devnet is to deploy protocol upgrades earlier, and to decouple
  deployment from hardfork scheduling. Protocol upgrades **must** be deployed on Alphanet before being deployed on the
  Betanet.
- **Betanet:** Contains production-bound protocol upgrades that will be scheduled in the *next* hardfork. Upgrades are
  activated after genesis using hardfork timestamps. The purpose of this hardfork is to validate the upgrade process,
  and solidify the scope of a hardfork before activating it on our production testnet. Protocol upgrades **must** be
  deployed on the betanet before being deployed on testnet.

The Alphanet is deployed on a monthly basis. The Alphanet will be redeployed even if there are no changes to prevent a
devnet from becoming someone’s production network. The Betanet is deployed on an ad-hoc basis when we’re ready to cut
the next hardfork, and will persist until the next Betanet is cut.

# About This Site

This site contains documentation and network configuration information for all devnets. Network documentation is
generated from the chain manifest files in the `alphanets` and `betanets` directory. See
the [source](https://github.com/ethereum-optimism/devnets) for more information.