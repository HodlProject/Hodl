pragma solidity >=0.4.22 <0.8.0;

import "./DaiToken.sol";

contract Hodl {
  address public owner;
  DaiToken public daiToken;
  
  mapping(address => uint) public hodlerBalances;

  constructor(DaiToken _daiToken) public {
    owner = msg.sender;
    daiToken = _daiToken;
  }

  function deposit(uint _amount) public payable {
    // daiToken.transferFrom(msg.sender, address(this), _amount);
    hodlerBalances[msg.sender] += _amount;
  }

  function withdraw(uint _amount) public payable {
    uint balance = hodlerBalances[msg.sender];

    require(_amount <= balance, "Amount withdrawed must be less than or equal to your current balance.");

    // daiToken.transfer(msg.sender, _amount);
    hodlerBalances[msg.sender] -= _amount;
  }

  function getBalance() view public returns(uint balance) {
    return hodlerBalances[msg.sender];
  }
}
