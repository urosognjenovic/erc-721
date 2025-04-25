## ERC721

This is an ERC721 project which includes `BasicNFT` and `DynamicNFT` contracts.

## Tools Used

- **Foundry**
- **IPFS**
- **Pinata**

## BasicNFT

`BasicNFT` is a simple ERC721 contract that allows anyone to mint a token. 

The `MintBasicNFT` script uses a `tokenURI` stored on [Pinata](https://yellow-raw-bear-827.mypinata.cloud/ipfs/bafkreihoixbxvitnwoto7cjipxiin2vsgg7fqypylldzlbzxetkji74pcu).

## DynamicNFT

`DynamicNFT` is an ERC721 contract that allows the user to change the NFT image URI by calling the `flipState` function. Currently, the contract supports only two states, but it is possible to add more states to reflect different conditions, such as:
- Seasons (winter, spring, summer, and autumn),
- Bull and bear markets,
- Chinese zodiac,
- etc.

`DynamicNFT` uses SVG images that are stored onchain (`imageURI`) and creates the `tokenURI` by leveraging OpenZeppelin's `Base64` library.

## Getting started

Clone the project:

```
git clone https://github.com/urosognjenovic/erc-721
```

Copy the content of `.env.example` to `.env`:

```
cp -v .env.example .env
```

Replace the strings in `.env` with your environment variables (Etherscan API key and RPC URLs).

Import a private key using `cast`. The `testAccount` account is used in Makefile. In case you don't want to use this name, make sure to adjust the Makefile targets.

```
cast wallet import testAccount --private-key YOUR_PRIVATE_KEY
```

Build the project:

```
make build
```

### Deploy and mint BasicNFT

Deploy the `BasicNFT` contract to the Ethereum mainnet. View the list of supported networks in the Makefile `get-rpc-url` target.

```
make deploy network=ethereum-mainnet
```

Run `make deploy-and-verify network=ethereum-mainnet` to verify the contract during the deployment.

Mint a `BasicNFT`:

```
make mint network=ethereum-mainnet
```

### Deploy and mint DynamicNFT

There are two scripts for deploying the `DynamicNFT` contract:
- `DeployDynamicNFT`: Deploys the `DynamicNFT` contract using the hardcoded `FIRST_SVG` and `SECOND_SVG` base64 encoded image URIs.
- `EncodeAndDeployDynamicNFT`: Reads the SVG files `firstImage.svg` and `secondImage.svg` stored in the ./svg folder using the `vm.readFile` Foundry cheatcode and encodes it in base64 format using the OpenZeppelin's Base64 library. These SVGs can be changed (while keeping the names used by the script).

Deploy the `DynamicNFT` contract to the Ethereum mainnet using the `DeployDynamicNFT` script.

```
make deploy-dynamic-nft network=ethereum-mainnet
```

Deploy the `DynamicNFT` contract to the Ethereum mainnet using the `EncodeAndDeployDynamicNFT` script.

```
make encode-and-deploy-dynamic-nft network=ethereum-mainnet
```

Mint a `DynamicNFT`:

```
make mint-dynamic-nft network=ethereum-mainnet
```

To flip the state of the NFT:

```
make flip-dynamic-nft-state network=ethereum-mainnet
```

## Upgrade ideas

- Implement Chainlink Automation to automate the changing of the state.
- Use Filecoin for storing the images (.png, .jpg) onchain.