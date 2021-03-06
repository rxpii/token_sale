pragma solidity ^0.4.2;

import "./DappToken.sol";

contract DappTokenSale {
    address admin;
    DappToken public tokenContract;
    uint256 public tokenPrice;
    uint256 public tokensSold;

    event Sell(
        address _buyer, 
        uint256 _amount
    );

    constructor(DappToken _tokenContract, uint256 _tokenPrice) public {
        // assign an admin
        admin = msg.sender;

        // token contract
        tokenContract = _tokenContract;

        // token price
        tokenPrice = _tokenPrice;
    }
    
    // declare payable so buyer can pay with ether
    function buyTokens(uint256 _numberOfTokens) public payable {
        // require that value is equal to tokens
        require(msg.value == multiply(_numberOfTokens, tokenPrice)); 

        // require that the contract has enough tokens
        require(tokenContract.balanceOf(this) >= _numberOfTokens);

        // require that a transfer is successful
        require(tokenContract.transfer(msg.sender, _numberOfTokens));

        // keep track of tokensSold
        tokensSold += _numberOfTokens;
        
        // trigger sell event  
        Sell(msg.sender, _numberOfTokens);
    }
    
    function endSale() public {
        // require admin
        require(msg.sender == admin);
        // transfer remaining tokens to admin
        require(tokenContract.transfer(admin, tokenContract.balanceOf(this)));
        // destroy contract
        admin.transfer(address(this).balance);
    }
    
    // safe multiply
    function multiply(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x);
    }
}
