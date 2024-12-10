// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

enum WeekDay {
  MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY
}

contract EnumExplicitConversion {
  WeekDay public a;
  WeekDay public b;

  uint8 public c;
  uint public d;

  function setValues() external {
    a = WeekDay(2);
    b = WeekDay(5);
    c = uint8(WeekDay.TUESDAY);
    d = uint(WeekDay.THURSDAY);
  }

  function getWeekDay(int day) external pure returns (WeekDay) {
    return WeekDay(day);
  }
}