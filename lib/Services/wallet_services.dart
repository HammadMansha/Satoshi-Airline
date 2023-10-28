
import 'package:bip39/bip39.dart' as bip39;
import 'package:web3dart/credentials.dart';

abstract class WalletAddressServices {
  String generateMnemonic();

  Future<String> getPrivateKey(String mnemonic);

  Future<EthereumAddress> getPublicKey(String mnemonic);
}

class WalletAddress extends WalletAddressServices {
  @override
  Future<String> getPrivateKey(String mnemonic) async {
    final seed = bip39.mnemonicToSeed(mnemonic);
    final master = seed.sublist(0, 32); // Use first 32 bytes as private key
    final privateKey = '0x' +
        master.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
    return privateKey;
  }

  @override
  Future<EthereumAddress> getPublicKey(String privateKey) async {
    final credentials = EthPrivateKey.fromHex(privateKey);
    final address = await credentials.extractAddress();
    return address;
  }

  @override
  String generateMnemonic() {
    return bip39.generateMnemonic();
  }
}

// class WalletAddress extends WalletAddressServices {
//   @override
//   Future<String> getPrivateKey(String mnemonic) async {
//     final seed = bip39.mnemonicToSeed(mnemonic);
//     final master = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);
//     final privatekey = HEX.encode(master.key);
//     return privatekey;
//   }
//
//   @override
//   Future<EthereumAddress> getPublicKey(String privatekey) async {
//     final private = EthPrivateKey.fromHex(privatekey);
//     final address = await private.address;
//     return address;
//   }
//
//   @override
//   String generateMnemonic() {
//     return bip39.generateMnemonic();
//   }
//   void sendTransaction(String publicKey, String receiver, EtherAmount txValue) async {
//    try{
//      var apiUrl = "https://data-seed-prebsc-1-s3.binance.org:8545/"; // Replace with your API
//      var httpClient = http.Client();
//      var ethClient = Web3Client(apiUrl, httpClient);
//
//     EthPrivateKey credentials = EthPrivateKey.fromHex('0x' + publicKey);
//
//      EtherAmount gasPrice = await ethClient.getGasPrice();
//
//      await ethClient.sendTransaction(
//        credentials,
//        Transaction(
//          to: EthereumAddress.fromHex(receiver),
//          gasPrice: gasPrice,
//          maxGas: 100000,
//          value: txValue,
//        ),
//        chainId: 11155111,
//      );
//    }catch(e){
//      print("Error is ${e.toString()}");
//    }
//   }
// }
