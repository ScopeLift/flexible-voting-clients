# Flexible Voting Clients 

[Flexible Voting](https://github.com/ScopeLift/flexible-voting) is an extension to the widely used [OpenZeppelin Governor](https://docs.openzeppelin.com/contracts/4.x/api/governance#Governor) that enables novel voting patterns for delegates. Clients are contracts that leverage Flexible Voting to allow they these novel voting patterns, such as:


  - Voting with tokens while earning yield in DeFi
  - Voting with tokens bridged to L2
  - Shielded voting (i.e. secret/private voting)
  - Cheaper subsidized signature based voting

The Flexible Voting Clients repo contains existing clients and the necessary tools to build new clients.

#### Getting started

Clone the repo

```bash
git clone git@github.com:ScopeLift/flexible-voting-clients.git
cd flexible-voting-clients
```

Copy the `.env.template` file and populate it with values

```bash
cp .env.template .env
# Open the .env file and add your values
```

```bash
forge install
forge build
forge test
```

#### Repo Contents

| Name               | Description                                                                                                                                                                                    | Contract                                           |
|--------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------|
| Aave AToken Client | An extension of Aave V3's AToken contract which makes it possible for AToken holders to still vote on governance proposals                                                                    | [ATokenFlexVoting](./src/ATokenFlexVoting.sol)     |
| Comet Client       | This is an extension of Compound V3's Comet contract which makes it possible for Comet token holders to still vote on governance proposals.                                                    | [CometFlexVotingClient](./src/CometFlexVoting.sol) |
| Flex Voting Client |This is an abstract contract to make it easy to build clients for governance systems that are "flexible voting" governors. The above clients inherit from this contract. | [FlexVotingClient](./src/FlexVotingClient.sol) |

## License

Fractional Voting is available under the [MIT](LICENSE.txt) license.

Copyright (c) 2023 ScopeLift
