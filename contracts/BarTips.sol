// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";

/* @title: "Bar tipping jar"
 * @author: "Jean-Paul Laclau"
 * @notice: "An awesome Solidity smart contract to fill the bar-tipping jar of a group of waiters & bartenders"
 * @dev: "pre-established users are registed in a shared wallet that can receive funds from anyone.
 *          When a registered users withdraws, all registered users receive an equal sum.
 *
 * At some point this will include a front end qr code generation of some sort, maybe. probably... that is to be printed
 * and deposited on the tables of the bar."
 */

contract BarTips is Ownable {
    bool BartenderInscriptionOpen = false;

    struct Bartender {
        address _addressBartender;
    }

    Bartender[] bartenders;

    function openInscriptions() public onlyOwner {
        require(BartenderInscriptionOpen = false);
        BartenderInscriptionOpen = true;
    }

    function closeInscriptions() public onlyOwner {
        require(BartenderInscriptionOpen = true);
        BartenderInscriptionOpen = false;
    }

    // Type Declarations
    // State variables
    // Events
    // Modifiers
    // Functions Order:
    //// constructor
    //// receive
    //// fallback
    //// external
    //// public
    //// internal
    //// private
    //// view / pure
}

/*  @param: Explain some param here.
 *  @notice: Write some short ending comentary here. Be nice.
 */
