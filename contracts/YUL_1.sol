//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.8.20;

contract YUL_1 {
    //+
    function yul_add(uint256 a) external returns (uint256) {
        uint256 b = 1;
        assembly {
            let c := 3
            b := add(a, c)
            sstore(0, b)
        }
        return b;
    }

    //-,overflow=>0
    function yul_sub(uint256 a, uint256 b) external returns (uint256) {
        uint256 d;
        assembly {
            let c := 5
            d := sub(add(a, c), b)
            sstore(0, d)
        }
        return d;
    }

    //*
    function yul_mul(uint256 a, uint256 b) external returns (uint256) {
        uint256 c;
        assembly {
            c := mul(a, b)
            sstore(0, c)
        }
        return c;
    }

    // /
    function yul_div(uint256 a, uint256 b) external returns (uint256) {
        uint256 c;
        assembly {
            c := div(a, b)
            sstore(0, c)
        }
        return c;
    }

    // 幂运算
    function yul_exp(uint256 base, uint256 exponent)
        external
        pure
        returns (uint256)
    {
        uint256 result;
        assembly {
            // 使用exp操作码进行幂运算
            result := exp(base, exponent)
        }
        return result;
    }

    // 取模运算
    function yul_mod(uint256 a, uint256 b) external pure returns (uint256) {
        uint256 result;
        assembly {
            // 使用mod操作码进行取模运算
            result := mod(a, b)
        }
        return result;
    }

    // 位与运算
    function yul_and(uint256 a, uint256 b) external pure returns (uint256) {
        uint256 result;
        assembly {
            // 使用and操作码进行位与运算
            result := and(a, b)
        }
        return result;
    }

    // 位或运算
    function yul_or(uint256 a, uint256 b) external pure returns (uint256) {
        uint256 result;
        assembly {
            // 使用or操作码进行位或运算
            result := or(a, b)
        }
        return result;
    }

    // 位异或运算
    function yul_xor(uint256 a, uint256 b) external pure returns (uint256) {
        uint256 result;
        assembly {
            // 使用xor操作码进行位异或运算
            result := xor(a, b)
        }
        return result;
    }

    // 左移位运算
    function yul_shl(uint256 a, uint256 bits) external pure returns (uint256) {
        uint256 result;
        assembly {
            // 使用shl操作码进行左移位运算
            result := shl(bits, a)
        }
        return result;
    }

    // 右移位运算
    function yul_shr(uint256 a, uint256 bits) external pure returns (uint256) {
        uint256 result;
        assembly {
            // 使用shr操作码进行右移位运算
            result := shr(bits, a)
        }
        return result;
    }
}
