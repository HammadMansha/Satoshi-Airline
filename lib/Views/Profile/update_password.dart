import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:satoshi/widget/loading/loading_screen.dart';
import '../../Controllers/updatepassword_controller.dart';
import '../../Utils/utils.dart';

class UpdatePassword extends StatelessWidget {
  const UpdatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return GetBuilder<UpdatePasswordController>(
      init: UpdatePasswordController(),
      builder: (_) {
        return MediaQuery(
          data: mqDataNew,
          child: Scaffold(
            backgroundColor: Color(0xffFFFAEC),
            body: _.isLoading.value
                ? const Loading()
                : Stack(
                    children: [
                      Positioned(
                        top: 74,
                        left: 10,
                        child: GestureDetector(
                          onTap: () => Get.back(),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Image.asset(
                                AppConstants.backBtn.value,
                                height: 42,
                              )),
                        ),
                      ),
                      Positioned(
                        top: 74,
                        left: 83,
                        // right: 36,
                        child: Transform(
                          transform: Matrix4.identity(),
                          child: Container(
                            width: 272,
                            height: 42,
                            decoration: BoxDecoration(
                                color: AppColors.btnBgColor,
                                border: Border.all(
                                  color: AppColors.black,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 70,
                        left: 80,
                        // right: 40,
                        child: Transform(
                          transform: Matrix4.identity(),
                          child: Container(
                              width: 272,
                              height: 42,
                              decoration: BoxDecoration(
                                  color: const Color(0xffFFFDFD),
                                  border: Border.all(
                                    color: AppColors.black,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  AppConstants.updatePass,
                                  style: invStatusTitleStyle,
                                ),
                              )),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 150, left: 20, right: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    AppConstants.email,
                                    style: TextStyle(
                                        color: AppColors.primaryColor2,
                                        fontSize: 9,
                                        fontWeight: FontWeight.w400),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: buildEmail(_),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    AppConstants.hintTextVerify,
                                    style: TextStyle(
                                        color: AppColors.primaryColor2,
                                        fontSize: 9,
                                        fontWeight: FontWeight.w400),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: buildVerify(_),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    AppConstants.newPass,
                                    style: TextStyle(
                                        color: AppColors.primaryColor2,
                                        fontSize: 9,
                                        fontWeight: FontWeight.w400),
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: buildPassword(_),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Create a password that:',
                                  style: GoogleFonts.sora(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '• contains at least 8 characters\n'
                                  '• contains both lower (a-z) and upper case letters (A-Z)\n'
                                  '• contains at least one number (0-9)\n'
                                  '• contains at least a symbol\n',
                                  style: GoogleFonts.sora(
                                    color: AppColors.primaryColor2,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                              SizedBox(
                                // height: 150,
                                height: 50,
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    _.isLoading.value = true;
                                    if (_.formKey2.currentState!.validate() &&
                                        _.formKey3.currentState!.validate() &&
                                        _.formKey.currentState!.validate()) {
                                      await _.updatePassword();
                                    }
                                  },
                                  child: Image.asset(AppConstants.saveBtnL))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
          ),
        );
      },
    );
  }

  Widget buildEmail(UpdatePasswordController _) {
    return Form(
      key: _.formKey2,
      child: TextFormField(
        // style: const TextStyle(color: AppColors.descColor),
        keyboardType: TextInputType.emailAddress,
        controller: _.email,
        onChanged: (value) {
          _.formKey2.currentState!.validate();
        },
        readOnly: true,
        validator: (value) {
          const pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
          _.regExp = RegExp(pattern); // uni code form mai reg exp dedi hai
          if (value!.isEmpty) {
            return 'enter an email';
          }
          return null;
          // else if (!regExp.hasMatch(value)) {
          //   return 'enter valid email';
          // }
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Enter email',
          hintStyle: hintTextStyle,
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.black,
            ),
            borderRadius: BorderRadius.circular(10.0),
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
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.black,
            ),
          ),
          // border: OutlineInputBorder(
          //   borderSide: BorderSide.none,
          //   // borderRadius: BorderRadius.circular(50),
          // ),
          // hintText: AppConstants.hintTextEmail,
          // hintStyle: hintTextStyle,
        ),
      ),
    );
  }

  Form buildVerify(UpdatePasswordController _) {
    return Form(
      key: _.formKey,
      child: TextFormField(
        // style: const TextStyle(color: AppColors.descColor),
        keyboardType: TextInputType.number,
        controller: _.code,
        onChanged: (value) {
          _.formKey.currentState!.validate();
          _.update();
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter Code';
          }
          return null;
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
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
          hintText: 'Verification Code',
          hintStyle: hintTextStyle,
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
          // hintText: AppConstants.hintTextVerify,
          // hintStyle: hintTextStyle,
        ),
      ),
    );
  }

  Form buildPassword(UpdatePasswordController _) {
    return Form(
        key: _.formKey3,
        child: TextFormField(
          keyboardType: TextInputType.text,
          controller: _.password,
          validator: (value) {
            if (value!.isEmpty) {
              return 'enter password';
            }
            return null;
          },
          onChanged: (value) {
            _.formKey3.currentState!.validate();
            _.update();
          },
          obscureText: _.isPasswordNotVisible,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
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
            // prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              onPressed: () {
                _.isPasswordNotVisible = !_.isPasswordNotVisible;
                _.update();
              },
              icon: _.isPasswordNotVisible
                  ? const Icon(
                      Icons.visibility_off,
                      color: AppColors.primaryColor1,
                    )
                  : const Icon(
                      Icons.visibility,
                      color: AppColors.primaryColor1,
                    ),
            ),
            hintText: 'Password',
            hintStyle: hintTextStyle,
          ),
        ));
  }
}

