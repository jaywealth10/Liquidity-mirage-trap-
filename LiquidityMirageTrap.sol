// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./ITrap.sol";

interface ILP {
    function getReserves() external view returns (uint112, uint112, uint32);
}

contract LiquidityMirageTrap is ITrap {
    address public constant TARGET_POOL = 0xd24970fa782e17ed9b24a04e7878eed800b1669d;
    uint256 public constant MIN_LIQUIDITY = 1_000 * 1e18;
    uint256 public constant PERSISTENCE_BLOCKS = 3;

    function collect() external view override returns (bytes memory) {
        uint256 r0 = 0;
        uint256 r1 = 0;
        bool valid = true;
        uint32 ts = 0;

        try ILP(TARGET_POOL).getReserves() returns (uint112 _r0, uint112 _r1, uint32 _ts) {
            r0 = uint256(_r0);
            r1 = uint256(_r1);
            ts = _ts;
        } catch {
            valid = false;
        }

        return abi.encode(r0, r1, block.number, valid);
    }

    function shouldRespond(bytes[] calldata data) external pure override returns (bool, bytes memory) {
        if (data.length == 0) return (true, bytes("no_data"));

        uint256 consecutive = 0;
        bool anyValidLiquid = false;

        for (uint i = 0; i < data.length; i++) {
            (uint256 r0, uint256 r1, , bool valid) = abi.decode(data[i], (uint256, uint256, uint256, bool));
            if (!valid) break;
            uint256 maxReserve = r0 >= r1 ? r0 : r1;
            if (maxReserve >= MIN_LIQUIDITY) {
                anyValidLiquid = true;
                consecutive += 1;
            } else {
                break;
            }
        }

        if (!anyValidLiquid) return (true, bytes("no_liquidity"));
        if (consecutive < PERSISTENCE_BLOCKS) return (true, bytes("mirage"));

        return (false, bytes(""));
    }
}
