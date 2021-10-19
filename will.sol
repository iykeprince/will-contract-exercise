pragma solidity ^0.5.7;

contract Will {
    address owner;
    uint    fortune;
    bool    deceased;
    
    constructor() payable public {
        owner = msg.sender; //msg sender represent address that is beign called
        fortune = msg.value; //msg value tells us how much is being sent.
        deceased = false;
    }
    
    //create modifier so the only who call call the contracts is the owner
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    //create modifier so that we only allocate fund's if friend's grands is deceased
    modifier mustBeDeceased {
        require(deceased == true);
        _;
    }
    
    //list the family wallets
    address payable[] familyWallets;
    
    //map through inheritance
    mapping(address => uint) inheritance;
    
    //set inheritance
    function setInheritance(address payable wallet, uint amount) public onlyOwner {
        // to add wallet to the family wallet
        familyWallets.push(wallet);
        inheritance[wallet] = amount;
    }
    
    //pay each family member based on their wallet address
    function payout() private mustBeDeceased { 
        for(uint i = 0; i < familyWallets.length; i++){
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
            //transfering funds from contract address to receiver's address
        }
    } 
    
    //oracle simulated switch
    // function hasDeceased() public onlyOwner {
    //     deceased = true;
    //     payout();
    // }
    
}
