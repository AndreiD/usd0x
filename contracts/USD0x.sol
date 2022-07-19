// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20FlashMint.sol";
import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";

//https://www.usd0x.com
//ERC20 Permit: https://eips.ethereum.org/EIPS/eip-2612
//ERC20 Flash Mint: https://eips.ethereum.org/EIPS/eip-3156
contract USD0x is AccessControlEnumerable, ERC20Permit, ERC20Burnable, ERC20FlashMint {
	bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

	constructor() ERC20("USD0x", "USD0x") ERC20Permit("USD0x") {
		_setupRole(DEFAULT_ADMIN_ROLE, _msgSender()); //TODO: replace with multisig
		_setupRole(MINTER_ROLE, _msgSender()); //TODO: replace with multisig

		_mint(_msgSender(), 1000 * 10**decimals()); //TODO: replace with whatever amount you want initially
	}

	function mint(address to, uint256 amount) public virtual {
		require(
			hasRole(MINTER_ROLE, _msgSender()),
			"ERC20PresetMinterPauser: must have minter role to mint"
		);
		_mint(to, amount);
	}

	function version1() internal {}
}
