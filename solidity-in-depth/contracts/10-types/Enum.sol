// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

enum WeekDay {
  MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY
}

contract Enum {
  enum Month {
    JANUARY, FEBRUARY, MARCH, APRIL, MAY, JUNE,
    JULY, AUGUST, SEPTEMBER, OCTOBER, NOVEMBER, DECEMBER
  }

  WeekDay public a;
  WeekDay public b;
  WeekDay public b2;
  WeekDay public c;
  WeekDay public d;
  WeekDay public e;
  WeekDay public f;
  WeekDay public g;

  Month public h;
  Month public i;
  Month public j;
  Month public k;
  Month public l;
  Month public m;
  Month public n;
  Month public o;
  Month public p;
  Month public q;
  Month public r;
  Month public s;
  Month public s2;

  function setValues() external {
    a = WeekDay.MONDAY;
    b = WeekDay.TUESDAY;
    b2 = b;
    c = WeekDay.WEDNESDAY;
    d = WeekDay.THURSDAY;
    e = WeekDay.FRIDAY;
    f = WeekDay.SATURDAY;
    g = WeekDay.SUNDAY;

    h = Month.JANUARY;
    i = Month.FEBRUARY;
    j = Month.MARCH;
    k = Month.APRIL;
    l = Month.MAY;
    m = Month.JUNE;
    n = Month.JULY;
    o = Month.AUGUST;
    p = Month.SEPTEMBER;
    q = Month.OCTOBER;
    r = Month.NOVEMBER;
    s = Month.DECEMBER;
    s2 = s;
  }

  function getWeekDayRange() external pure returns (WeekDay, WeekDay) {
    return (type(WeekDay).min, type(WeekDay).max);
  }

  function getMonthRange() external pure returns (Month, Month) {
    return (type(Month).min, type(Month).max);
  }
}