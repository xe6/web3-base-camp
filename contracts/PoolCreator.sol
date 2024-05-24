// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "@uniswap/v3-core/contracts/interfaces/IUniswapV3Factory.sol";

contract PoolCreator {
    IUniswapV3Factory public uniswapFactory;

    constructor(address _factoryAddress) {
        uniswapFactory = IUniswapV3Factory(_factoryAddress);
    }

    function createPool(
        address _tokenA,
        address _tokenB,
        uint24 _fee
    ) external returns (address poolAddress) {
        // Check if pool already exists
        poolAddress = uniswapFactory.getPool(_tokenA, _tokenB, _fee);
        if (poolAddress == address(0)) {
            // Pool does not exist, we should create it
            poolAddress = uniswapFactory.createPool(_tokenA, _tokenB, _fee);
        }

        return poolAddress;
    }
}
