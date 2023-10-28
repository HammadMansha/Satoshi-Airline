// // Generated code, do not modify. Run `build_runner build` to re-generate!
// // @dart=2.12
// // ignore_for_file: no_leading_underscores_for_library_prefixes
// import 'package:dart_web3/dart_web3.dart' as _i1;
// import 'dart:typed_data' as _i2;

// final _contractAbi = _i1.ContractAbi.fromJson(
//   '[{"inputs":[],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"owner","type":"address"},{"indexed":true,"internalType":"address","name":"approved","type":"address"},{"indexed":true,"internalType":"uint256","name":"tokenId","type":"uint256"}],"name":"Approval","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"owner","type":"address"},{"indexed":true,"internalType":"address","name":"operator","type":"address"},{"indexed":false,"internalType":"bool","name":"approved","type":"bool"}],"name":"ApprovalForAll","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"previousOwner","type":"address"},{"indexed":true,"internalType":"address","name":"newOwner","type":"address"}],"name":"OwnershipTransferred","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"account","type":"address"}],"name":"Paused","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"from","type":"address"},{"indexed":true,"internalType":"address","name":"to","type":"address"},{"indexed":true,"internalType":"uint256","name":"tokenId","type":"uint256"}],"name":"Transfer","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"account","type":"address"}],"name":"Unpaused","type":"event"},{"inputs":[],"name":"MAX_SUPPLY","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"MINT_PRICE","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"Mint","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[{"internalType":"address","name":"to","type":"address"},{"internalType":"uint256","name":"tokenId","type":"uint256"}],"name":"approve","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"owner","type":"address"}],"name":"balanceOf","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"collection","outputs":[{"internalType":"uint256","name":"collectionSupply","type":"uint256"},{"internalType":"uint256","name":"availableTokens","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"tokenId","type":"uint256"}],"name":"getApproved","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"owner","type":"address"},{"internalType":"address","name":"operator","type":"address"}],"name":"isApprovedForAll","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"lock","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"lockBaseURI","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"minting_Limit","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"name","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"nextOwnerToExplicitlySet","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"owner","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"tokenId","type":"uint256"}],"name":"ownerOf","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"pause","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"paused","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"prefixURI","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"renounceOwnership","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"from","type":"address"},{"internalType":"address","name":"to","type":"address"},{"internalType":"uint256","name":"tokenId","type":"uint256"}],"name":"safeTransferFrom","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"from","type":"address"},{"internalType":"address","name":"to","type":"address"},{"internalType":"uint256","name":"tokenId","type":"uint256"},{"internalType":"bytes","name":"_data","type":"bytes"}],"name":"safeTransferFrom","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"operator","type":"address"},{"internalType":"bool","name":"approved","type":"bool"}],"name":"setApprovalForAll","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"string","name":"_uri","type":"string"}],"name":"setPrefixURI","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"string","name":"_uri","type":"string"},{"internalType":"uint256","name":"_tokenId","type":"uint256"}],"name":"setTokenURI","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"bytes4","name":"interfaceId","type":"bytes4"}],"name":"supportsInterface","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"symbol","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"index","type":"uint256"}],"name":"tokenByIndex","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"owner","type":"address"},{"internalType":"uint256","name":"index","type":"uint256"}],"name":"tokenOfOwnerByIndex","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"tokenId","type":"uint256"}],"name":"tokenURI","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"tokenURIs","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"totalMinted","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"totalSupply","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"from","type":"address"},{"internalType":"address","name":"to","type":"address"},{"internalType":"uint256","name":"tokenId","type":"uint256"}],"name":"transferFrom","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"newOwner","type":"address"}],"name":"transferOwnership","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"unPause","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"_price","type":"uint256"}],"name":"updateMintPrice","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_owner","type":"address"}],"name":"walletOfOwner","outputs":[{"internalType":"uint256[]","name":"","type":"uint256[]"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"withdrawBNB","outputs":[],"stateMutability":"nonpayable","type":"function"},{"stateMutability":"payable","type":"receive"}]',
//   'Contract',
// );

