import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/deleteaccount_controller.dart';
import '../../utils/utils.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<DeleteAccountController>(
      init: DeleteAccountController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: Scaffold(
            body: Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppConstants.onBoardImage),
                  fit: BoxFit.cover,
                  // alignment: Alignment.topLeft
                ),
              ),
              child: Stack(
                children: [topBar(), cardSection(_)],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget cardSection(DeleteAccountController _) {
    return Positioned(
      top: 200,
      left: 10,
      right: 10,
      child: Transform(
        transform: Matrix4.identity(),
        // ..setEntry(3, 2, 0.001)
        // ..rotateX(0.5),
        child: Container(
          width: 300,
          height: 350,
          decoration: BoxDecoration(
              color: AppColors.offWhite,
              border: Border.all(
                color: Colors.black,
                width: 1.5, // <-- set border width here
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 35,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: buildEmail(_),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: buildVerify(_),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 42,
                child: ElevatedButton(
                  onPressed: () {
                    if (_.formKey.currentState!.validate() &&
                        _.formKey2.currentState!.validate()) {
                      _.deleteAccount();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFFF7AF)),
                  child: Text('DELETE', style: updateTxtStyle),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget topBar() {
    return Stack(
      children: [
        Positioned(
          top: 49,
          left: 45,
          right: 36,
          child: Transform(
            transform: Matrix4.identity(),
            // ..setEntry(3, 2, 0.001)
            // ..rotateX(0.5),
            child: Container(
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                  color: const Color(0xff62C8A9),
                  border: Border.all(
                    color: Colors.black,
                    width: 1.5, // <-- set border width here
                  ),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
        Positioned(
          top: 45,
          left: 40,
          right: 40,
          child: Transform(
            transform: Matrix4.identity(),
            // ..setEntry(3, 2, 0.001)
            // ..rotateX(0.5),
            child: Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                    color: const Color(0xffFFFDFD),
                    border: Border.all(
                      color: Colors.black,
                      width: 1.5, // <-- set border width here
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text(
                    AppConstants.delAccount,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                  ),
                )),
          ),
        ),
      ],
    );
  }

  Widget buildEmail(DeleteAccountController _) {
    return Form(
      key: _.formKey2,
      child: TextFormField(
        // style: const TextStyle(color: AppColors.descColor),
        keyboardType: TextInputType.emailAddress,
        controller: _.email,
        readOnly: true,
        onChanged: (value) {
          _.formKey2.currentState!.validate();
          _.update();
        },
        validator: (value) {
          const pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
          _.regExp = RegExp(pattern); // uni code form mai reg exp dedi hai

          if (value!.isEmpty) {
            return 'Enter an email';
          }
          return null;
          // else if (!regExp.hasMatch(value)) {
          //   return 'enter valid email';
          // }
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.black,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.black,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.black,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.black,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          // border: OutlineInputBorder(
          //   borderSide: BorderSide.none,
          //   // borderRadius: BorderRadius.circular(50),
          // ),
          hintText: AppConstants.hintTextEmail,
          hintStyle: hintTextStyle,
        ),
      ),
    );
  }

  Widget buildVerify(DeleteAccountController _) {
    return Form(
      key: _.formKey,
      child: TextFormField(
        // style: const TextStyle(color: AppColors.descColor),
        keyboardType: TextInputType.emailAddress,
        controller: _.code,
        onChanged: (value) {
          _.formKey.currentState!.validate();
          _.update();
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter code';
          }
          return null;
        },
        decoration: InputDecoration(
          suffixIcon: TextButton(
            onPressed: _.isClock == false
                ? () async {
                    if (_.formKey2.currentState!.validate()) {
                      if (_.regExp.hasMatch(_.email.text)) {
                        await _.getOTP();
                      }
                    }
                  }
                : () {},
            child: _.isClock
                ? Text(
                    '${_.seconds}',
                    style: textButtonStyle,
                  )
                : Text(
                    AppConstants.sendCode,
                    style: textButtonStyle,
                  ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.black,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.black,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.black,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.black,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: AppConstants.hintTextVerify,
          hintStyle: hintTextStyle,
        ),
      ),
    );
  }

  Widget richText() {
    return RichText(
      // textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(text: AppConstants.privacyTxt1, style: hintTextStyleAlert),
        TextSpan(text: AppConstants.privacyTxt2, style: privacyTxtStyleAlert),
        TextSpan(
            text: '${AppConstants.privacyTxt3}\n', style: hintTextStyleAlert),
        TextSpan(text: AppConstants.privacyTxt4, style: privacyTxtStyleAlert),
      ]),
    );
  }

  Widget richTextAlert() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
            text: "${AppConstants.privacyTxt1}\n", style: hintTextStyleAlert),
        TextSpan(text: AppConstants.privacyTxt2, style: privacyTxtStyleAlert),
        TextSpan(text: AppConstants.privacyTxt3, style: hintTextStyleAlert),
        TextSpan(text: AppConstants.privacyTxt4, style: privacyTxtStyleAlert),
      ]),
    );
  }
}

// class DeleteAccount extends StatefulWidget {
//   const DeleteAccount({Key? key}) : super(key: key);

//   @override
//   State<DeleteAccount> createState() => _DeleteAccountState();
// }

// class _DeleteAccountState extends State<DeleteAccount> {
//   startTimer() {
//     timer = Timer.periodic(const Duration(seconds: 1), (_) {
//       if (seconds > 0) {
//         if (!mounted) return;
//         setState(() => seconds--);
//       } else {
//         setState(() {
//           isClock = false;
//           startTimer();
//         });
//       }
//     });
//   }

//   @override
//   Widget build(context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: Container(
//         height: height,
//         width: width,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(AppConstants.onBoardImage),
//             fit: BoxFit.cover,
//             // alignment: Alignment.topLeft
//           ),
//         ),
//         child: Stack(
//           children: [topBar(), cardSection()],
//         ),
//       ),
//       // bottomNavigationBar: Obx(() => BottomNavigationBar(
//       //
//       //   currentIndex: Get.find<MyController>().selectedTab.value,
//       //   onTap: (index) {
//       //     Get.find<MyController>().selectedTab.value = index;
//       //   },
//       //   items: const [
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.home),
//       //       label: 'Home',
//       //     ),
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.search),
//       //       label: 'Search',
//       //     ),
//       //     BottomNavigationBarItem(
//       //       icon: Icon(Icons.person),
//       //       label: 'Profile',
//       //     ),
//       //   ],
//       // )),
//     );
//   }

//   bool isLoading = false;

//   getUserInfo() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     userId = pref.getString('userId');
//     token = pref.getString('token');
//     delAccountApi(userId, token);
//   }

//   delAccountApi(id, bearerToken) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     Object object = {
//       "email": AppConstants.fieldController.emailController.value.text,
//       "emailCode": AppConstants.fieldController.otpController.value.text,
//     };
//     var deleted;
//     await services
//         .config(id, bearerToken, object, "deleteAccount", "post")
//         .then((value) {
//       setState(() {
//         print("VALUE of deleteAccount: $value");
//         if (value["message"] == "Account deleted successfully") {
//           AppConstants.fieldController.showSnackbar(
//               'Alert', 'Your account has been deleted successfully');
//           Get.off(const SignUp());
//         }
//       });
//       pref.clear();
//     });
//   }

//   Future returnDialog() {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return SizedBox(
//           width: 300,
//           height: 50,
//           child: AlertDialog(
//             title: const Text(AppConstants.alertTitle),
//             content: richText(),
//             actions: [
//               TextButton(
//                 child: const Text("OK"),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   var token;
//   var userId;
//   sendCodeApi() {
//     print("test");
//     Object object = {
//       "email": AppConstants.fieldController.emailController.value.text,
//       "reason": "deleteAccount"
//     };
//     services
//         .emailAuth(AppConstants.fieldController.emailController.value.text,
//             "deleteAccount")
//         .then((value) {
//       setState(() {
//         print("VALUE of send_email_code: $value");
//         // Get.off(const LandingPage());
//       });
//     });
//   }

//   setUserInfo(id, bearerToken) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     pref.setString('userId', id);
//     pref.setString('token', bearerToken);
//   }
// }
