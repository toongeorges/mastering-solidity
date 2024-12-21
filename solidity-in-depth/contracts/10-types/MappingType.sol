// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

string constant s1 = "Horum omnium fortissimi sunt Belgae";
string constant s2 = "propterea quod a cultu atque humanitate\
provinciae longissime absunt";
string constant s3 = "minimeque ad eos mercatores saepe commeant\
atque ea quae ad effeminandos animos pertinent important";
string constant s4 = "proximique sunt Germanis";
string constant s5 = "qui trans Rhenum incolunt";
string constant s6 = "quibuscum continenter bellum gerunt";

struct Point {
  uint16 id;
  int32 x;
  int32 y;
}

contract MappingType {
  mapping(uint8 => uint8) public bytesMapping;
  mapping(string => Point) public points;
  mapping(uint16 => mapping(uint16 => uint16)) pointConnections;

  function setValues() external {
    bytesMapping[1] = 0x11;
    bytesMapping[2] = 0x22;
    bytesMapping[3] = 0x33;
    bytesMapping[4] = 0x44;
    bytesMapping[5] = 0x55;

    points[s1] = Point({id: 6, x: -6, y: 6});
    points[s2] = Point({id: 7, x: -7, y: 7});
    points[s3] = Point({id: 8, x: -8, y: 8});
    points[s4] = Point({id: 9, x: -9, y: 9});
    points[s5] = Point({id: 10, x: -10, y: 10});
    points[s6] = Point({id: 11, x: -11, y: 11});

    mapping(uint16 => uint16) storage c = pointConnections[6];
    c[7] = 6;
    c[9] = 6;
    c = pointConnections[7];
    c[8] = 7;
    c = pointConnections[9];
    c[10] = 9;
    c[11] = 9;
  }
}