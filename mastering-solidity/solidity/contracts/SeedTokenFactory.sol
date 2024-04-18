// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import 'contracts/SeedToken.sol';

contract SeedTokenFactory {
  address[] public tokens;

  event SeedTokenCreation(
    address tokenAddress,
    address indexed owner,
    string indexed name,
    string indexed symbol
  );

  function getNumberOfTokens() external view returns (uint256) {
    return tokens.length;
  }

  function create(string memory name, string memory symbol) external {
    address tokenAddress = address(new SeedToken(msg.sender, name, symbol));
    tokens.push(tokenAddress);

    emit SeedTokenCreation(tokenAddress, msg.sender, name, symbol);
  }
}