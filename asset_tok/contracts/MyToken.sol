// SPDX-License-Identifier: MIT

pragma solidity 0.8.2;

import "../lib/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {

    constructor() ERC20("lmao", "LOL")  {
        // Child construction code goes here
        _mint(msg.sender, 1000);
    }

}

