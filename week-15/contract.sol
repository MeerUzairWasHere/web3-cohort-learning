// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Solidity version (^0.8.0 specified above)

// Inheritance - Importing Ownable from OpenZeppelin
// import "@openzeppelin/contracts/access/Ownable.sol";

// External contract interface
interface IExternalContract {
    function externalFunction() external returns (uint);
}

// Main contract demonstrating all features
contract ComprehensiveContract is Ownable {
    // Variables with different data types
    uint public counter; // unsigned integer
    int private signedValue; // signed integer
    address public contractOwner;
    bool public isActive;
    string public contractName;
    
    // Struct definition
    struct User {
        string name;
        uint age;
        address wallet;
        bool isVerified;
    }
    
    // Arrays
    uint[] public numberArray;
    User[] public users;
    
    // Mappings
    mapping(address => uint) public balances;
    mapping(address => User) public addressToUser;
    
    // Enum
    enum Status { Pending, Active, Inactive, Banned }
    
    // Events
    event CounterIncreased(uint newValue, address increasedBy);
    event UserAdded(string name, address wallet);
    event ContractInteraction(address caller, uint amount);
    
    // Modifiers
    modifier onlyActive() {
        require(isActive, "Contract is not active");
        _;
    }
    
    modifier valueGreaterThan(uint minValue) {
        require(msg.value > minValue, "Value too low");
        _;
    }
    
    // Constructor
    constructor(string memory _name) {
        contractOwner = msg.sender;
        contractName = _name;
        isActive = true;
        counter = 0;
        signedValue = -1;
    }
    
    // Function with arguments, return type, and different visibility
    function incrementCounter(uint amount) external onlyActive returns (uint) {
        counter += amount;
        emit CounterIncreased(counter, msg.sender);
        return counter;
    }
    
    // Function with memory/storage demonstration
    function addUser(string memory name, uint age) public {
        User memory newUser = User({
            name: name,
            age: age,
            wallet: msg.sender,
            isVerified: false
        });
        
        users.push(newUser); // storage array
        addressToUser[msg.sender] = newUser; // storage mapping
        balances[msg.sender] = 100; // initial balance
        
        emit UserAdded(name, msg.sender);
    }
    
    // Function returning a tuple
    function getUserInfo(address userAddress) public view returns (string memory, uint, bool) {
        User storage user = addressToUser[userAddress]; // storage reference
        return (user.name, user.age, user.isVerified);
    }
    
    // Pure function (no state access)
    function calculateSum(uint a, uint b) public pure returns (uint) {
        return a + b;
    }
    
    // Function with if-else
    function verifyUser(address userAddress) public {
        if (addressToUser[userAddress].wallet != address(0)) {
            addressToUser[userAddress].isVerified = true;
        } else {
            revert("User does not exist");
        }
    }
    
    // Function with loop
    function sumAllBalances() public view returns (uint total) {
        for (uint i = 0; i < users.length; i++) {
            total += balances[users[i].wallet];
        }
        return total;
    }
    
    // Function with require
    function transfer(address to, uint amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        require(to != address(0), "Cannot transfer to zero address");
        
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }
    
    // Function interacting with external contract
    function callExternalContract(IExternalContract externalContract) public returns (uint) {
        uint result = externalContract.externalFunction();
        return result;
    }
    
    // Payable function with modifier
    function deposit() external payable valueGreaterThan(0.01 ether) {
        balances[msg.sender] += msg.value;
        emit ContractInteraction(msg.sender, msg.value);
    }
    
    // Function demonstrating Ownable (inherited)
    function changeContractName(string memory newName) public onlyOwner {
        contractName = newName;
    }
    
    // Function to toggle contract status
    function toggleContractStatus() public onlyOwner {
        isActive = !isActive;
    }
}