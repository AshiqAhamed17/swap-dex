// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@thirdweb-dev/contracts/base/ERC20Base.sol";

/// @title DEX
/// @author 0xArektQ
/// @notice Explain to an end user what this does
/// @dev Explain to a developer any extra details


contract DEX is ERC20Base {

    /////////////////////////////////
    //// STORAGE VARIABLES   ///////
    ////////////////////////////////
    address public token;

    constructor(address _token, address defaultAdmin, string memory _name, string memory _symbol)
        ERC20Base(defaultAdmin, _name, _symbol) {
        token = _token;

    }

    //////////////////////////
    //// FUNCTIONS    ///////
    /////////////////////////

    function 


}
