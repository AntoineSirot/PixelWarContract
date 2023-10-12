// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PixelGrid is ERC721, Pausable, Ownable {
    // Auto-incrementation for NFT's ids
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    struct Pixel {
        uint red;
        uint green;
        uint blue;
    }

    Pixel[] public pixels;
    uint public currentPrice;

    error InsufficientPrice(uint valueSent, uint valueNeeded);

    constructor(
        string memory name,
        string memory symbol,
        uint firstPrice,
        uint width,
        uint height
    ) ERC721(name, symbol) {
        currentPrice = firstPrice;
        for (uint i = 0; i < (width * height); i++) {
            pixels.push(Pixel(0, 0, 0));
            _mint(address(this), _tokenIdCounter.current());
            _tokenIdCounter.increment();
        }
    }

    function buyPixel(uint tokenId, uint[3] memory colors) public payable {
        if (msg.value < currentPrice) {
            revert InsufficientPrice(msg.value, currentPrice);
        }
        if (ownerOf(tokenId) != address(this)) {
            payable(ownerOf(tokenId)).transfer(currentPrice);
        }
        _transfer(ownerOf(tokenId), msg.sender, tokenId);
        pixels[tokenId] = Pixel(colors[0], colors[1], colors[2]);
        currentPrice = (currentPrice * 3) / 2;
    }
}
