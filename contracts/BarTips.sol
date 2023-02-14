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
    bool public BartenderInscriptionOpen;
    uint public WorkingBartendersCount = 0;
    uint public JarTipsTotalAmount;

    struct Bartender {
        address _bartenderAddress;
    }

    Bartender[] bartenders;
    mapping(address => bool) _isRegistered;

    function setInscriptions(bool _isOpen) public onlyOwner {
        BartenderInscriptionOpen = _isOpen;
    }

    function addBartenders() public {
        require(BartenderInscriptionOpen == true);
        require(!_isRegistered[msg.sender], "Bartender is already registered");
        WorkingBartendersCount++;
        Bartender memory newBartender = Bartender({
            _bartenderAddress: msg.sender
        });
        bartenders.push(newBartender);
        _isRegistered[msg.sender] = true;
    }

    function getkWorkingBartenders() public view returns (Bartender[] memory) {
        return bartenders;
    }

    function payTo(address to, uint256 amount) internal returns (bool) {
        (bool success, ) = payable(to).call{value: amount}("");
        require(success, "Payment failed");
        return true;
    }

    function emptyTheTipsJar() public payable {
        require(_isRegistered[msg.sender], "Bartender is not registered");
        uint _tipAmountPerBartender = address(this).balance / bartenders.length;
        uint counter = 0;
        for (uint i = 0; i < bartenders.length; i++) {
            payTo(bartenders[i]._bartenderAddress, _tipAmountPerBartender);
            counter++;
            JarTipsTotalAmount = 0;
        }
    }

    function sendTips() public payable {
        JarTipsTotalAmount += msg.value;
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
