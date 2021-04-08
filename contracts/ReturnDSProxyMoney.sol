pragma solidity ^0.7.0;
// SPDX-License-Identifier: UNLICENSED

import "./DS/DSProxy.sol";

contract ReturnDSProxyMoney{
    
    MoneyReturner returner;
    address owner;
    
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
    
    function returnEtherAmount(address payable DSProxyAddress, uint amount) public onlyOwner{
        DSProxy dsProxy = DSProxy(DSProxyAddress);
        dsProxy.execute(address(returner), abi.encodeWithSignature("returnEther(uint)", amount));
    }
    
    function returnTokenAmount(address payable DSProxyAddress, address tokenAddress, uint amount) public onlyOwner{
        DSProxy dsProxy = DSProxy(DSProxyAddress);
        dsProxy.execute(address(returner), abi.encodeWithSignature("returnToken(address, amount)", tokenAddress, amount));
    }
}