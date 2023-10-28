// import 'dart:math';

// import 'package:dart_web3/dart_web3.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:http/http.dart';
// import 'package:satoshi/Services/wallet_connect_ethereum.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:walletconnect_dart/walletconnect_dart.dart';

// class WebThreeServices {
//   late http.Client httpClient;
//   final String? _rpcUrl = dotenv.env["RPC"];

//   // var clientWalletAddress;

//   final contractAddress =
//       dotenv.env["TOKEN_CONTRACT_ADDRESS"]; //TO read contract
//   var privateKeyMeta = dotenv.env['METAMASK_PRIVATE_KEY'];
//   // var args;
//   List value = [];
//   void _launchUrl() async {
//     if (!await launchUrl(Uri.parse('https://metamask.app.link/'))) {
//       throw 'Could not launch';
//     }
//   }

//   Future mint(connector, wallet) async {
//     // Load the contract ABI from a JSON file
//     String abi =
//         await rootBundle.loadString("assets/contract/contract.abi.json");

//     // Initialize an Ethereum client using an RPC URL
//     Web3Client? ethClient = Web3Client(_rpcUrl!, Client());

//     // Call the mintAmount() function (not defined in the code)
//     await mintAmount();

//     // Convert the value to EtherAmount in Wei
//     var etherAmount = EtherAmount.fromUnitAndValue(EtherUnit.wei, value[0]);

//     // Convert the EtherAmount to Ether (adjust decimal places)
//     var etherValue = etherAmount.getValueInUnit(EtherUnit.wei) / pow(10, 18);
//     var etherAmountValue =
//         EtherAmount.fromUnitAndValue(EtherUnit.ether, BigInt.from(etherValue));

//     // Create an EtherAmount instance for later use
//     EtherAmount then =
//         EtherAmount.fromUnitAndValue(EtherUnit.ether, BigInt.from(etherValue));
//     var a = EtherAmount.fromUnitAndValue(EtherUnit.wei, value[0]);

//     // Print the values for debugging
//     if (kDebugMode) {
//       print(etherValue);
//       print(etherAmountValue);
//       print(then);
//       print(a);
//       print(a.runtimeType);
//     }

//     // Create a DeployedContract instance using the loaded ABI and contract address
//     final contract = DeployedContract(
//         ContractAbi.fromJson(abi, contractAddress!),
//         EthereumAddress.fromHex(contractAddress!));

//     // Initialize an EthereumWalletConnectProvider using the connector
//     EthereumWalletConnectProvider provider =
//         EthereumWalletConnectProvider(connector);

//     // Create WalletConnectEthereumCredentials using the provider
//     final _credentials = WalletConnectEthereumCredentials(provider: provider);

//     // Specify the function name to call on the contract
//     String functionName = 'Mint';

//     // Get the contract function object based on the function name
//     final ethFunction = contract.function(functionName);

//     // Launch URL (not defined in the code)
//     _launchUrl();

//     // Send a transaction by calling the contract function
//     var approveTxBytes = await ethClient.sendTransaction(
//         _credentials,
//         Transaction.callContract(
//             maxGas: 6000000,
//             from: EthereumAddress.fromHex(wallet),
//             value: a,
//             contract: contract,
//             function: ethFunction,
//             parameters: []),
//         chainId: 97);

//     // Print the transaction bytes
//     if (kDebugMode) {
//       print(approveTxBytes);
//     }

//     return approveTxBytes;
//   }


//   Future transfer(connector, wallet, receiverWallet)async{
//     String abi = await rootBundle.loadString("assets/contract/contract.abi.json");
//     Web3Client? ethClient = Web3Client(_rpcUrl!, Client());
//     final contract = DeployedContract(ContractAbi.fromJson(abi, contractAddress!),
//         EthereumAddress.fromHex(contractAddress!));
//     EthereumWalletConnectProvider provider =
//     EthereumWalletConnectProvider(connector);
//     final _credentials = WalletConnectEthereumCredentials(provider: provider);
//     String functionName = 'transferFrom';
//     final ethFunction = contract.function(functionName);
//     _launchUrl();
//     try{
//       var approveTxBytes = await ethClient.signTransaction(_credentials, Transaction.callContract(from: EthereumAddress.fromHex(wallet), contract: contract, function: ethFunction, parameters: [

