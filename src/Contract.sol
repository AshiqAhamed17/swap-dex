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
    ///  PUBLIC FUNCTIONS ///
    /////////////////////////

    /// @notice Get's the balance of the Liquidity pool token
    /// @dev
    /// @return The balance of the Liquidity pool token(ERC20Base(token))
    function getTokensInContract() public view returns (uint256) {
        return ERC20Base(token).balanceOf(address(this));
    }

    /// @notice Adds Liquidity to the pool
    /// @dev
    /// @param _amount The amount of tokens to add to the pool
    /// @return The amount of tokens added
    function addLiquidity(uint256 _amount) public payable returns(uint256) {
        uint256 _liquidity;
        uint256 balanceInETH = address(this).balance;
        uint256 totalReserve = getTokensInContract();
        ERC20Base _token = ERC20Base(token);

        // If this is the first time adding liquidity
        if(totalReserve == 0) {
            _token.transferFrom(msg.sender, address(this), _amount);
            _liquidity = balanceInETH;
            _mint(msg.sender, _amount);
        }
        else {
            uint256 reservedETH = balanceInETH - msg.value;
            require(_amount >= (msg.value * totalReserve) / reservedETH, "Amount is less than the minimum required");

            _token.transferFrom(msg.sender, address(this), _amount);
            _liquidity = (totalSupply() * msg.value) / reservedETH;
            _mint(msg.sender, _liquidity);
        }

        return _liquidity;
    }


    /// @notice Removes Liquidity from the pool
    /// @dev
    /// @param _amount The amount of tokens to removed
    /// @return  The amount of ETH and tokens removed
    function removeLiquidity(uint256 _amount) public payable returns(uint256, uint256) {
        require(_amount > 0, "Amount is less than the minimum required");
        uint256 _reserveETH = address(this).balance;
        uint256 _totalSupply = totalSupply();

        uint256 _ethAmount = (_reserveETH * _amount) / _totalSupply;
        uint256 _tokenAmount = (getTokensInContract() * _amount) / _totalSupply;

        _burn(msg.sender, _amount);
        payable(msg.sender).transfer(_ethAmount);
        ERC20Base(token).transfer(msg.sender, _tokenAmount);

        return (_ethAmount, _tokenAmount);
    }


    /// @notice gets back the amount of tokens in the pool
    /// @dev
    /// @param _amount The amount of tokens to add to the pool
    /// @return The amount of tokens added
    function getAmountOfTokens() public pure returns (uint256) {
        
    }



}
