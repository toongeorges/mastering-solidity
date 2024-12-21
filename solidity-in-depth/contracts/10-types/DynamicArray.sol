// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

struct Point {
  uint16 id;
  int32[3] coordinates;
}

contract DynamicArray {
  uint80[] fibonacciDynamic;
  Point[] points;
  uint8[][] primes;

  function setValues() external {
    fibonacciDynamic.push(55);
    fibonacciDynamic.push(89);
    fibonacciDynamic.push(144);
    fibonacciDynamic.push(233);
    fibonacciDynamic.push(377);
    fibonacciDynamic.push(610);
    fibonacciDynamic.push(987);
    fibonacciDynamic.push(1597);
    fibonacciDynamic.push(2584);
    fibonacciDynamic.push(4181);

    points.push(Point({id: 1, coordinates: [int32(-1), int32(1), int32(-1)]}));
    points.push(Point({id: 2, coordinates: [int32(-2), 2, -2]}));
    points.push(Point({id: 3, coordinates: [int32(-3), 3, -3]}));
    points.push(Point({id: 4, coordinates: [int32(-4), 4, -4]}));
    points.push(Point({id: 5, coordinates: [int32(-5), 5, -5]}));

    uint8[] storage primeArray = primes.push();
    primeArray.push(2);
    primeArray.push(3);
    primeArray.push(5);
    primeArray.push(7);
    primeArray = primes.push();
    primeArray.push(11);
    primeArray.push(13);
    primeArray.push(17);
    primeArray.push(19);
    primeArray = primes.push();
    primeArray.push(23);
    primeArray.push(29);
  }
}