//         EthereumAddress.fromHex("0x188d971a03a937cbe4d6ead0034521d4b95e94ca"),
//         EthereumAddress.fromHex("0x9b7b657EfC9780CbCdCa826Ce72968188d523a1d"),
//         BigInt.from(4)

//       ]), chainId: 97);
//       print(approveTxBytes);
//       return approveTxBytes;
//     }catch(e){
//       print("mint: $e");
//     }
//   }

//   Future<void> mintAmount() async {
//     try {
//       // Load the contract ABI from the asset file
//       String abi = await rootBundle.loadString("assets/contract/contract.abi.json");

//       // Create a Web3Client
//       Web3Client? ethClient = Web3Client(_rpcUrl!, Client());

//       // Create a DeployedContract instance
//       final contract = DeployedContract(
//         ContractAbi.fromJson(abi, contractAddress!),
//         EthereumAddress.fromHex(contractAddress!),
//       );

//       // Specify the function name
//       String functionName = 'MINT_PRICE';

//       // Get the function
//       final ethFunction = contract.function(functionName);

//       // Call the function
//       value = await ethClient.call(
//         contract: contract,
//         function: ethFunction,
//         params: [],
//       );
//       print('kkkk: $value');
//     } catch (e) {
//       print("mintAmount: $e");
//     }
//   }


//   Future nftHoldings(walletAddress)async{
//     try{
//       String abi = await rootBundle.loadString("assets/contract/contract.abi.json");
//       Web3Client? ethClient = Web3Client(_rpcUrl!, Client());
//       final contract = DeployedContract(ContractAbi.fromJson(abi, contractAddress!),
//           EthereumAddress.fromHex(contractAddress!));
//       String functionName = 'walletOfOwner';
//       final ethFunction = contract.function(functionName);
//       value = await ethClient.call(contract: contract,
//           function: ethFunction,
//           params: [EthereumAddress.fromHex(walletAddress)]);
//       print('kkkk: $value');
//       return value;
//     }catch(e){
//       print("walletOfOwner: $e");
//     }
//   }

//   //   String abi = await rootBundle.loadString("assets/contract/contract.abi.json");
//   //   Web3Client? ethClient = Web3Client(_rpcUrl!, Client());
//   //   mintAmount();
//   //   var etherAmount=EtherAmount.fromUnitAndValue(EtherUnit.wei,value[0]);
//   //   var etherValue = etherAmount.getValueInUnit(EtherUnit.wei) / pow(10, 18);
//   //   var etherAmountValue = EtherAmount.fromUnitAndValue(EtherUnit.ether, BigInt.from(etherValue));

//   //   EtherAmount then = EtherAmount.fromUnitAndValue(EtherUnit.ether, BigInt.from(etherValue));
//   //   var a =EtherAmount.fromUnitAndValue(EtherUnit.wei,value[0]);

//   //   print(etherValue);
//   //   print(etherAmountValue);
//   //   print(then);
//   //   print(a);
//   //   print(a.runtimeType);

//   //   final contract = DeployedContract(ContractAbi.fromJson(abi, contractAddress!),
//   //       EthereumAddress.fromHex(contractAddress!));
//   //   EthereumWalletConnectProvider provider =
//   //   EthereumWalletConnectProvider(connector);
//   //   final _credentials = WalletConnectEthereumCredentials(provider: provider);
//   //   String functionName = 'Mint';
//   //   final ethFunction = contract.function(functionName);
//   //   _launchUrl();
//   //   var approveTxBytes = await ethClient.sendTransaction(_credentials, Transaction.callContract(maxGas: 6000000, from: EthereumAddress.fromHex(wallet),  value: a, contract: contract, function: ethFunction, parameters: []), chainId: 97);
//   //   print(approveTxBytes);
//   //   return approveTxBytes;
//   //   // try{
//   //   //
//   //   // }catch(e){
//   //   //   print("mint: $e");
//   //   // }
//   // }


