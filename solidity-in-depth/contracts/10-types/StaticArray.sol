// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract StaticArray {
  uint80[10] public fibonacciFixed;
  //In Solidity, unlike in other programming languages, the first index comes last!
  string[2][3] letters;

  function setValues() external {
    fibonacciFixed[0] = 0;
    fibonacciFixed[1] = 1;
    fibonacciFixed[2] = 1;
    fibonacciFixed[3] = 2;
    fibonacciFixed[4] = 3;
    fibonacciFixed[5] = 5;
    fibonacciFixed[6] = 8;
    fibonacciFixed[7] = 13;
    fibonacciFixed[8] = 21;
    fibonacciFixed[9] = 34;

    letters[0][0] = "a";
    letters[1][0] = "e";
    letters[2][0] = "i";
    letters[0][1] = "b";
    letters[1][1] = "c";
    letters[2][1] = "d";
  }
}