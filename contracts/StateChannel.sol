// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./TokenMock.sol";
import "./SigVerifier.sol";

contract StateChannel is SigVerifier {
    address public user1;
    address public user2;
    TokenMock public Token;
    mapping(address => bool) confirmed;
    uint256 public confirmations;

    constructor(
        address _user1,
        address _user2,
        address _token
    ) public {
        user1 = _user1;
        user2 = _user2;
        Token = TokenMock(_token);
    }

    function execute(
        bytes memory signature,
        address _user1,
        address _user2,
        uint256 _balance1,
        uint256 _balance2
    ) public {
        address user = verifySignature(_balance1, _balance2, signature);
        require(
            confirmed[msg.sender] == false,
            "StateChannel: User already confirmed"
        );
        require(confirmations <= 1, "StateChannel: Confirmations exceeded");
        if (user == user1 || user == user2) {
            confirmed[msg.sender] = true;
            confirmations = confirmations + 1;
        }

        if (confirmations == 2) {
            Token.updateBalances(_user1, _balance1, _user2, _balance2);
        }
    }
}
