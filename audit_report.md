# Smart contract audit report

## Pragma version^0.4.23 (OldContract.sol#1) allows old versions
solc-0.4.23 is not recommended for deployment

Check: `solc-version`
Severity: `Informational`
Confidence: `High`

The smart contract is rewritten in solidity version 0.8.18, which is the latest most stable and recommended version of solidity.

## Error: Functions are not allowed to have the same name as the contract. If you intend this to be a constructor, use "constructor(...) { ... }" to define it.

```js
   function StorageVictim() public {
   
       owner = msg.sender;
   }
```

This function is rewritten using constructor

```js
    constructor() {
        owner = msg.sender;
    }
```

## Error: Data location must be "storage", "memory" or "calldata" for variable, but none was given.

```js
Storage str;
...
Storage str = storages[msg.sender];
```

The data location of the structs are updated to memory in their respective functions.

```js
Storage memory str;
...
Storage memory str = storages[msg.sender];
```

## StorageVictim.store(uint256).str (NewContract.sol#24) is a local variable never initialized
### Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#uninitialized-local-variables

Check: `uninitialized-local`
Severity: `Medium`
Confidence: `Medium`

```js
Storage memory str;
       
    //    str.user = msg.sender;
       
    //    str.amount = _amount;
```

The variable is initialized to avoid having zero values when trying to access the contents of the struct.

```js
Storage memory str = Storage({user: msg.sender, amount: _amount});
```

## StorageVictim.OWNER (NewContract.sol#6) should be immutable 
### Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#state-variables-that-could-be-declared-immutable

Check: `immutable-states`
Severity: `Optimization`
Confidence: `High`

```js
   address owner;
```

The owner variable is one that is set at the instance the smart contract is created, and it is expected to stay way as long as the smart contract exists. The immutable flag will ensure it cannot be changed.

```js
   address immutable owner;
```

## Parameter StorageVictim.store(uint256)._amount (NewContract.sol#20) is not in mixedCase
### Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#conformance-to-solidity-naming-conventions

Check: `naming-convention`
Severity: `Informational`
Confidence: `High`

```js
   function store(uint _amount) public {
       
       Storage memory str = Storage({user: msg.sender, amount: _amount});

       storages[msg.sender] = str;

   }
```

Following solidity's naming convention, the variable `_amount` is renamed to `amount_`.

```js
   function store(uint amount_) public {
       Storage memory str = Storage({user: msg.sender, amount: amount_});

       storages[msg.sender] = str;
   }
```
