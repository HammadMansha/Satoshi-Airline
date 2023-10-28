import 'package:get/get.dart';
import 'package:satoshi/Views/AuthScreens/login.dart';
import 'package:satoshi/Views/AuthScreens/signup.dart';
import 'package:satoshi/Views/Holders/NftHolder/Pro/check_in.dart';
import 'package:satoshi/Views/Holders/NftHolder/Pro/extra_page.dart';
import 'package:satoshi/Views/Holders/NftHolder/Pro/totalminting.dart';
import 'package:satoshi/Views/Holders/NftHolder/arrival.dart';
import 'package:satoshi/Views/Holders/NftHolder/destination.dart';
import 'package:satoshi/Views/Holders/NonNftHolder/LeadingBoard/Record/view_all_record.dart';
import 'package:satoshi/Views/Holders/NonNftHolder/LeadingBoard/leading_tab_view.dart';
// import 'package:satoshi/Views/Holders/NonNftHolder/LeadingBoard/leading_board_all.dart';
import 'package:satoshi/Views/Holders/NonNftHolder/fly_to_earn.dart';
import 'package:satoshi/Views/Holders/NonNftHolder/redeem_success.dart';
import 'package:satoshi/Views/Holders/NonNftHolder/reward_to_redeem.dart';
import 'package:satoshi/Views/Landing/landing.dart';
import 'package:satoshi/Views/Minting/minting.dart';
import 'package:satoshi/Views/Policies/privacy_policies.dart';
import 'package:satoshi/Views/Policies/terms_of_use.dart';
import 'package:satoshi/Views/Profile/delete_account.dart';
import 'package:satoshi/Views/Profile/editProfile.dart';
import 'package:satoshi/Views/Profile/profile.dart';
import 'package:satoshi/Views/Profile/update_field.dart';
import 'package:satoshi/Views/Profile/update_password.dart';
import 'package:satoshi/Views/Wallet/tabbarView/tabarview_screen.dart';
import 'package:satoshi/Views/free_jeets/check_in_free_jetset/check_in_free_jetset.dart';
import 'package:satoshi/Views/free_jeets/destination_feery/destination_ferry.dart';
import 'package:satoshi/Views/free_jeets/fly_to_earn_ferryjet/fly_to_earn_ferry.dart';
import 'package:satoshi/Views/free_jeets/level_screen/level_screen_free.dart';
import 'package:satoshi/Views/level/level_screen.dart';
import 'package:satoshi/Views/my_total_nfts/my_total_nfts.dart';
import 'package:satoshi/Views/splash.dart';
import 'package:satoshi/routes/app_routes.dart';

import '../Views/Wallet/WalletCommon/wallet_tab_view.dart';
import '../Views/free_jeets/total_minting_ferry/total_minting_ferry.dart';

class AppPages {
  static const INITIAL = Routes.splashRoutes;