// class UpdatePassword extends StatefulWidget {
//   const UpdatePassword({Key? key}) : super(key: key);

//   @override
//   State<UpdatePassword> createState() => _UpdatePasswordState();
// }

// class _UpdatePasswordState extends State<UpdatePassword> {

//   bool isLoading=false;

//   setPassBool(boolean)async{
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     pref.setBool('isUpdated', boolean);
//   }
//   sendCodeApi() {
//     print("test");
//     Object object = {
//       "email": AppConstants.fieldController.emailController.value.text,
//       "reason": "loginSignup"
//     };
//     services
//         .emailAuth(AppConstants.fieldController.emailController.value.text,
//             "updatePassword")
//         .then((value) {
//       setState(() {
//         print("VALUE of send_email_code: $value");
//         setPassBool(true);
//         // Get.off(const LandingPage());
//       });
//     });
//   }

//   AuthServices services = AuthServices();
//   var userId;
//   var token;

//   getUserInfo() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     userId = pref.getString('userId');
//     token = pref.getString('token');
//     updatePassApi(userId, token);
//   }

//   updatePassApi(id, bearerToken) async {
//     Object object = {
//       "email": AppConstants.fieldController.emailController.value.text,
//       "password": AppConstants.fieldController.passwordController.value.text,
//       "emailCode": AppConstants.fieldController.otpController.value.text,
//     };
//     await services
//         .config(id, bearerToken, object, "update_password", "post")
//         .then((value) {
//       setState(() {
//         print("VALUE of update_password: $value");
//         if (value["error"] == "Password is not strong enough") {
//           AppConstants.fieldController.showSnackbar('Alert',
//               'The password must contain at least 8 characters including at least one');
//         }
//         else if (value["error"] == "Password is not strong enough") {
//           AppConstants.fieldController.showSnackbar('Alert',
//               'Incorrect Verification Code');
//         }
//         else{
//           AppConstants.fieldController.showSnackbar('Success',
//               'Password Updated successfuly');
//           isLoading = false;
//           Get.off(const Login());
//         }
//         AppConstants.fieldController.passwordController.value.text = '';
//       });
//     });

//     // await services
//     //     .updatePassword(bearerToken, AppConstants.fieldController.emailController.value.text, AppConstants.fieldController.emailController.value.text)
//     //     .then((value) {
//     //   setState(() {
//     //     print("VALUE of update_password: $value");
//     //     if (value["error"] == "Password is not strong enough") {
//     //       AppConstants.fieldController.showSnackbar('Alert',
//     //           'The password must contain at least 8 characters including at least one');
//     //     }
//     //     else if (value["error"] == "Password is not strong enough") {
//     //       AppConstants.fieldController.showSnackbar('Alert',
//     //           'Incorrect Verification Code');
//     //     }
//     //     else{
//     //       AppConstants.fieldController.showSnackbar('Success',
//     //           'Password Updated successfuly');
//     //       isLoading = false;
//     //       Get.off(const Login());
//     //     }
//     //     AppConstants.fieldController.passwordController.value.text = '';
//     //   });
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return }
// }
