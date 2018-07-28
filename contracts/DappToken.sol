pragma solidity ^0.4.2;

contract DappToken {
    string public name = "DApp Token";
    string public symbol = "DAPP";
    string public standard = "DApp Token v1.0";
    uint256 public totalSupply;    
    mapping(address => uint256) public balanceOf;   

    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 _value
    );

    constructor(uint256 _initialSupply) public {
        balanceOf[msg.sender] = _initialSupply;
        totalSupply = _initialSupply;    
    }    

    function transfer(address _to, uint256 _value) public returns (bool success) {
        // require sender to have sufficient balance
        require(balanceOf[msg.sender] >= _value);

        // modify balance vals
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        
        // fire event
        Transfer(msg.sender, _to, _value);

        return true;
    }
}
