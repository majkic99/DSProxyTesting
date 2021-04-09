pragma solidity ^0.7.0;
// SPDX-License-Identifier: UNLICENSED

import "./ERC20Token/ERC20Token.sol";
import "./DS/DSProxy.sol";

contract MoneyReturner {
    
    
    event EtherSent(address, uint);
    event TokenSent(address, address, uint);
    
    
    function returnEther() public{
        address owner = DSProxy(payable(address(this))).owner();
        uint amount = address(this).balance;
        payable(owner).transfer(amount);
        EtherSent(owner, amount);
    }
    
    function returnToken(address tokenAddress) public{
        address owner = DSProxy(payable(address(this))).owner();
        uint amount = ERC20Token(tokenAddress).balanceOf(address(this));
        ERC20Token(tokenAddress).transfer(owner, amount);
        TokenSent(tokenAddress, owner, amount);
    }
    
    function returnEther(bytes32 _amount) public {
        address owner = DSProxy(payable(address(this))).owner();
        uint amount = uint(_amount);
        require (address(this).balance >= amount);
        payable(owner).transfer(amount);
        emit EtherSent(owner, amount);
    }
    
    function returnToken(address tokenAddress, bytes32 _amount) public {
        address owner = DSProxy(payable(address(this))).owner();
        uint amount = uint(_amount);
        uint balance = ERC20Token(tokenAddress).balanceOf(address(this));
        require (balance >= amount);
        ERC20Token(tokenAddress).transfer(owner, amount);
        emit TokenSent(owner, tokenAddress, 0);
    }
    
}