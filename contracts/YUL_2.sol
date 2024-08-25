//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.8.20;

contract YUL_2 {
    // 使用Yul实现简单的for循环
    function yul_for_loop(uint256 n) external pure returns (uint256) {
        uint256 sum;
        assembly {
            // 初始化循环计数器
            let i := 0
            // 循环开始
            for {

            } lt(i, n) {
                i := add(i, 1)
            } {
                // 累加sum
                sum := add(sum, i)
            }
            // 循环结束后，sum中包含0到n-1的和
        }
        return sum;
    }

    //view支持最多end-start<329，pure?
    function yul_for(uint256 start, uint256 end)
        external
        view
        returns (uint256)
    {
        require(end > start, "Index number error");
        uint256 total;
        assembly {
            // syntax for for loop
            for {
                let i := start
            } lt(i, add(end, 1)) {
                i := add(i, 1)
            } {
                // if i == 0 skip this iteration
                if iszero(i) {
                    continue
                }
                total := add(total, i)
            }
        }
        return total;
    }

    function yul_if(uint256 a, uint256 b) external view returns (bool) {
        bool state;
        assembly {
            if eq(a, b) {
                state := true
            }
        }
        return state;
    }

    // 使用Yul实现while循环
    function yul_while_loop(uint256 n) external pure returns (uint256) {
        uint256 product = 1;
        assembly {
            let i := 1
            for {

            } lt(i, add(n, 1)) {

            } {
                product := mul(product, i)
                i := add(i, 1)
            }
        }
        return product;
    }

    // 使用Yul实现do-while循环
    function yul_do_while_loop(uint256 n) external pure returns (uint256) {
        uint256 result;
        assembly {
            let i := n
            for {

            } 1 {

            } {
                result := add(result, i)
                i := sub(i, 1)
                if iszero(i) {
                    break
                }
            }
        }
        return result;
    }
}
