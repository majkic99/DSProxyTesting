pragma solidity ^0.7.0;
// SPDX-License-Identifier: UNLICENSED

import "./DS/DSAuth.sol";
import "./ERC20Interface.sol";

contract MoneyReturner is DSAuth{
    
    
    event EtherSent(address, uint);
    event TokenSent(address, address, uint);
    
    
    function returnEther() public{
        uint amount = address(this).balance;
        payable(owner).transfer(amount);
        EtherSent(owner, amount);
    }
    
    function returnToken(address tokenAddress) public{
        uint amount = ERC20Token(tokenAddress).balanceOf(address(this));
        ERC20Token(tokenAddress).transfer(owner, amount);
        TokenSent(tokenAddress, owner, amount);
    }
    
    function returnEther(uint amount) public {
        require (address(this).balance >= amount);
        msg.sender.transfer(amount);
        emit EtherSent(msg.sender, amount);
    }
    
    function returnToken(address tokenAddress, uint amount) public {
        uint balance = ERC20Token(tokenAddress).balanceOf(address(this));
        require (balance >= amount);
        ERC20Token(tokenAddress).transfer(msg.sender, amount);
        emit TokenSent(msg.sender, tokenAddress, amount);
    }
    
}