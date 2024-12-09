// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

type asset is address;
type assetAmount is uint256;
type currency is address;
type price is uint256;

contract UserDefinedValueType {
  type orderCount is uint256;

  asset public a;
  assetAmount public b;
  currency public c;
  price public d;
  orderCount public e;

  function setValues() external {
    a = asset.wrap(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2); //WETH
    b = assetAmount.wrap(10);
    c = currency.wrap(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48); //USDC
    d = price.wrap(1250);

    orderCount orderCount1 = orderCount.wrap(4);
    orderCount orderCount2 = orderCount.wrap(3);
    orderCount orderCount3 = orderCount.wrap(2);

    // not possible, user defined value types have no operators!
    //orderCount totalOrderCount = orderCount1 + orderCount2 + orderCount3;
    // though operators can be defined with the 'using for' directive,
    // see https://soliditylang.org/blog/2023/02/22/user-defined-operators/

    uint orderCountSum = orderCount.unwrap(orderCount1)
                                     + orderCount.unwrap(orderCount2)
                                     + orderCount.unwrap(orderCount3);

    e = orderCount.wrap(orderCountSum);
  }
}