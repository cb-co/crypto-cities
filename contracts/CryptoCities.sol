// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./Base64.sol";

contract CryptoCities is ERC721, ERC721Enumerable {
  using Counters for Counters.Counter;

  Counters.Counter private _idCounter;
  uint16 public maxSupply;

  mapping(uint256 => City) public cities;
  struct City {
    string name;
    string description;
    uint16 area;
    uint32 population;
    uint16 gdp;
  }

  constructor(uint16 _maxSupply) ERC721("CryptoCities", "CTS") {
    maxSupply = _maxSupply;
    cities[0] = City('Prague, CZ', 'Capital city of the Czech Republic, known for its Old Town Square, the heart of its historic core, with colorful baroque buildings, Gothic churches and the medieval Astronomical Clock.', 492, 1309418, 60);
    cities[1] = City('Istanbul, TR', 'Major city in Turkey that straddles Europe and Asia across the Bosphorus Strait. Its Old City reflects cultural influences of the many empires that once ruled here.', 5343, 15462452, 237);
    cities[2] = City('Rome, IT', 'Is the capital and largest city of Italy and of the Lazio region. It is famous for being the home of the ancient Roman Empire, the Seven Hills, La Dolce Vita (the sweet life), the Vatican City and Three Coins in the Fountain.', 1285, 4342212, 163);
    cities[3] = City('Singapore, SG', 'Officially the Republic of Singapore, is a sovereign island city-state in maritime Southeast Asia.', 729, 5453600, 600);
    cities[4] = City('Dubai, AE', 'City and emirate in the United Arab Emirates known for luxury shopping, ultramodern architecture and a lively nightlife scene.', 3885, 3456058, 102);
    cities[5] = City('Hong Kong, CN', 'City and special administrative region of China on the eastern Pearl River Delta in South China.', 2755, 7500700, 472);
    cities[6] = City('Bangkok, TH', 'City known for ornate shrines and vibrant street life. The boat-filled Chao Phraya River feeds its network of canals, flowing past the Rattanakosin royal district, home to opulent Grand Palace and its sacred Wat Phra Kaew Temple.', 1569, 10539000, 258);
    cities[7] = City('London, UK', 'A 21st-century city with history stretching back to Roman times. At its centre stand the imposing Houses of Parliament, the iconic Big Ben clock tower and Westminster Abbey, site of British monarch coronations.', 1572, 2709418, 682);
    cities[8] = City('New York, US', 'A city of diversity and dynamism. It is also a city of politics, economy and culture. It is even described as the economic and cultural capital of the world, and New York City is one of the most populous cities in the United States', 783, 8804190, 884);
    cities[9] = City('Paris, FR', 'Major European city and a global center for art, fashion, gastronomy and culture.', 105, 2175601, 776);
  }

  function mint() public {
    uint256 current = _idCounter.current();
    require(current < maxSupply, 'No CryptoCities left :(.');

    _safeMint(msg.sender, current);
    _idCounter.increment();
  }

  function tokenURI(uint256 tokenId) public view override returns(string memory) {
    require(_exists(tokenId), "ERC721 Metadata: URI query for non existent token");

    string memory jsonURI = Base64.encode(
      abi.encodePacked(
        '{ "name": "', cities[tokenId].name, '",',
        '"name": "', cities[tokenId].description, '",',
        '"image": "ipfs://QmVpDJfMPvf9x1vWZQQ9W7wUXvMxWQ44Rxe6e3U4Gsvfi2/', tokenId, '.png",',
        '"attributes": [{"trait_type": "area", "value": ', cities[tokenId].area, '},',
        '{"trait_type": "population", "value": ', cities[tokenId].population, '},',
        '{"trait_type": "GDP", "value": ', cities[tokenId].gdp, '}]}'
      )
    );

    return string(abi.encodePacked("data:application/json;base64,", jsonURI));
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