// class Contract extends _i1.GeneratedContract {
//   Contract({
//     required _i1.EthereumAddress address,
//     required _i1.Web3Client client,
//     int? chainId,
//   }) : super(
//           _i1.DeployedContract(
//             _contractAbi,
//             address,
//           ),
//           client,
//           chainId,
//         );

//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<BigInt> MAX_SUPPLY({_i1.BlockNum? atBlock}) async {
//     final function = self.abi.functions[1];
//     assert(checkSignature(function, '32cb6b0c'));
//     final params = [];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as BigInt);
//   }

//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<BigInt> MINT_PRICE({_i1.BlockNum? atBlock}) async {
//     final function = self.abi.functions[2];
//     assert(checkSignature(function, 'c002d23d'));
//     final params = [];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as BigInt);
//   }

//   /// The optional [transaction] parameter can be used to override parameters
//   /// like the gas price, nonce and max gas. The `data` and `to` fields will be
//   /// set by the contract.
//   Future<String> Mint({
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[3];
//     assert(checkSignature(function, '34c73884'));
//     final params = [];
//     return write(
//       credentials,
//       transaction,
//       function,
//       params,
//     );
//   }

//   /// The optional [transaction] parameter can be used to override parameters
//   /// like the gas price, nonce and max gas. The `data` and `to` fields will be
//   /// set by the contract.
//   Future<String> approve(
//     _i1.EthereumAddress to,
//     BigInt tokenId, {
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[4];
//     assert(checkSignature(function, '095ea7b3'));
//     final params = [
//       to,
//       tokenId,
//     ];
//     return write(
//       credentials,
//       transaction,
//       function,
//       params,
//     );
//   }

//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<BigInt> balanceOf(
//     _i1.EthereumAddress owner, {
//     _i1.BlockNum? atBlock,
//   }) async {
//     final function = self.abi.functions[5];
//     assert(checkSignature(function, '70a08231'));
//     final params = [owner];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as BigInt);
//   }

//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<Collection> collection(
//     BigInt $param3, {
//     _i1.BlockNum? atBlock,
//   }) async {
//     final function = self.abi.functions[6];
//     assert(checkSignature(function, 'f0772377'));
//     final params = [$param3];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return Collection(response);
//   }

//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<_i1.EthereumAddress> getApproved(
//     BigInt tokenId, {
//     _i1.BlockNum? atBlock,
//   }) async {
//     final function = self.abi.functions[7];
//     assert(checkSignature(function, '081812fc'));
//     final params = [tokenId];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as _i1.EthereumAddress);
//   }

//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<bool> isApprovedForAll(
//     _i1.EthereumAddress owner,
//     _i1.EthereumAddress operator, {
//     _i1.BlockNum? atBlock,
//   }) async {
//     final function = self.abi.functions[8];
//     assert(checkSignature(function, 'e985e9c5'));
//     final params = [
//       owner,
//       operator,
//     ];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as bool);
//   }

//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<bool> lock({_i1.BlockNum? atBlock}) async {
//     final function = self.abi.functions[9];
//     assert(checkSignature(function, 'f83d08ba'));
//     final params = [];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as bool);
//   }

//   /// The optional [transaction] parameter can be used to override parameters
//   /// like the gas price, nonce and max gas. The `data` and `to` fields will be
//   /// set by the contract.
//   Future<String> lockBaseURI({
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[10];
//     assert(checkSignature(function, '53df5c7c'));
//     final params = [];
//     return write(
//       credentials,
//       transaction,
//       function,
//       params,
//     );
//   }

//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<BigInt> minting_Limit({_i1.BlockNum? atBlock}) async {
//     final function = self.abi.functions[11];
//     assert(checkSignature(function, '446a1aba'));
//     final params = [];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as BigInt);
//   }

//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<String> name({_i1.BlockNum? atBlock}) async {
//     final function = self.abi.functions[12];
//     assert(checkSignature(function, '06fdde03'));
//     final params = [];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as String);
//   }

