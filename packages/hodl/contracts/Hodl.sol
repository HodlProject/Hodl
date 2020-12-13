pragma solidity >=0.4.22 <0.8.0;

contract Hodl {
  address public owner;
  
  mapping(address => uint) public hodlers;

  constructor() {
    owner = msg.sender;
  }

  function deposit(uint _amount) public {
    require(_amount > 0, "Amount deposited must be greater than 0.");

    // TODO: Transfer to owner account?
    hodlers[msg.sender] += _amount;
  }

  function withdraw(uint _amount) public {
    uint balance = hodlers[msg.sender];

    require(_amount <= balance, "Amount withdrawed must be less than or equal to your current balance.");

    // TODO: Transfer back to sender
    hodlers[msg.sender] -= _amount;
  }
}
