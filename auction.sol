pragma solidity ^0.5.6;

contract BiddingContract
{
    // Bids will have a user and an amount
    struct Bid {
        address payable user;
        uint bidAmount;
    }
    
    address payable  public owner;
    uint public startTime;
    uint public endauction;
    
    Bid[] AllBids;
     //event bidWinner(address a,uint amt);
   
    constructor() public {
        AllBids.push(Bid(address(0), 0));
        owner=msg.sender;
        
        }
    modifier onlyOwner(){
        require(owner==msg.sender,"only owner could see it");
        _;
    }
    
    /*function display()public returns(string memory) {
          
        if(block.timestamp<endauction) return string("time is not yet completed");
        else {
            uint lastIndex = AllBids.length - 1;
            emit bidWinner(AllBids[lastIndex].user, AllBids[lastIndex].bidAmount);
            return string("the winner is displayed");
        }
    }*/
       
 function () payable external {
     startTime=block.timestamp;
        endauction=40+startTime;
        uint lastIndex = AllBids.length - 1;
        require(owner != msg.sender,"IT IS OWNER");
         require(msg.value > AllBids[lastIndex].bidAmount,"BID MUST BE GREATER");
         require(startTime<endauction);
        //AllBids[lastIndex].user.send(AllBids[lastIndex].bidAmount);
        if(!AllBids[lastIndex].user.send(AllBids[lastIndex].bidAmount))
        {
            owner.transfer(msg.value );
            
        }
           AllBids.push(Bid(msg.sender,msg.value));
           if(block.timestamp>endauction)
           { owner.transfer(msg.value );
           }
    }
    function balance() public view onlyOwner returns (uint) {
        //require(manager == msg.sender,"Only the manager can call balance");
        return owner.balance;
    }
   
    
    function getTopBid() public view  returns (address, uint) {
       
        uint lastIndex = AllBids.length - 1;
       return (AllBids[lastIndex].user, AllBids[lastIndex].bidAmount);
        
        
    }

    
    function getNumberOfBids() public view returns (uint)  {
        return AllBids.length-1;
    }

    
    function getBid(uint index) public view returns (address, uint) {
        return (AllBids[index].user, AllBids[index].bidAmount);
    }
}
