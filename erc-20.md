## ERC-20 Contract

[标准文档](https://eips.ethereum.org/EIPS/eip-20)

### Notes

1. Solidity 0.4.17 or above
2. Callers MUST handle false from returns (bool success). Callers MUST NOT assume that false is never returned!

### Methods

[方法介绍](https://blog.csdn.net/shebao3333/article/details/80229692)

| Method       | Description                                                                             | Function                                                                                           |
| ------------ | --------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- |
| name         | (OPTIONAL)name of the token                                                             | function name() public view returns (string)                                                       |
| symbol       | (OPTIONAL)the symbol of the token                                                       | function symbol() public view returns (string)                                                     |
| decimals     | (OPTIONAL)the number of decimals the token uses                                         | function decimals() public view returns (uint8)                                                    |
| totalSupply  | total token supply                                                                      | function totalSupply() public view returns (uint256)                                               |
| balanceOf    | account balance of another account with address \_owner                                 | function balanceOf(address \_owner) public view returns (uint256 balance)                          |
| transfer     | Transfers \_value amount of tokens to address \_to                                      | function transfer(address \_to, uint256 \_value) public returns (bool success)                     |
| transferFrom | Transfers \_value amount of tokens from address \_from to address \_to                  | function transferFrom(address \_from, address \_to, uint256 \_value) public returns (bool success) |
| approve      | Allows \_spender to withdraw from your account multiple times, up to the \_value amount | function approve(address \_spender, uint256 \_value) public returns (bool success)                 |
| allowance    | amount which \_spender is still allowed to withdraw from \_owner                        | function allowance(address \_owner, address \_spender) public view returns (uint256 remaining)     |

### Events

- Transfer
- Approval
