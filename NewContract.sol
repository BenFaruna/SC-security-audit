// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract StorageVictim {

   address immutable owner;
   
   struct Storage {
   
       address user;
       uint amount;
   }

   mapping(address => Storage) storages;

   constructor () {
       owner = msg.sender;
   }

   function store(uint amount_) public {

       Storage memory str = Storage({user: msg.sender, amount: amount_});

       storages[msg.sender] = str;

   }
   function getStore() public view returns (address, uint) {
       
       Storage memory str = storages[msg.sender];
       
       return (str.user, str.amount);
   }
   
   function getOwner() public view returns (address) {
       
       return owner;
   }
}