//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<BigInt> nextOwnerToExplicitlySet({_i1.BlockNum? atBlock}) async {
//     final function = self.abi.functions[13];
//     assert(checkSignature(function, 'd7224ba0'));
//     final params = [];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as BigInt);
//   }

//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<_i1.EthereumAddress> owner({_i1.BlockNum? atBlock}) async {
//     final function = self.abi.functions[14];
//     assert(checkSignature(function, '8da5cb5b'));
//     final params = [];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as _i1.EthereumAddress);
//   }

//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<_i1.EthereumAddress> ownerOf(
//     BigInt tokenId, {
//     _i1.BlockNum? atBlock,
//   }) async {
//     final function = self.abi.functions[15];
//     assert(checkSignature(function, '6352211e'));
//     final params = [tokenId];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as _i1.EthereumAddress);
//   }

//   /// The optional [transaction] parameter can be used to override parameters
//   /// like the gas price, nonce and max gas. The `data` and `to` fields will be
//   /// set by the contract.
//   Future<String> pause({
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[16];
//     assert(checkSignature(function, '8456cb59'));
//     final params = [];
//     return write(
//       credentials,
//       transaction,
//       function,
//       params,
//     );
//   }

//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<bool> paused({_i1.BlockNum? atBlock}) async {
//     final function = self.abi.functions[17];
//     assert(checkSignature(function, '5c975abb'));
//     final params = [];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as bool);
//   }

//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<String> prefixURI({_i1.BlockNum? atBlock}) async {
//     final function = self.abi.functions[18];
//     assert(checkSignature(function, 'a0c54078'));
//     final params = [];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as String);
//   }

//   /// The optional [transaction] parameter can be used to override parameters
//   /// like the gas price, nonce and max gas. The `data` and `to` fields will be
//   /// set by the contract.
//   Future<String> renounceOwnership({
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[19];
//     assert(checkSignature(function, '715018a6'));
//     final params = [];
//     return write(
//       credentials,
//       transaction,
//       function,
//       params,
//     );
//   }

//   /// The optional [transaction] parameter can be used to override parameters
//   /// like the gas price, nonce and max gas. The `data` and `to` fields will be
//   /// set by the contract.
//   Future<String> safeTransferFrom(
//     _i1.EthereumAddress from,
//     _i1.EthereumAddress to,
//     BigInt tokenId, {
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[20];
//     assert(checkSignature(function, '42842e0e'));
//     final params = [
//       from,
//       to,
//       tokenId,
//     ];
//     return write(
//       credentials,
//       transaction,
//       function,
//       params,
//     );
//   }

//   /// The optional [transaction] parameter can be used to override parameters
//   /// like the gas price, nonce and max gas. The `data` and `to` fields will be
//   /// set by the contract.
//   Future<String> safeTransferFrom$2(
//     _i1.EthereumAddress from,
//     _i1.EthereumAddress to,
//     BigInt tokenId,
//     _i2.Uint8List _data, {
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[21];
//     assert(checkSignature(function, 'b88d4fde'));
//     final params = [
//       from,
//       to,
//       tokenId,
//       _data,
//     ];
//     return write(
//       credentials,
//       transaction,
//       function,
//       params,
//     );
//   }

//   /// The optional [transaction] parameter can be used to override parameters
//   /// like the gas price, nonce and max gas. The `data` and `to` fields will be
//   /// set by the contract.
//   Future<String> setApprovalForAll(
//     _i1.EthereumAddress operator,
//     bool approved, {
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[22];
//     assert(checkSignature(function, 'a22cb465'));
//     final params = [
//       operator,
//       approved,
//     ];
//     return write(
//       credentials,
//       transaction,
//       function,
//       params,
//     );
//   }

