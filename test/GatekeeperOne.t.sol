pragma solidity ^0.8.10;

import "ds-test/test.sol";
import "forge-std/console2.sol";
import "forge-std/Vm.sol";
import "lib/openzeppelin-contracts/contracts/utils/math/SafeMath.sol";

contract ContractFinal {
    using SafeMath for uint256;

    modifier gateOne() {
      require(msg.sender != tx.origin);
      _;
    }

    modifier gateTwo() {
      console2.log('gas left: ', gasleft());
     // require(gasleft().mod(8191) == 0);
      _;
    }

    function getGas() gateOne gateTwo external{
      console2.log('gas Left3: ', gasleft());
    }
}

contract ContractProxy {
  ContractFinal contractFinal;
  constructor (address contractFinalAddress){
    contractFinal = ContractFinal(contractFinalAddress);
  }
  function run() external{
    contractFinal.getGas();
  }
}

contract GatekeeperOneScriptTest is DSTest {
    address eoaAddress = address(100);

    Vm vm = Vm(address(HEVM_ADDRESS));

    function setUp() public {
        vm.deal(eoaAddress, 1 ether);
    }

    function testGatekeeperOne1() public {
        vm.startPrank(eoaAddress);
        ContractFinal contractFinal = new ContractFinal();
        ContractProxy contractProxy = new ContractProxy(address(contractFinal));
        contractProxy.run{ gas: 10000000}();
        vm.stopPrank();

    }
}

//gas:100000 queda:97689
//gas:1000000 queda:983626
//gas:10000000 queda:9843001