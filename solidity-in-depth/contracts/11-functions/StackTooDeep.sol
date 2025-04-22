// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract FunctionTooManyParameters {
  function tooManyParameters(
    uint, uint, uint, uint,
    uint, uint, uint, uint,
    uint, uint, uint//, uint //CompilerError: Stack too deep.
  ) external {}
}

contract FunctionTooManyLocalVariables {
  uint public z = 1;

  function tooManyLocalVariables() external {
    uint a = z%2;
    uint b = z%3;
    uint c = z%5;
    uint d = z%7;
    uint e = z%11;
    uint f = z%13;
    uint g = z%17;
    uint h = z%19;
    uint i = z%23;
    uint j = z%29;
    uint k = z%31;
    uint l = z%37;
    //uint m = z%41; //CompilerError: Stack too deep.

    z = a + b + c + d + e;
    z = z + f + g + h + i;
    z = z + j + k + l;
    //CompilerError: Stack too deep.
    //z = a + b + c + d + e + f + g + h + i;
  }
}

contract FunctionReturnStackTooDeep {
  function stackTooDeep() external pure
  returns (
    uint, uint, uint, uint,
    uint, uint, uint, uint, 
    uint, uint, uint, uint//, uint //CompilerError: Stack too deep.
  ) {
    return (
        1, 2, 3, 4,
        5, 6, 7, 8,
        9, 10, 11, 12//, 13 //CompilerError: Stack too deep.
    );
  }
}

struct Parameters {
    uint p0;  uint p1;  uint p2;  uint p3;
    uint p4;  uint p5;  uint p6;  uint p7;
    uint p8;  uint p9;  uint p10; uint p11;
    uint p12; uint p13; uint p14; uint p15;
}

struct LocalVariables {
    uint l0;  uint l1;  uint l2;  uint l3;
    uint l4;  uint l5;  uint l6;  uint l7;
    uint l8;  uint l9;  uint l10; uint l11;
    uint l12; uint l13; uint l14; uint l15;
}

struct Result {
    uint r0;  uint r1;  uint r2;  uint r3;
    uint r4;  uint r5;  uint r6;  uint r7;
    uint r8;  uint r9;  uint r10; uint r11;
    uint r12; uint r13; uint r14; uint r15;
}

contract CircumventStackTooDeep {
  function circumvent(Parameters calldata parameters) external pure
  returns (Result memory) {
    LocalVariables memory local;
    local.l0  = parameters.p0  %  2;
    local.l1  = parameters.p1  %  2;
    local.l2  = parameters.p2  %  3;
    local.l3  = parameters.p3  %  5;
    local.l4  = parameters.p4  %  7;
    local.l5  = parameters.p5  % 11;
    local.l6  = parameters.p6  % 13;
    local.l7  = parameters.p7  % 17;
    local.l8  = parameters.p8  % 19;
    local.l9  = parameters.p9  % 23;
    local.l10 = parameters.p10 % 29;
    local.l11 = parameters.p11 % 31;
    local.l12 = parameters.p12 % 37;
    local.l13 = parameters.p13 % 41;
    local.l14 = parameters.p14 % 43;
    local.l15 = parameters.p15 % 47;


    uint sum;
    sum =       local.l0  + local.l1  + local.l2  + local.l3;
    sum = sum + local.l4  + local.l5  + local.l6  + local.l7;
    sum = sum + local.l8  + local.l9  + local.l10 + local.l11;
    sum = sum + local.l12 + local.l13 + local.l14 + local.l15;

    Parameters calldata p = parameters;

    Result memory result = Result(
        sum - p.p0,  sum - p.p1,  sum - p.p2,  sum - p.p3,
        sum - p.p4,  sum - p.p5,  sum - p.p6,  sum - p.p7,
        sum - p.p8,  sum - p.p9,  sum - p.p10, sum - p.p11,
        sum - p.p12, sum - p.p13, sum - p.p14, sum - p.p14
    );

    return result;
  }
}