//   /// The optional [transaction] parameter can be used to override parameters
//   /// like the gas price, nonce and max gas. The `data` and `to` fields will be
//   /// set by the contract.
//   Future<String> setPrefixURI(
//     String _uri, {
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[23];
//     assert(checkSignature(function, 'b2c94ee6'));
//     final params = [_uri];
//     return write(
//       credentials,
//       transaction,
//       function,
//       params,
//     );
//   }

//   /// The optional [transaction] parameter can be used to override parameters
//   /// like the gas price, nonce and max gas. The `data` and `to` fields will be
//   /// set by the contract.
//   Future<String> setTokenURI(
//     String _uri,
//     BigInt _tokenId, {
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[24];
//     assert(checkSignature(function, '09a3beef'));
//     final params = [
//       _uri,
//       _tokenId,
//     ];
//     return write(
//       credentials,
//       transaction,
//       function,
//       params,
//     );
//   }

//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<bool> supportsInterface(
//     _i2.Uint8List interfaceId, {
//     _i1.BlockNum? atBlock,
//   }) async {
//     final function = self.abi.functions[25];
//     assert(checkSignature(function, '01ffc9a7'));
//     final params = [interfaceId];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as bool);
//   }

//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<String> symbol({_i1.BlockNum? atBlock}) async {
//     final function = self.abi.functions[26];
//     assert(checkSignature(function, '95d89b41'));
//     final params = [];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as String);
//   }

//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<BigInt> tokenByIndex(
//     BigInt index, {
//     _i1.BlockNum? atBlock,
//   }) async {
//     final function = self.abi.functions[27];
//     assert(checkSignature(function, '4f6ccce7'));
//     final params = [index];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as BigInt);
//   }

//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<BigInt> tokenOfOwnerByIndex(
//     _i1.EthereumAddress owner,
//     BigInt index, {
//     _i1.BlockNum? atBlock,
//   }) async {
//     final function = self.abi.functions[28];
//     assert(checkSignature(function, '2f745c59'));
//     final params = [
//       owner,
//       index,
//     ];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as BigInt);
//   }

//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<String> tokenURI(
//     BigInt tokenId, {
//     _i1.BlockNum? atBlock,
//   }) async {
//     final function = self.abi.functions[29];
//     assert(checkSignature(function, 'c87b56dd'));
//     final params = [tokenId];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as String);
//   }

//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<String> tokenURIs(
//     BigInt $param25, {
//     _i1.BlockNum? atBlock,
//   }) async {
//     final function = self.abi.functions[30];
//     assert(checkSignature(function, '6c8b703f'));
//     final params = [$param25];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as String);
//   }

//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<BigInt> totalMinted(
//     _i1.EthereumAddress $param26, {
//     _i1.BlockNum? atBlock,
//   }) async {
//     final function = self.abi.functions[31];
//     assert(checkSignature(function, '003d4790'));
//     final params = [$param26];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as BigInt);
//   }

//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<BigInt> totalSupply({_i1.BlockNum? atBlock}) async {
//     final function = self.abi.functions[32];
//     assert(checkSignature(function, '18160ddd'));
//     final params = [];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as BigInt);
//   }

//   /// The optional [transaction] parameter can be used to override parameters
//   /// like the gas price, nonce and max gas. The `data` and `to` fields will be
//   /// set by the contract.
//   Future<String> transferFrom(
//     _i1.EthereumAddress from,
//     _i1.EthereumAddress to,
//     BigInt tokenId, {
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[33];
//     assert(checkSignature(function, '23b872dd'));
//     final params = [
//       from,
//       to,
//       tokenId,
//     ];
//     return write(
//       credentials,
//       transaction,
//       function,
//       params,
//     );
//   }

//   /// The optional [transaction] parameter can be used to override parameters
//   /// like the gas price, nonce and max gas. The `data` and `to` fields will be
//   /// set by the contract.
//   Future<String> transferOwnership(
//     _i1.EthereumAddress newOwner, {
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[34];
//     assert(checkSignature(function, 'f2fde38b'));
//     final params = [newOwner];
//     return write(
//       credentials,
//       transaction,
//       function,
//       params,
//     );
//   }

