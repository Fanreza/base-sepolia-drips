// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract  BaseSepoliaFaucetContract {
    mapping(address => uint256) public lastRequestTime;
    mapping(address => uint256) public deposits; // Track user deposits
    uint256 public constant requestAmount = 0.001 ether;
    uint256 public constant cooldownTime = 1 hours;

    event FaucetRequested(address indexed requester, uint256 amount);
    event DepositReceived(address indexed depositor, uint256 amount);

    // Function to request faucet (0.001 ETH per request)
    function sendFaucet(address payable _requester) public {
        require(address(this).balance >= requestAmount, "Insufficient faucet balance");
        require(lastRequestTime[_requester] + cooldownTime <= block.timestamp, "Wait before requesting again");

        lastRequestTime[_requester] = block.timestamp;
        (bool success, ) = _requester.call{value: requestAmount}("");
        require(success, "Faucet transfer failed");

        emit FaucetRequested(_requester, requestAmount);
    }

    // Function to deposit ETH and track senders
    function deposit() external payable {
        require(msg.value > 0, "Must send ETH");

        deposits[msg.sender] += msg.value; // Track how much each address deposits

        emit DepositReceived(msg.sender, msg.value);
    }

    // Allow contract to receive ETH (e.g., from MetaMask direct send)
    receive() external payable {
        deposits[msg.sender] += msg.value; // Track direct deposits too

        emit DepositReceived(msg.sender, msg.value);
    }

    // Function to check contract balance
    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
}