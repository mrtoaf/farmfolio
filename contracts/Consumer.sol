// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./BatchNFT.sol";
import "./Packagers.sol";


contract Consumers {
    BatchNFT private nft;
    Packagers private packagers;

    constructor(address nftAddress, address packagersAddress) {
        nft = BatchNFT(nftAddress);
        packagers = Packagers(packagersAddress);
    }

    function claimBatch(uint256 tokenId) public {
        require(nft.ownerOf(tokenId) == address(packagers), "Consumers: The tokenId must be owned by the Packagers contract");
        nft.transferFrom(address(packagers), msg.sender, tokenId);
    }
    
    function viewBatchInformation(uint256 tokenId) public view returns (uint256) {
        return nft.viewBatchInformation(tokenId);
    }
}