// //   Future<void> mintAmount() async {
// //   try {
// //     // Load the contract ABI from the asset file
// //     String abi = await rootBundle.loadString("assets/contract/contract.abi.json");
// //
// //     // Create a Web3Client
// //     Web3Client? ethClient = Web3Client(_rpcUrl!, Client());
// //
// //     // Create a DeployedContract instance
// //     final contract = DeployedContract(
// //       ContractAbi.fromJson(abi, contractAddress!),
// //       EthereumAddress.fromHex(contractAddress!),
// //     );
// //
// //     // Specify the function name
// //     String functionName = 'MINT_PRICE';
// //
// //     // Get the function
// //     final ethFunction = contract.function(functionName);
// //
// //     // Call the function
// //     value = await ethClient.call(
// //       contract: contract,
// //       function: ethFunction,
// //       params: [],
// //     );
// //
// //     print('kkkk: $value');
// //   } catch (e) {
// //     print("mintAmount: $e");
// //   }
// // }

//   // Future mintAmount() async {
//   //   try {
//   //     String abi =
//   //         await rootBundle.loadString("assets/contract/contract.abi.json");
//   //     Web3Client? ethClient = Web3Client(_rpcUrl!, Client());
//   //     final contract = DeployedContract(
//   //         ContractAbi.fromJson(abi, contractAddress!),
//   //         EthereumAddress.fromHex(contractAddress!));
//   //     String functionName = 'MINT_PRICE';
//   //     final ethFunction = contract.function(functionName);
//   //     value = await ethClient
//   //         .call(contract: contract, function: ethFunction, params: []);
//   //     print('kkkk: $value');
//   //   } catch (e) {
//   //     print("mintAmount: $e");
//   //   }
//   // }

//   // Future nftHoldings(walletAddress) async {
//   //   try {
//   //     String abi =
//   //         await rootBundle.loadString("assets/contract/contract.abi.json");
//   //     Web3Client? ethClient = Web3Client(_rpcUrl!, Client());
//   //     final contract = DeployedContract(
//   //         ContractAbi.fromJson(abi, contractAddress!),
//   //         EthereumAddress.fromHex(contractAddress!));
//   //     String functionName = 'walletOfOwner';
//   //     final ethFunction = contract.function(functionName);
//   //     value = await ethClient.call(
//   //         contract: contract,
//   //         function: ethFunction,
//   //         params: [EthereumAddress.fromHex(walletAddress)]);
//   //     print('kkkk: $value');
//   //     return value;
//   //   } catch (e) {
//   //     print("walletOfOwner: $e");
//   //   }
//   // }


// //   Future<List<dynamic>> nftHoldings(String walletAddress) async {
// //   try {
// //     // Load the contract ABI from the asset file
// //     String abi = await rootBundle.loadString("assets/contract/contract.abi.json");
// //
// //     // Create a Web3Client
// //     Web3Client? ethClient = Web3Client(_rpcUrl!, Client());
// //
// //     // Create a DeployedContract instance
// //     final contract = DeployedContract(
// //       ContractAbi.fromJson(abi, contractAddress!),
// //       EthereumAddress.fromHex(contractAddress!),
// //     );
// //
// //     // Specify the function name
// //     String functionName = 'walletOfOwner';
// //
// //     // Get the function
// //     final ethFunction = contract.function(functionName);
// //
// //     // Call the function with the walletAddress parameter
// //     final value = await ethClient.call(
// //       contract: contract,
// //       function: ethFunction,
// //       params: [EthereumAddress.fromHex(walletAddress)],
// //     );
// //
// //     print('kkkk: $value');
// //     return value;
// //   } catch (e) {
// //     print("walletOfOwner: $e");
// //     return []; // Return an empty list in case of an error
// //   }
// // }

// Future tokenURI(int tokenID) async {
//   try {
//     // Load the contract ABI from a JSON file
//     String abi = await rootBundle.loadString("assets/contract/contract.abi.json");

//     // Initialize an Ethereum client using an RPC URL
//     Web3Client? ethClient = Web3Client(_rpcUrl!, Client());

//     // Create a DeployedContract instance using the loaded ABI and contract address
//     final contract = DeployedContract(
//         ContractAbi.fromJson(abi, contractAddress!),
//         EthereumAddress.fromHex(contractAddress!)
//     );

//     // Specify the function name to call on the contract (tokenURI in this case)
//     String functionName = 'tokenURI';

//     // Get the contract function object based on the function name
//     final ethFunction = contract.function(functionName);

//     // Call the contract function and pass the tokenID as a parameter
//     value = await ethClient.call(
//       contract: contract,
//       function: ethFunction,
//       params: [BigInt.from(tokenID)],
//     );

//     print('Token URI: $value');
//   } catch (e) {
//     print("tokenURI: $e");
//   }
// }

// }
