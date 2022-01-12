// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./Base64.sol";

contract CryptoCities is ERC721, ERC721Enumerable {
  using Counters for Counters.Counter;

  Counters.Counter private _idCounter;
  uint8 public maxSupply;

  constructor(uint8 _maxSupply) ERC721("CryptoCities", "CTS") {
    maxSupply = _maxSupply;
  }

  function mint() public {
    uint256 current = _idCounter.current();
    require(current < maxSupply, 'No CryptoCities left :(.');

    _safeMint(msg.sender, current);
    _idCounter.increment();
  }

  function tokenURI(uint256 tokenId) public view override returns(string memory) {
    require(_exists(tokenId), "ERC721 Metadata: URI query for non existent token");

    return string(abi.encodePacked("https://gateway.pinata.cloud/ipfs/QmVd1vp1cbo2No2JZKxEwxY8eqKD6T67vh5okyb5AVQTiE/", Strings.toString(tokenId), ".json"));
  }

  // The following functions are overrides required by Solidity.

  function _beforeTokenTransfer(address from, address to, uint256 tokenId)
      internal
      override(ERC721, ERC721Enumerable)
  {
      super._beforeTokenTransfer(from, to, tokenId);
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