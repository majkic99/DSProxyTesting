pragma solidity ^0.7.0;
// SPDX-License-Identifier: UNLICENSED

import "./DS/DSProxy.sol";
import "./MoneyReturner.sol";


contract ReturnDSProxyMoney{
    
    MoneyReturner public returner;
    address public owner;
    
    constructor(){
        returner = new MoneyReturner();
        owner = msg.sender;
    }
    
    modifier onlyOwner(){
        require(owner == msg.sender);
        _;
    }
    
    function returnEther(address payable DSProxyAddress) public onlyOwner{
        DSProxy dsProxy = DSProxy(DSProxyAddress);
        dsProxy.execute(address(returner), abi.encodeWithSignature("returnEther()"));
    }
    
    function returnToken(address payable DSProxyAddress, address tokenAddress) public onlyOwner {
        DSProxy dsProxy = DSProxy(DSProxyAddress);
        dsProxy.execute(address(returner), abi.encodeWithSignature("returnToken(address)", tokenAddress));
    }
    
    function returnEther(address payable DSProxyAddress, uint amount) public onlyOwner{
        DSProxy dsProxy = DSProxy(DSProxyAddress);
        dsProxy.execute(address(returner), abi.encodeWithSignature("returnEther(bytes32)", bytes32(amount)));
    }
    
    function returnToken(address payable DSProxyAddress, address tokenAddress, uint amount) public onlyOwner{
        DSProxy dsProxy = DSProxy(DSProxyAddress);
        dsProxy.execute(address(returner), abi.encodeWithSignature("returnToken(address,bytes32)", tokenAddress, bytes32(amount)));
    }
}