-include .env

build:
	forge build

get-rpc-url:
	@case $(network) in \
		ethereum-sepolia) echo "${ETH_SEPOLIA_RPC_URL}" ;; \
		ethereum-mainnet) echo "${ETH_MAINNET_RPC_URL}" ;; \
		avalanche-fuji) echo "${AVALANCHE_FUJI_RPC_URL}" ;; \
		*) echo "Error: Unknown network: $(network)"; exit 1 ;; \
	esac

deploy:
	@rpc_url="$$(make --no-print-directory get-rpc-url network=$(network))"; \
	forge script script/DeployBasicNFT.s.sol:DeployBasicNFT --rpc-url "$$rpc_url" --account testAccount --broadcast

deploy-and-verify:
	@rpc_url="$$(make --no-print-directory get-rpc-url network=$(network))"; \
	forge script script/DeployBasicNFT.s.sol:DeployBasicNFT --rpc-url "$$rpc_url" --account testAccount --verify --etherscan-api-key ${ETHERSCAN_API_KEY} --broadcast

mint:
	@rpc_url="$$(make --no-print-directory get-rpc-url network=$(network))"; \
	forge script script/Interactions.s.sol:MintBasicNFT --rpc-url "$$rpc_url" --account testAccount --broadcast

mint-dynamic-nft:
	@rpc_url="$$(make --no-print-directory get-rpc-url network=$(network))"; \
	forge script script/Interactions.s.sol:MintDynamicNFT --rpc-url "$$rpc_url" --account testAccount --broadcast

flip-dynamic-nft-state:
	@rpc_url="$$(make --no-print-directory get-rpc-url network=$(network))"; \
	forge script script/Interactions.s.sol:FlipDynamicNFTState --rpc-url "$$rpc_url" --account testAccount --broadcast