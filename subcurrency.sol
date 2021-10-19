pragma solidity >=0.7.0 <0.9.0;

contract Coin {
    address public minter;
    mapping(address => uint) public balances;
    
    //Events allow clients to react to specific 
    //contract changes you declare
    event Sent(address from, address to, uint amount);
    
    //constructor only runs when we deploy the smart contract
    constructor(){
        minter = msg.sender;
    }
    
    //make new coins and send them to an address
    //only the owner can send these coins
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        balances[receiver] += amount;
    }
    
    error insufficientBalance(uint requested, uint available);

    //send any amount of coins to an existing address
    function send(address receiver, uint amount) public {
        if(amount > balances[msg.sender])
        revert insufficientBalance({
            requested: amount,
            available: balances[msg.sender]
        });
        
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        
        emit Sent(msg.sender, receiver, amount
        );
    }
    
}
