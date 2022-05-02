// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.5.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.5.0/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.5.0/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.5.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.5.0/utils/Counters.sol";
//Here is the code i used
contract SoulRune is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    //Using balanceof instead, commented out mapping method
    //SET "GLOBAL" VARS TO HELP LATER
    uint256 public MAX_SUPPLY = 10000;
    uint256 public MAX_MINT_AMT = 5;
//"Hash" mapped each address into a 256uint which stores total minted amount;
    //mapping(address=>uint256) public IMintedThisMuch;
    Counters.Counter private _tokenIdCounter;
    
    constructor() ERC721("SoulRune", "SLR") {}
    //remove only owner to allow anyone to mint
    function safeMint(address to, string memory uri) public {
        //add max mint limit per collection
        require(_tokenIdCounter.current()<=MAX_SUPPLY, "The collection is filled.");
        //add max mint limit per wallet condi
        //require(IMintedThisMuch[to]<=MAX_MINT_AMT, "You have already minted have 5 NFT. Change wallet or procure through other means");
        require(balanceOf(to)<MAX_MINT_AMT, "You have already minted have 5 NFT. Change wallet or procure through other means");
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        //incremented minting by 1 on address who minted
        //IMintedThisMuch[to]+=1;
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}