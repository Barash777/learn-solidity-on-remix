// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Market is Ownable {
    IERC20 public _someToken;
    IERC20 public _anyToken;
    
    address mainOwner = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    uint8 tokenPrice = 1;

    event TokensPurchased(address indexed buyer, uint256 amount);
    event TokensWithdrawn(address indexed owner, uint256 amount);
    event TokenPriceUpdated(uint256 oldPrice, uint256 newPrice);

    constructor(
        // IERC20 somethingTokenAddress,
        // IERC20 anythingTokenAddress
    ) Ownable(msg.sender) {
        // _someToken = IERC20(somethingTokenAddress);
        // _anyToken = IERC20(anythingTokenAddress);
        _someToken = IERC20(0xb4a88c4086055b8f546911BaaED28b7CEE134EF9);
        _anyToken = IERC20(0xE645D1e7bDA5Ef4932cDAA11394fA984dd4F2fb9);
    }

    function buySomeTokens(uint256 _value) payable public {
        // bool success = _someToken.transferFrom(mainOwner, msg.sender, _value);
        // require(success, "Something went wrong");
        buyTokens(_someToken, _value);
    }

    function buyAnyTokens(uint256 _value) payable public {
        buyTokens(_anyToken, _value);
    }

    // function approveAllTokensForMarket() public onlyOwner {
    //     // _someToken.approve(address(this), type(uint256).max);
    //     (bool success, ) = address(_someToken).delegatecall(
    //         abi.encodeWithSignature("approve(address,uint256)", address(this), 100)
    //         // abi.encodeWithSelector(IERC20.approve.selector, address(this), 100)
    //         // abi.encodeWithSelector(_someToken.approve.selector, address(this), 100)
    //     );

    //     require(success, "failed!");
    // }

    function buyTokens(IERC20 token, uint256 tokenAmount) public payable {
        uint256 cost = tokenAmount * tokenPrice;
        require(msg.value >= cost, "Insufficient Ether sent");

        uint256 allowance = token.allowance(owner(), address(this));
        require(allowance >= tokenAmount, "Not enough tokens approved for transfer");

        token.transferFrom(owner(), msg.sender, tokenAmount);
        emit TokensPurchased(msg.sender, tokenAmount);

        // if (msg.value > cost) {
        //     payable(msg.sender).transfer(msg.value - cost); // Refund overpayment
        // }
    }
}
