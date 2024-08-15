// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./SomethingToken.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Market is Ownable {
    IERC20 public _someToken;

    constructor(
        address somethingTokenAddress
        // address anythingTokenAddress
    ) Ownable(msg.sender) {
        _someToken = IERC20(somethingTokenAddress);
        // _someToken = IERC20(0x9a2E12340354d2532b4247da3704D2A5d73Bd189);
        // _someToken = SomethingToken(somethingTokenAddress);

        // type(uint256).max
        // _someToken.approve(address(this), type(uint256).max);
    }

    function getSomeBalance(address ad) public view returns (uint256) {
        return _someToken.balanceOf(ad);
    }
    
    function ApproveWEIRDSomeTokens() public {
        _someToken.approve(address(this), 100);
    }

    function getWEIRDSomeAllowance() view public returns (uint256) {
        return _someToken.allowance(address(this), address(this));
    }

    function ApproveSomeTokens() public {
        // _someToken.approve(address(this), 100);
        (bool success, ) = address(_someToken).delegatecall(
            abi.encodeWithSignature("approve(address,uint256)", address(this), 100)
            // abi.encodeWithSelector(IERC20.approve.selector, address(this), 100)
            // abi.encodeWithSelector(_someToken.approve.selector, address(this), 100)
        );

        require(success, "failed!");
    }

    function getSomeAllowance() public view returns (uint256) {
        return _someToken.allowance(msg.sender, address(this));
    }
}
