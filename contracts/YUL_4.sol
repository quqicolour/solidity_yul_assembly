// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract YUL_4 {
    // Events
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // Storage layout
    uint256 private constant TOTAL_SUPPLY_SLOT = 0;
    uint256 private constant BALANCES_SLOT = 1;
    uint256 private constant ALLOWANCES_SLOT = 2;

    // Metadata
    string public constant name = "Optimized Token";
    string public constant symbol = "OPT";
    uint8 public constant decimals = 18;

    constructor(uint256 initialSupply) {
        _setTotalSupply(initialSupply);
        _setBalance(msg.sender, initialSupply);
        emit Transfer(address(0), msg.sender, initialSupply);
    }

    function totalSupply() public view returns (uint256) {
        return _getTotalSupply();
    }

    function balanceOf(address account) public view returns (uint256) {
        return _getBalance(account);
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        return _transfer(msg.sender, to, amount);
    }

    function allowance(address owner, address spender) public view returns (uint256) {
        return _getAllowance(owner, spender);
    }

    function approve(address spender, uint256 amount) public returns (bool) {
        return _approve(msg.sender, spender, amount);
    }

    function transferFrom(address from, address to, uint256 amount) public returns (bool transferState) {
        uint256 currentAllowance = _getAllowance(from, msg.sender);
        require(currentAllowance >= amount, "ERC20: insufficient allowance");
        _approve(from, msg.sender, currentAllowance - amount);
        transferState = _transfer(from, to, amount);
    }

    function _transfer(address from, address to, uint256 amount) private returns (bool) {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        uint256 fromBalance = _getBalance(from);
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");

        assembly {
            // Decrease sender's balance
            mstore(0, from)
            mstore(32, BALANCES_SLOT)
            let balanceSlot := keccak256(0, 64)
            sstore(balanceSlot, sub(fromBalance, amount))

            // Increase recipient's balance
            mstore(0, to)
            let toBalanceSlot := keccak256(0, 64)
            let toBalance := sload(toBalanceSlot)
            sstore(toBalanceSlot, add(toBalance, amount))
            mstore(0, 1)
        }
        emit Transfer(from, to, amount);
        return true;
    }

    function _approve(address owner, address spender, uint256 amount) private returns (bool) {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");
        assembly {
            mstore(0, owner)
            mstore(32, ALLOWANCES_SLOT)
            mstore(64, spender)
            let allowanceSlot := keccak256(0, 96)
            sstore(allowanceSlot, amount)
            mstore(0, 1)
        }
        emit Approval(owner, spender, amount);
        return true;
    }

    function _getTotalSupply() private view returns (uint256 _totalSupply) {
        assembly {
            _totalSupply := sload(TOTAL_SUPPLY_SLOT)
        }
    }

    function _setTotalSupply(uint256 newTotalSupply) private {
        assembly {
            sstore(TOTAL_SUPPLY_SLOT, newTotalSupply)
        }
    }

    function _getBalance(address account) private view returns (uint256 _balance) {
        assembly {
            mstore(0, account)
            mstore(32, BALANCES_SLOT)
            _balance := sload(keccak256(0, 64))
        }
    }

    function _setBalance(address account, uint256 newBalance) private {
        assembly {
            mstore(0, account)
            mstore(32, BALANCES_SLOT)
            sstore(keccak256(0, 64), newBalance)
        }
    }

    function _getAllowance(address owner, address spender) private view returns (uint256 _allowance) {
        assembly {
            mstore(0, owner)
            mstore(32, ALLOWANCES_SLOT)
            mstore(64, spender)
            _allowance := sload(keccak256(0, 96))
        }
    }
}