  static List<GetPage> routes = [
    // < -------------------- Splash Page ----------------->
    GetPage(
      name: Routes.splashRoutes,
      page: () => const Splash(),
    ),

    // < -------------------- Landing Page ----------------->
    GetPage(
      name: Routes.landingRoutes,
      page: () => const LandingPage(),
    ),

    // < -------------------- Signup Page ----------------->
    GetPage(
      name: Routes.signupRoutes,
      page: () => const SignUp(),
    ),

    // < -------------------- Login Page ----------------->
    GetPage(
      name: Routes.signinRoutes,
      page: () => const Login(),
    ),

    // < -------------------- Minting Page ----------------->
    GetPage(
      name: Routes.mintingRoutes,
      page: () => const Minting(),
    ),

    // < -------------------- Buy Coins Page ----------------->
    GetPage(
      name: Routes.buycoinsRoutes,
      page: () => const ExtraPage(),
    ),

    // < -------------------- Profile Page ----------------->
    GetPage(
      name: Routes.profileRoutes,
      page: () => const Profile(),
    ),

    // < -------------------- Edit Profile Page ----------------->
    GetPage(
      name: Routes.editprofileRoutes,
      page: () => const EditProfile(),
    ),

    // < -------------------- Terms and Condition Page ----------------->
    GetPage(
      name: Routes.termsandconditionRoutes,
      page: () => const TermsOfServiceScreen(),
    ),

    // < -------------------- Privacy Policy Page ----------------->
    GetPage(
      name: Routes.privacyPolicyRoutes,
      page: () => const PrivacyPolicyScreen(),
    ),

    // < -------------------- Update Name Page ----------------->
    GetPage(
      name: Routes.updateNameRoutes,
      page: () => const UpdateField(),
    ),

    // < -------------------- Update Password Page ----------------->
    GetPage(
      name: Routes.updatePasswordRoutes,
      page: () => const UpdatePassword(),
    ),

    // < -------------------- Delete Account Page ----------------->
    GetPage(
      name: Routes.deleteAccountRoutes,
      page: () => const DeleteAccount(),
    ),

    // < -------------------- Level Page ----------------->
    GetPage(
      name: Routes.levelRoutes,
      page: () => const LevelScreen(),
    ),

    // < -------------------- Reward to Redeme Page ----------------->
    GetPage(
      name: Routes.rewardToRedeemRoutes,
      page: () => const RewardToRedeem(),
    ),

    // < -------------------- Fly to Earn Page ----------------->
    GetPage(
      name: Routes.flytoearnRoutes,
      page: () => const FlyToEarn(),
    ),

    // < -------------------- Fly to Earnferry Page ----------------->
    GetPage(
      name: Routes.flytoearnFerryRoutes,
      page: () => const FlyToEarnFerry(),
    ),

    // < -------------------- Destination Page ----------------->
    GetPage(
      name: Routes.destinationRoutes,
      page: () => Destination(),
    ),

    // < -------------------- Destinationferry Page ----------------->
    GetPage(
      name: Routes.destinationferryRoutes,
      page: () => const DestinationFerry(),
    ),

    // < -------------------- Total Minting Page ----------------->
    GetPage(
      name: Routes.totalmintingRoutes,
      page: () => const TotalMintingScreen(),
    ),
    // < -------------------- Total Mintingferry Page ----------------->
    GetPage(
      name: Routes.totalmintingFerryRoutes,
      page: () => const TotalMintingFerryScreen(),
    ),

    // < -------------------- Check In Page ----------------->
    GetPage(
      name: Routes.checkInRoutes,
      page: () => const CheckIn(),
    ),
    // < -------------------- Check In Page ----------------->
    GetPage(
      name: Routes.checkInRoutesFerry,
      page: () => const CheckInferryJet(),
    ),

    // < -------------------- Arrival Page ----------------->
    GetPage(
      name: Routes.arrivalRoutes,
      page: () => const Arrival(),
    ),

    // < -------------------- Redeem Success Page ----------------->
    GetPage(
      name: Routes.redeemSuccessRoutes,
      page: () => const RedeemSuccess(),
    ),

    // < -------------------- Redeem Success Page ----------------->
    // GetPage(
    //   name: Routes.leadingBoardAllRoutes,
    //   page: () => const LeadingBoardAll(),
    // ),

    // < -------------------- View All Recoard Page ----------------->
    GetPage(
      name: Routes.viewAllRecordRoutes,
      page: () => const ViewAllRecord(),
    ),

    // < -------------------- Travel History Page ----------------->
    GetPage(
      name: Routes.travelHistoryRoutes,
      page: () => const LeadingTabView(),
    ),

    // < -------------------- Tabbar view Page ----------------->
    GetPage(
      name: Routes.tabbarviewRoutes,
      page: () => TababarView(),
    ),
    // < -------------------- wallet tab view ----------------->
    GetPage(
      name: Routes.walletTabviewRoutes,
      page: () => WalletTabView(),
    ),
    // < -------------------- leve route free ----------------->
    GetPage(
      name: Routes.levelRoutesfree,
      page: () => LevelScreenFree(),
    ),

    // < -------------------- my nft route ----------------->
    GetPage(
      name: Routes.myNftScreen,
      page: () => MyTotalNftsScreen(),
    ),
  ];
}
