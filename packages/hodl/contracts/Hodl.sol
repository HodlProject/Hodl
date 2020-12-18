pragma solidity >=0.4.22 <0.8.0;

import "./DaiToken.sol";

contract Hodl {
    struct stake {
        uint256 balance;
        uint256 timestamp;
        uint256 withdrawTime;
    }

    address public owner;
    DaiToken public daiToken;

    mapping(address => stake) public stakes;

    constructor(DaiToken _daiToken) public {
        owner = msg.sender;
        daiToken = _daiToken;
    }

    function deposit(uint256 _amount, uint8 numSecondsUntilWithdraw)
        public
        payable
    {
        require(
            stakes[msg.sender].balance == 0,
            "Currently one stake at a time is supported."
        );

        // daiToken.transferFrom(msg.sender, address(this), _amount);
        stakes[msg.sender].balance = _amount;
        stakes[msg.sender].timestamp = block.timestamp;
        stakes[msg.sender].withdrawTime =
            stakes[msg.sender].withdrawTime +
            numSecondsUntilWithdraw;
    }

    function withdraw() public payable {
        uint256 balance = stakes[msg.sender].balance;
        require(balance > 0, "Balance must be greater than 0.");
        require(
            block.timestamp >= stakes[msg.sender].withdrawTime,
            "It is not time to withdraw"
        );

        // daiToken.transfer(msg.sender, stakes[msg.sender].balance, { from: owner });
        resetStake();
    }

    function withdrawWithPenalty() public payable {
        uint256 balance = stakes[msg.sender].balance;
        require(balance > 0, "Balance must be greater than 0.");
        require(
            block.timestamp > stakes[msg.sender].withdrawTime,
            "You can withdraw without penalty."
        );

        // TODO: Calculate penalty
        // daiToken.transfer(msg.sender, getPenalizedPayout(stakes[msg.sender].balance), { from: owner });
        resetStake();
    }

    function getBalance() public view returns (uint256 balance) {
        return stakes[msg.sender].balance;
    }

    function getWithdrawDate() public view returns (uint256 withdrawTime) {
        return stakes[msg.sender].withdrawTime;
    }

    function getHodlTime() public view returns (uint256 hodlTime) {
        return stakes[msg.sender].withdrawTime - stakes[msg.sender].timestamp;
    }

    function resetStake() private {
        stakes[msg.sender].balance = 0;
        stakes[msg.sender].timestamp = 0;
        stakes[msg.sender].withdrawTime = 0;
    }

    function getPenalizedPayout(uint256 balance)
        private
        pure
        returns (uint256 penalizedPayout)
    {
        return (85 * balance) / 100;
    }
}
