// import 'dart:typed_data';

// import 'package:walletconnect_dart/walletconnect_dart.dart';

// class WalletConnectEthereumCredentials extends CustomTransactionSender {
//   WalletConnectEthereumCredentials({this.ethereum, this.connector, required this.provider});
//   final connector;
//   final ethereum;
//   final EthereumWalletConnectProvider provider;

//   @override
//   Future<EthereumAddress> extractAddress() {
//     throw UnimplementedError();
//   }

//   @override
//   Future<String> sendTransaction(Transaction transaction) async {
//     final hash = provider.sendTransaction(
//       from: transaction.from!.hex,
//       to: transaction.to?.hex,
//       data: transaction.data,
//       gas: transaction.maxGas,
//       gasPrice: transaction.gasPrice?.getInWei,
//       value: transaction.value?.getInWei,
//       nonce: transaction.nonce,
//     );

//     return hash;


//   }


//   Future<String> signTransaction() async {
//     final sender = EthereumAddress.fromHex('0x9b7b657efc9780cbcdca826ce72968188d523a1d');

//     final transaction = Transaction(
//       to: sender,
//       from: sender,
//       gasPrice: EtherAmount.inWei(BigInt.one),
//       maxGas: 100000,
//       value: EtherAmount.fromUnitAndValue(EtherUnit.finney, 1),
//     );

//     final credentials = WalletConnectEthereumCredentials(provider: provider);

//     // Sign the transaction
//     final txBytes = await ethereum.sendTransaction(credentials, transaction);

//     // Kill the session
//     connector.killSession();

//     return txBytes;
//   }

//   @override
//   Future<MsgSignature> signToSignature(Uint8List payload, {int? chainId, bool isEIP1559 = false}) {
//     throw UnimplementedError();
//   }


//   // @override
//   // Future<MsgSignature> signToSignature(Uint8List payload,
//   //     {int chainId, bool isEIP1559 = false}) {
//   //   throw UnimplementedError();
//   // }
// }


// // class EthereumTransactionTester extends TransactionTester {
// //   final Web3Client ethereum;
// //   final EthereumWalletConnectProvider provider;
// //
// //   EthereumTransactionTester._internal({
// //     WalletConnect connector,
// //     this.ethereum,
// //     this.provider,
// //   }) : super(connector: connector);
// //
// //   factory EthereumTransactionTester() {
// //     final ethereum = Web3Client('https://ropsten.infura.io/', Client());
// //
// //     final connector = WalletConnect(
// //       bridge: 'https://bridge.walletconnect.org',
// //       clientMeta: PeerMeta(
// //         name: 'WalletConnect',
// //         description: 'WalletConnect Developer App',
// //         url: 'https://walletconnect.org',
// //         icons: [
// //           'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
// //         ],
// //       ),
// //     );
// //
// //     final provider = EthereumWalletConnectProvider(connector);
// //
// //     return EthereumTransactionTester._internal(
// //       connector: connector,
// //       ethereum: ethereum,
// //       provider: provider,
// //     );
// //   }
// //
// //   @override
// //   Future<SessionStatus> connect({OnDisplayUriCallback? onDisplayUri}) async {
// //     return connector.connect(chainId: 3, onDisplayUri: onDisplayUri);
// //   }
// //
// //   @override
// //   Future<void> disconnect() async {
// //     await connector.killSession();
// //   }
// //
// //   @override
// //   Future<String> signTransaction(SessionStatus session) async {
// //     final sender = EthereumAddress.fromHex(session.accounts[0]);
// //
// //     final transaction = Transaction(
// //       to: sender,
// //       from: sender,
// //       gasPrice: EtherAmount.inWei(BigInt.one),
// //       maxGas: 100000,
// //       value: EtherAmount.fromUnitAndValue(EtherUnit.finney, 1),
// //     );
// //
// //     final credentials = WalletConnectEthereumCredentials(provider: provider);
// //
// //     // Sign the transaction
// //     final txBytes = await ethereum.sendTransaction(credentials, transaction);
// //
// //     // Kill the session
// //     connector.killSession();
// //
// //     return txBytes;
// //   }
// //
// //   @override
// //   Future<String> signTransactions(SessionStatus session) {
// //     // TODO: implement signTransactions
// //     throw UnimplementedError();
// //   }
// // }