// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Code_Masters is ERC721, ERC721Enumerable, ERC721Pausable, Ownable {
    uint256 private _nextTokenId;
    uint256 public constant MAX_SUPPLY = 10;
    uint256 public constant MAX_MINT_PER_WALLET = 2;
    mapping(address => uint256) private _walletMints;

    constructor(address initialOwner)
        ERC721("Code_Masters", "CMS")
        Ownable(initialOwner)
    {}

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://QmdRMFWDSjyTsSP1tnsnHZwJA5td79jD3Y4dvcEzhGRoPt/";
    }

    function PublicMint() public payable {
        require(_nextTokenId < MAX_SUPPLY, "Max supply reached");
        require(_walletMints[msg.sender] < MAX_MINT_PER_WALLET, "Max mint per wallet reached");
        require(msg.value == 0.001 ether, "Not Enough Funds");

        uint256 tokenId = _nextTokenId++;
        _walletMints[msg.sender]++;
        _safeMint(msg.sender, tokenId);
    }

    function totalMinted() public view returns (uint256) {
    return _nextTokenId;
}


    // The following functions are overrides required by Solidity.

    function _update(address to, uint256 tokenId, address auth)
        internal
        override(ERC721, ERC721Enumerable, ERC721Pausable)
        returns (address)
    {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(address account, uint128 value)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._increaseBalance(account, value);
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