//   /// The optional [transaction] parameter can be used to override parameters
//   /// like the gas price, nonce and max gas. The `data` and `to` fields will be
//   /// set by the contract.
//   Future<String> unPause({
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[35];
//     assert(checkSignature(function, 'f7b188a5'));
//     final params = [];
//     return write(
//       credentials,
//       transaction,
//       function,
//       params,
//     );
//   }

//   /// The optional [transaction] parameter can be used to override parameters
//   /// like the gas price, nonce and max gas. The `data` and `to` fields will be
//   /// set by the contract.
//   Future<String> updateMintPrice(
//     BigInt _price, {
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[36];
//     assert(checkSignature(function, '00728e46'));
//     final params = [_price];
//     return write(
//       credentials,
//       transaction,
//       function,
//       params,
//     );
//   }

//   /// The optional [atBlock] parameter can be used to view historical data. When
//   /// set, the function will be evaluated in the specified block. By default, the
//   /// latest on-chain block will be used.
//   Future<List<BigInt>> walletOfOwner(
//     _i1.EthereumAddress _owner, {
//     _i1.BlockNum? atBlock,
//   }) async {
//     final function = self.abi.functions[37];
//     assert(checkSignature(function, '438b6300'));
//     final params = [_owner];
//     final response = await read(
//       function,
//       params,
//       atBlock,
//     );
//     return (response[0] as List<dynamic>).cast<BigInt>();
//   }

//   /// The optional [transaction] parameter can be used to override parameters
//   /// like the gas price, nonce and max gas. The `data` and `to` fields will be
//   /// set by the contract.
//   Future<String> withdrawBNB({
//     required _i1.Credentials credentials,
//     _i1.Transaction? transaction,
//   }) async {
//     final function = self.abi.functions[38];
//     assert(checkSignature(function, '1d111d13'));
//     final params = [];
//     return write(
//       credentials,
//       transaction,
//       function,
//       params,
//     );
//   }

//   /// Returns a live stream of all Approval events emitted by this contract.
//   Stream<Approval> approvalEvents({
//     _i1.BlockNum? fromBlock,
//     _i1.BlockNum? toBlock,
//   }) {
//     final event = self.event('Approval');
//     final filter = _i1.FilterOptions.events(
//       contract: self,
//       event: event,
//       fromBlock: fromBlock,
//       toBlock: toBlock,
//     );
//     return client.events(filter).map((_i1.FilterEvent result) {
//       final decoded = event.decodeResults(
//         result.topics!,
//         result.data!,
//       );
//       return Approval(decoded);
//     });
//   }

//   /// Returns a live stream of all ApprovalForAll events emitted by this contract.
//   Stream<ApprovalForAll> approvalForAllEvents({
//     _i1.BlockNum? fromBlock,
//     _i1.BlockNum? toBlock,
//   }) {
//     final event = self.event('ApprovalForAll');
//     final filter = _i1.FilterOptions.events(
//       contract: self,
//       event: event,
//       fromBlock: fromBlock,
//       toBlock: toBlock,
//     );
//     return client.events(filter).map((_i1.FilterEvent result) {
//       final decoded = event.decodeResults(
//         result.topics!,
//         result.data!,
//       );
//       return ApprovalForAll(decoded);
//     });
//   }

//   /// Returns a live stream of all OwnershipTransferred events emitted by this contract.
//   Stream<OwnershipTransferred> ownershipTransferredEvents({
//     _i1.BlockNum? fromBlock,
//     _i1.BlockNum? toBlock,
//   }) {
//     final event = self.event('OwnershipTransferred');
//     final filter = _i1.FilterOptions.events(
//       contract: self,
//       event: event,
//       fromBlock: fromBlock,
//       toBlock: toBlock,
//     );
//     return client.events(filter).map((_i1.FilterEvent result) {
//       final decoded = event.decodeResults(
//         result.topics!,
//         result.data!,
//       );
//       return OwnershipTransferred(decoded);
//     });
//   }

