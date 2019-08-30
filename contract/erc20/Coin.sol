pragma solidity ^0.5.10;

contract Coin {

    // special global variables: msg, tx, block

    // the keyword public makes variables accessible from other contarcts
    address public minter;
    mapping (address => uint) public balances;

    // event allow clients to react to specific contract changes you declare
    event Sent(address from, address to, uint amount);

    // constructor code is only run when the contract is created.
    constructor() public {
        minter = msg.sender;
    }

    function balancesOf(address _account) external view returns (uint) {
        return balances[_account];
    }

    // sends an amount of newly created coins to an address
    // can only be called by contract creator
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter, "you are not the contract creator");
        require(amount < 1e60, "amount is too large");
        balances[receiver] += amount;
    }

    // sends an amount of existing coins from any caller to an address
    function send(address receiver, uint amount) public {
        require(amount <= balances[msg.sender], "Insufficient balance.");
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}