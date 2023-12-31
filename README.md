# Wave Portal Contract

## To run locally

The `run.js` file is useful to run locally the contract for test/debug purposes.

```shell
npx hardhat run scripts/run.js
```

## To deploy the contract on the Goerli testnet

Make sure to create a Quicknode account (<https://www.quicknode.com>) and create an endpoint on the ETH chain and Goerli network. When the endpoint created you will be able to get your http provider.

Install MetaMask extension to be able to get an ETH wallet. Make sure to import the Goerli testnet and fund with GoerliETH using faucets (<https://www.coingecko.com/learn/goerli-eth>). From MetaMask, you can get your wallet private key.

***Make sure to never share the private key of your wallet***

Create an `.env` file following that structure :

```
QUICK_NODE_HTTP_PROVIDER=YOUR_HTTP_PROVIDER_HERE
TESTNET_WALLET_PRIVATE_KEY=YOUR_PRIVATE_KEY_HERE
```

```shell
npx hardhat run scripts/deploy.js --network goerli
```

**Make sure to save the contract address when deployed will be useful to be able to interact with the front-end**

`https://github.com/Kevin-Lam1013/wave-portal-front-end`

## Contract ABI

When the contract deployed you can get the abi in the following path :
`root/artifacts/contracts/WavePortal.sol/WavePortal.json`
