// These are line comments
//
// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.26
// and less than 0.9.0
pragma solidity ^0.8.26;

contract LexicalElements {
    /* regular string literals */
    string regular1 = "Without escape sequence, ";
    string regular2 = 'only printable ASCII characters are allowed. ';
    string regular3 = "With escape sequence,\n";
    string regular4 = 'all Unicod\u0065 codepoints ';
    string regular5 = "can be express\x65d.";

    /* Unicode string literals */
    string unicode1 = unicode"Yo sé que ";
    string unicode2 = unicode'en español ';
    string unicode3 = unicode"y en otros idiomas\n";
    string unicode4 = unicode'no solo us\u0061n ';
    string unicode5 = unicode"car\x61cteres ASCII";

    /* hex string literals */
    string hex1 = hex"4120_68657820_737472696e6720_6c69746572616c20";
    string hex2 = hex"697320_75736566756c20_666f7220";
    string hex3 = hex"65787072657373696e6720_6461746120";
    string hex4 = hex"7468617420_6e6565647320_746f20_626520_73746f72656420";
    string hex5 = hex"696e20_6120_6279746520_61727261792e";

    /* hexadecimal numeric literals */
    uint number1 = 0x7;
    uint number2 = 0xABCD;
    uint number3 = 0x1_0_1_0_1;
    uint number4 = 0x0123_4567_89AB_CDEF;
    uint number5 = 0x0000_aB_cD_e_F;

    /* decimal numeric literals */
    uint number6 = 0;
    uint number7 = 123;
    uint number8 = 4_5_6;
    uint number9 = 1_234_567_890;

    function showYul() external pure {
        /* Yul */
        assembly {
            /* regular comment */
            // line comment

            let x := add(add(1, 2), 3) //no ; at end of statement

            //identifiers can be Solidity keywords, but no Yul keywords
            let uint := 1

            /* Yul in Solidity 0.8.26 has 92 keywords.

            13 regular keywords (mostly related to control flow):
            	break	case		continue	default	false
            	for		function	if			leave	let
            	switch	true		hex
            
            79 keywords for built-in functions:
                add				addmod			address			and
                balance			basefee			blobbasefee		blobhash
                blockhash		byte			call			callcode
                calldatacopy	calldataload	calldatasize	caller
                callvalue		chainid			coinbase		create
                create2			delegatecall	difficulty		div
                eq				exp				extcodecopy		extcodehash
                extcodesize		gas				gaslimit		gasprice
                gt				invalid			iszero			keccak256
                log0			log1			log2			log3
                log4			lt				mcopy			mload
                mod				msize			mstore			mstore8
                mul				mulmod			not				number
                or				origin			pop				prevrandao
                return			returndatacopy	returndatasize	revert
                sar				sdiv			selfbalance		selfdestruct
                sgt				shl				shr				signextend
                sload			slt				smod			sstore
                staticcall		stop			sub				timestamp
                tload			tstore			xor
            */
            // Yul has 7 separators: {	}	(	)	.	,	->
            // Yul has 1 operator: :=

            /* regular string literals */
            let regular_1 := "Without escape sequence, "
            // TypeError: String literal too long (45 > 32)
            //let regular_2 := 'only printable ASCII characters are allowed. '
            let regular_3 := "With escape sequence,\n"
            let regular_4 := 'all Unicod\u0065 codepoints '
            let regular_5 := "can be express\x65d."

            /* hex string literals */
            let hex_1 := hex"4120_68657820_737472696e6720_6c69746572616c20"
            let hex_2 := hex"697320_75736566756c20_666f7220"
            let hex_3 := hex"65787072657373696e6720_6461746120"
            let hex_4 := hex"7468617420_6e6565647320_746f20_626520_73746f72656420"
            let hex_5 := hex"696e20_6120_6279746520_61727261792e"

            /* hexadecimal numeric literals without _ */
            let number_1 := 0x7 let number_2 := 0xABCD let number_3 := 0x10101
            let number_4 := 0x0123456789ABCDEF let number_5 := 0x0000aBcDeF

            /* decimal numeric literals without _ */
            let number_6 := 0 let number_7 := 123
            let number_8 := 456 let number_9 := 1234567890
        }
    }
}

/* This is a regular comment that lists the keywords of Solidity

Solidity 0.8.26 has 204 keywords.

107 keywords that specify value types are:
	address		bool
	bytes1		bytes2	bytes3	bytes4
	bytes5		bytes6	bytes7	bytes8
	bytes9		bytes10	bytes11	bytes12
	bytes13		bytes14	bytes15	bytes16
	bytes17		bytes18	bytes19	bytes20
	bytes21 	bytes22	bytes23	bytes24
	bytes25 	bytes26	bytes27	bytes28
	bytes29		bytes30	bytes31	bytes32
	contract	enum	fixed	function
	int
	int8		int16	int24	int32
	int40		int48	int56	int64
	int72		int80	int88	int96
	int104		int112	int120	int128
	int136		int144	int152	int160
	int168		int176	int184	int192
	int200		int208	int216	int224
	int232		int240	int248	int256
	interface	type	ufixed	uint
	uint8		uint16	uint24	uint32
	uint40		uint48	uint56	uint64
	uint72		uint80	uint88	uint96
	uint104		uint112	uint120	uint128
	uint136		uint144	uint152	uint160
	uint168		uint176	uint184	uint192
	uint200		uint208	uint216	uint224
	uint232		uint240	uint248	uint256

4 keywords that specify reference types are:
	bytes		mapping	string	struct

5 keywords that are not real keywords (they can be used as identifier) are:
	error		from	global	revert	transient

9 keywords used to denote units are:
	wei			gwei	ether	seconds	minutes
	hours		days	weeks	years

48 remaining keywords are:
	abstract	anonymous	as			assembly	break
	calldata	catch		constant	constructor	continue
	delete		do			else		emit		event
	external	fallback	false		for			hex
	if			immutable	import		indexed		internal
	is			library		memory		modifier	new
	override	payable		pragma		private		public
	pure		receive 	return		returns		storage
	true		try			unchecked	unicode		using
	view		virtual		while

31 keywords that are not used, but reserved for future use are:
	after		alias		apply		auto		byte
	case		copyof		default		define		final
	implements	in			inline		let			macro
	match		mutable		null		of			partial
	promise		reference	relocatable	sealed		sizeof
	static		supports	switch		typedef		typeof
	var
*/
/* This is a regular comment that lists
the separators and operators of Solidity

13 separators (split code in different lexical tokens):
    (   )   [   ]   {   }   ;   .   ,   =>  ->  "   '

36 + 3 operators (calculate values) in order of precedence,
the order of precedence is different
from other programming languages!

    ++  --                      //postfix operator as in x++ and x--
    ++  --  -   delete  !   ~   //prefix operator as in ++x, --x and -x
    **
    *   /   %
    +   -                       //binary operator as in x - y
    <<  >>                      //>>> gives a compilation error
    &
    ^
    |
    <   >   <=  >=
    ==  !=
    &&
    ||
    ?:                          //ternary operator as in c ? x : y
    =   *=  /=  %=  +=  -=  <<= >>= &=  ^=  |=
                                //>>>= gives a compilation error
*/
