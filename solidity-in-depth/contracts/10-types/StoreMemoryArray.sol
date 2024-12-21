// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract StoreMemoryArray {
  struct Point2 {
    uint8 x;
    uint8 y;
  }

  uint8[4] valueTypeArray;
  uint8[] dynamicValueTypeArray;
  Point2[5] referenceTypeArray;

  function setValues() external {
    uint8[4] memory vT; 
    vT[0] = 1;
    vT[1] = 2;
    vT[2] = 3;
    vT[3] = 4;
    valueTypeArray = vT;
    dynamicValueTypeArray = vT;

    Point2[5] memory rT;
    rT[0] = Point2(6, 7);
    rT[1] = Point2(8, 9);
    rT[2] = Point2(10, 11);
    rT[3] = Point2(12, 13);
    rT[4] = Point2(14, 15);
    //The following line causes a compiler error!
    //referenceTypeArray = rT;
    //reference type values have to be stored one by one instead:
    referenceTypeArray[0] = rT[0];
    referenceTypeArray[1] = rT[1];
    referenceTypeArray[2] = rT[2];
    referenceTypeArray[3] = rT[3];
    referenceTypeArray[4] = rT[4];
  }
}