//   /// Returns a live stream of all Paused events emitted by this contract.
//   Stream<Paused> pausedEvents({
//     _i1.BlockNum? fromBlock,
//     _i1.BlockNum? toBlock,
//   }) {
//     final event = self.event('Paused');
//     final filter = _i1.FilterOptions.events(
//       contract: self,
//       event: event,
//       fromBlock: fromBlock,
//       toBlock: toBlock,
//     );
//     return client.events(filter).map((_i1.FilterEvent result) {
//       final decoded = event.decodeResults(
//         result.topics!,
//         result.data!,
//       );
//       return Paused(decoded);
//     });
//   }

//   /// Returns a live stream of all Transfer events emitted by this contract.
//   Stream<Transfer> transferEvents({
//     _i1.BlockNum? fromBlock,
//     _i1.BlockNum? toBlock,
//   }) {
//     final event = self.event('Transfer');
//     final filter = _i1.FilterOptions.events(
//       contract: self,
//       event: event,
//       fromBlock: fromBlock,
//       toBlock: toBlock,
//     );
//     return client.events(filter).map((_i1.FilterEvent result) {
//       final decoded = event.decodeResults(
//         result.topics!,
//         result.data!,
//       );
//       return Transfer(decoded);
//     });
//   }

//   /// Returns a live stream of all Unpaused events emitted by this contract.
//   Stream<Unpaused> unpausedEvents({
//     _i1.BlockNum? fromBlock,
//     _i1.BlockNum? toBlock,
//   }) {
//     final event = self.event('Unpaused');
//     final filter = _i1.FilterOptions.events(
//       contract: self,
//       event: event,
//       fromBlock: fromBlock,
//       toBlock: toBlock,
//     );
//     return client.events(filter).map((_i1.FilterEvent result) {
//       final decoded = event.decodeResults(
//         result.topics!,
//         result.data!,
//       );
//       return Unpaused(decoded);
//     });
//   }
// }

// class Collection {
//   Collection(List<dynamic> response)
//       : collectionSupply = (response[0] as BigInt),
//         availableTokens = (response[1] as BigInt);

//   final BigInt collectionSupply;

//   final BigInt availableTokens;
// }

// class Approval {
//   Approval(List<dynamic> response)
//       : owner = (response[0] as _i1.EthereumAddress),
//         approved = (response[1] as _i1.EthereumAddress),
//         tokenId = (response[2] as BigInt);

//   final _i1.EthereumAddress owner;

//   final _i1.EthereumAddress approved;

//   final BigInt tokenId;
// }

// class ApprovalForAll {
//   ApprovalForAll(List<dynamic> response)
//       : owner = (response[0] as _i1.EthereumAddress),
//         operator = (response[1] as _i1.EthereumAddress),
//         approved = (response[2] as bool);

//   final _i1.EthereumAddress owner;

//   final _i1.EthereumAddress operator;

//   final bool approved;
// }

// class OwnershipTransferred {
//   OwnershipTransferred(List<dynamic> response)
//       : previousOwner = (response[0] as _i1.EthereumAddress),
//         newOwner = (response[1] as _i1.EthereumAddress);

//   final _i1.EthereumAddress previousOwner;

//   final _i1.EthereumAddress newOwner;
// }

// class Paused {
//   Paused(List<dynamic> response)
//       : account = (response[0] as _i1.EthereumAddress);

//   final _i1.EthereumAddress account;
// }

// class Transfer {
//   Transfer(List<dynamic> response)
//       : from = (response[0] as _i1.EthereumAddress),
//         to = (response[1] as _i1.EthereumAddress),
//         tokenId = (response[2] as BigInt);

//   final _i1.EthereumAddress from;

//   final _i1.EthereumAddress to;

//   final BigInt tokenId;
// }

// class Unpaused {
//   Unpaused(List<dynamic> response)
//       : account = (response[0] as _i1.EthereumAddress);

//   final _i1.EthereumAddress account;
// }
