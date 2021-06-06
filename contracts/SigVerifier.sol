// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SigVerifier {

  function verifySignature(uint256 balance1, uint256 balance2, bytes memory signature) public returns (address) {
      // Recreate the message signed on the client
      bytes32 message = prefixed(keccak256(abi.encodePacked(balance1, balance2)));
      
      uint8 v;
      bytes32 r;
      bytes32 s;
      (v, r, s) = splitSignature(signature);
      address signerAddress = ecrecover(message, v, r, s);
      return signerAddress;
  }

  function splitSignature(bytes memory _signature) internal pure returns (uint8, bytes32, bytes32) {
    require(_signature.length == 65, "SigVerifier: Invalid signature length");

    bytes32 r;
    bytes32 s;
    uint8 v;

    assembly {
      r := mload(add(_signature, 32))
      s := mload(add(_signature, 64))
      v := byte(0, mload(add(_signature, 96)))
    }

    return (v, r, s);
  }

  function prefixed(bytes32 hash) internal pure returns (bytes32) {
      return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
  }
}