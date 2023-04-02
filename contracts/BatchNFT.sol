// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract BatchNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    mapping(uint256 => uint256) public weights;
    mapping(uint256 => string) public genetics;
    mapping(uint256 => string) public nutrients;
    mapping(uint256 => string) public lighting;

    constructor() ERC721("Batch", "B") {}

    function safeMint(
        string memory tokenURI,
        uint256 weight,
        string memory _genetics,
        string memory _nutrients,
        string memory _lighting
    ) public {
        uint256 tokenId = _tokenIdCounter.current();
        _safeMint(address(this), tokenId);
        _setTokenURI(tokenId, tokenURI);
        weights[tokenId] = weight;
        genetics[tokenId] = _genetics;
        nutrients[tokenId] = _nutrients;
        lighting[tokenId] = _lighting;
        _tokenIdCounter.increment();
    }

    function updateWeight(uint256 tokenId, uint256 newWeight) public {
        weights[tokenId] = newWeight;
    }


    function burn(uint256 tokenId) public {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "BatchNFT: caller is not owner nor approved");
        _burn(tokenId);
    }

    function viewBatchInformation(uint256 tokenId) public view returns (uint256) {
      require(_exists(tokenId), "CannabisBatchNFT: TokenId does not exist");
      uint256 weight = weights[tokenId];
      return (weight);
    }


    // Implement this function in your web app or use an off-chain solution
    // to generate a QR code containing a link to redeem the NFT
    function generateQRCode(uint256 tokenId) public view returns (string memory) {
        // Generate a URL or other data for the QR code that links to the consumer's redeem action
    }
}
