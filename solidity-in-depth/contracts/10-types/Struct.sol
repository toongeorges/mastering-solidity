// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

type id is uint;

enum Month {
  JANUARY, FEBRUARY, MARCH, APRIL, MAY, JUNE,
  JULY, AUGUST, SEPTEMBER, OCTOBER, NOVEMBER, DECEMBER
}

struct Date {
  uint16 year;
  Month month;
  uint8 day;
}

struct Person {
  id id;
  string name;
  Date birthday;
  bool gender;
  id fatherId;
  id motherId;
}

contract Struct {
  Person abraham;
  Person homer;
  Person marge;
  Person bart;
  Person bart2;
  Person lisa;
  Person maggie;

  function setValues() external {
    abraham = Person({
      id: id.wrap(1), fatherId: id.wrap(0), motherId: id.wrap(0),
      name: "Abraham Jebediah Simpson II", gender: true,
      birthday: Date({ year: 1907, month: Month.MAY, day: 25 })
    });
    homer = Person({
      id: id.wrap(2), fatherId: id.wrap(1), motherId: id.wrap(0),
      name: "Homer Jay Simpson", gender: true,
      birthday: Date({ year: 1951, month: Month.MAY, day: 12 })
    });
    marge = Person({
      id: id.wrap(3), fatherId: id.wrap(0), motherId: id.wrap(0),
      //string of more than 31 bytes behaves differently
      name: "Marjorie Jacqueline Simpson Bouvier", gender: false,
      birthday: Date({ year: 1953, month: Month.MARCH, day: 19 })
    });
    bart = Person({
      id: id.wrap(4), fatherId: id.wrap(2), motherId: id.wrap(3),
      name: "Bartholomew JoJo Simpson", gender: true,
      birthday: Date({ year: 1980, month: Month.APRIL, day: 1 })
    });
    bart2 = bart;
    lisa = Person({
      id: id.wrap(5), fatherId: id.wrap(2), motherId: id.wrap(3),
      name: "Lisa Marie Simpson", gender: false,
      birthday: Date({ year: 1982, month: Month.MAY, day: 9 })
    });
    maggie = Person({
      id: id.wrap(6), fatherId: id.wrap(2), motherId: id.wrap(3),
      name: "Margaret Evelyn Lenny Simpson", gender: false,
      birthday: Date({ year: 1989, month: Month.JANUARY, day: 12 })
    });
  }
}