// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./BatchNFT.sol";

contract Packagers {
    BatchNFT private nft;

    constructor(address nftAddress) {
        nft = BatchNFT(nftAddress);
    }

    function createSmallerBatch(uint256 tokenId, uint256 weightToSplit) public {
        require(nft.ownerOf(tokenId) == address(this), "Packagers: The tokenId must be owned by this contract");

        uint256 currentWeight = nft.weights(tokenId);
        require(currentWeight >= weightToSplit, "Insufficient weight");

        uint256 newWeight = currentWeight - weightToSplit;
        nft.updateWeight(tokenId, newWeight);

        string memory tokenURI = nft.tokenURI(tokenId);
        string memory genetics = nft.genetics(tokenId);
        string memory nutrients = nft.nutrients(tokenId);
        string memory lighting = nft.lighting(tokenId);
        uint256 newTokenId = nft.safeMint(tokenURI, weightToSplit, genetics, nutrients, lighting);

        nft.transferFrom(address(nft), address(this), newTokenId);
    }

    function receiveBatch(uint256 tokenId, uint256 weight) public {
        require(nft.ownerOf(tokenId) == msg.sender, "Packagers: Caller must be the owner of the batch");
        nft.updateWeight(tokenId, weight);
    }

}
