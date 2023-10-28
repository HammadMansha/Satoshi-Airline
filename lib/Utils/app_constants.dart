import 'package:get/get.dart';

import '../controllers/app_controllers.dart';

class AppConstants {
  //app Global
  static const String imagePath = "assets/images";

  static const String iconPath = "assets/icons";
  static const String logoPath = "assets/logo";
  static const String lottie = "assets/lottie";
  static const String pdf = "assets/pdf";
  static const String sound = "sounds";

  static const String levelUpLogo = "$imagePath/img_39.png";
  static const String linkButton = "$imagePath/img_39.png";
  static const String loadingGif = "$imagePath/Loading_transparency new.gif";
  static const String loading = "$imagePath/loading.png";
  static const String sellLogo = "$imagePath/img_34.png";
  static const String breedLogo = "$imagePath/img_35.png";
  static const String leaseLogo = "$imagePath/img_36.png";
  static const String statusButton = "$imagePath/img_51.png";
  static const String transferLogo = "$imagePath/img_37.png";
  static const String ferryDialogBox = "$imagePath/img_67.png";
  static const String nointernet = "$lottie/nointernet.json";
  static const String imageerror = "$lottie/image_error.json";
  static const String boostImage = "$lottie/img_68.png";
  static const String privacy = "$pdf/privacy.pdf";
  static const String terms = "$pdf/terms.pdf";

  static const String avatarPath = "assets/avatars";
  static const String appName = "Satoshi";
  static const String amountTxt = "Amount";
  static const String sapTxt = "SAP";
  static const String redeemSucMsg = " SAP WILL BE DEPOSITED TO YOUR WALLET";
  static const String pricesTxt = "Price per Plane - 0.2 BNB Each";
  static const String pricesTxtTitle =
      "MINT YOUR PLANE FOR\nFOR FUTURE REWARD!";
  static const String rank = "FLY Ranking";
  static const String amountOfMinting = "Mining Amount";
  static const String tutMsg =
      "To get reward, tap 'redeem' upon arrival and notification.";
  static const String record = "Record";
  static const String days = "Day";
  static const String weeks = "Week";
  static const String months = "Month";
  static const String years = "Year";

  // static const String appBaseUrl = "http://18.188.250.115:5000/";
  // static const int appVersion = 1;
  // static const String googleMapApiKey = "API KEY";
  // static const double defaultPadding = 16.0;
  // static const String BASE_URL = "https://api.seatgeek.com/2";
  // static const clientId = "Mjk3OTEwMDV8MTY2NjA5MjI0Mi42NDU1OTgy";
  // static const apiSecretKey =
  //     "9187beec5582ab814122fdf67d90b3874c759a3714af8b386b24a6f133b07a46";
  //
  //
  // //app auth
  // static const String appAuth = "api/auth/";
  //
  //
  // //app Wallet
  // static const String appWallet= "api/wallet/";
  //
  //
  // //app profile
  // static const String appProfile= "api/profile/";
  //
  //
  // //app auth endPoints
  // static const String signIn = "sign-in";
  // static const String signUp = "signup";
  // static const String signOut = "sign-out";
  // static const String resetPasswordEmail = "reset-password-link";
  // static const String resetPasswordToken = "reset-password";
  //
  //
  // //app wallet endPoints
  // static const String transactions = "transactions";
  // static const String transaction = "transaction";
  //
  //
  // //app wallet endPoints
  // static const String wallets = "wallets";
  // static const String wallet = "wallet";
  // static const String fnfWallets = "fnf-wallets";
  // static const String fnfWallet = "fnf-wallet";
  //
  //
  // //event endpoints
  // static const endPoint = "/events";
  //
  //texts
  static const loginText = 'LOGIN / SIGN UP';
  static const delAccount = 'Delete Account';
  static const hintTextEmail = 'Email address';
  static const hintTextName = 'Update Name';
  static const tutTextBtn = '';
  static const start = 'START';
  static const checkInFerry = 'Check-In';
  static const checkIn = 'CHECK IN';
  static const from = 'FROM';
  static const to = 'TO';
  static const time = 'Time:';
  static const distance = 'Distance:';
  static const attributes = 'Attributes';
  static const cValue = 'Current Value';
  static const uValue = 'Upgrade Value';
  static const hintTextVerify = 'Email verification code';
  static const email = 'Email';
  static const newPass = 'New password';
  static const sendCode = 'Send code';
  static const welcomeText = 'WELCOME TO';
  static const invStatusTitle = 'STATUS OF INVITATION';
  static const updatePass = 'CHANGE PASSWORD';
  static const link = 'LINK';
  static const flyingRecord = 'FLYING RECORD';
  static const totInvStatusTitle = 'Total Invitation';
  static const lengthOfInv = '20 friends can be invited a week';
  static const invDurations = 'THIS WEEK                          ';
  static const nextInv = '     Next available invitation time';
  static const friendInvited = 'INVITED FRIEND';
  static const privacyTxt1 = 'I agree to Satoshi Airlines ';
  static const privacyTxt2 = 'Terms of Use ';
  static const privacyTxt3 = '& ';
  static const privacyTxt4 = 'Privacy Policy ';
  static const String accountLogin = "Account Login";
  static const String alertTitle = "TERMS OF USE & PRIVACY POLICY";
  static const String avatarAlertTitle = "AVATAR SET";
  static const String alertTitleGoogleAuth = "GOOGLE AUTHENTICATOR";
  static const String alertTitleGender = "GENDER";
  static const String conAlertTitle = "IMPROVE ATTRIBUTE LIMIT";
  static const String congratulateText = "CONGRATULATION!";
  static const String myNft = "MY NFT";
  static const String nftTransfer = "NFT TRANSFER";
  static const String flyToEarnTitle = "FLY TO EARN";
  static const String destinationTitle = "WHERE ARE YOU GOING ?";
  static const String arrivalTitle = "ARRIVAL";
  static const String destination = "DEPARTURE";
  static const String arrival = "ARRIVAL";
  static const String confirmationDesMsg =
      "Your starting point has been confirmed!";
  static const String confirmationArrivalMsg =
      "Your starting point has been confirmed";
  static const String hintDesMsg =
      "Starting point is automatically proved when you are within the airport radius 1 km";
  static const String hintArrivalMsg =
      "Arrival point confirmed within 1Km airport radius";
  //Wallet
  static const String spenderTitle = "Spending Account";
  static const String arbTxt = "ARB";
  static const String satTxt = "SAT";

  //icons_images
  static const mintBg = "$imagePath/mintBg.png";
  static const desArrival = "$imagePath/des&Ariv.png";
  static const arrivaldes = '$imagePath/arrival.png';
  static const mapImg = "$imagePath/mapImg.png";
  static const mapImgVer = "$imagePath/mapImgVer.png";
  static const nextBtnS = "$imagePath/nextBtnS.png";
  static const mintConBg = "$imagePath/mintConBg.png";
  static const dropDownVector = "$imagePath/dropDownVector.png";
  static const planeImg = "$imagePath/planeImg.png";
  static const mintedNftImg = "$imagePath/mintedNftImg.png";
  static const nftFrame = "$imagePath/nftFrame.png";
  static const fuelField = "$imagePath/fuelField.png";
  static const saveBtnL = "$imagePath/saveBtnL.png";
  static const googleAuthDown = "$imagePath/googleAuthDown.png";
  static const cloud = "$imagePath/cloud.png";
  static const addNftBtn = "$imagePath/addNftBtn.png";
  static const subNftBtn = "$imagePath/subNftBtn.png";
  static const connectBtnL = "$imagePath/connectBtnL.png";
  static const mintBtn = "$imagePath/mintBtn.png";
  static const myNftBtn = "$imagePath/myNftBtn.png";
  static const proLink = "$imagePath/proLink.png";
  static const nextInvImg = "$imagePath/nextInvImg.png";
  static const mintHeadImg = "$imagePath/mintHeadImg.png";
  static const silver = "$imagePath/silver.png";
  static const cancelBtn = "$imagePath/cancelBtn.png";
  static const depDasImg = "$imagePath/depDas.png";
  static const mintNotStarted = "$imagePath/mintNotStarted.png";
  static const recordStatus = "$imagePath/delfound.png";
  static const mineField = "$imagePath/mineField.png";
  static const durabilityField = "$imagePath/durabilityField.png";
  static const luckyField = "$imagePath/luckyField.png";
  static const startBtn = "$imagePath/img_66.png";
  static const departureIconFerry = "$imagePath/img_58.png";
  static const playIcon = "$imagePath/img_56.png";
  static const addIconFerry = "$imagePath/img_57.png";
  static const noInternet = "$imagePath/nointernetnew.png";
  static const newLogo = "$imagePath/newlogo_onboard.png";
  static const clouds = "$imagePath/clouds.png";


  static const onBoardImage = "$imagePath/login_new.png";
  static const bgImage = "$imagePath/bg.png";
  static const alertBtnImage = "$imagePath/dialogBtn.png";
  static const avatarAlertBtnImage = "$imagePath/avatarSaveBtn.png";
  static const googleAuthBtn = "$imagePath/googleAuthBtn.png";
  static const loginBtnImage = "$imagePath/loginBtn.png";
  static const loginBtnImg = "$imagePath/loginBtnImg.png";
  static const deleteLater = "$imagePath/Group 866.png";
  static const appAttributes = "$imagePath/Group 922.png";
  static const reward = "$imagePath/rewardnew.png";
  static const googleicom = '$imagePath/googleIcon.png';
  static const airplane = '$imagePath/airplane.png';
  static const pin = '$imagePath/map-pin.png';
  static const flytoearn = '$imagePath/flytoearn.png';
  static const boarding = '$imagePath/Boarding_transparency new.gif';

  static const avatarMale = "$imagePath/avatarMale.png";
  static const avatarFemale = "$imagePath/avatarFemale.png";
  static const avatarOther = "$imagePath/avatarOther.png";
  static const avatarSecret = "$imagePath/avatarSecret.png";
  static const nftBg="$imagePath/my_nft_bg.png";

  static const travelKM = "$imagePath/travel.png";
  static const checkInBtn = "$imagePath/checkInBtn.png";
  static const commonNft = "$imagePath/commonNft.png";
  static const map = "$imagePath/map.png";
  static const redeemKM = "$imagePath/redeem.png";
  static const discordBtn = "$imagePath/discord.png";
  static const twitterBtn = "$imagePath/twitter.png";
  static const telegramBtn = "$imagePath/telegram.png";
  static const logoutBtn = "$imagePath/logoutBtn.png";
  static const noItems = "$imagePath/noItems.png";
  static const levelOneNft = "$imagePath/Group 860.png";
  static const burnSAP = "$imagePath/burnSAP.png";
  static const nxTimeBtn = "$imagePath/nxTimeBtn.png";
  static const conBtn = "$imagePath/conBtn.png";
  static const conBtnL = "$imagePath/conBtnL.png";
  static const profileDel = "$imagePath/profileDel.png";
  static const polygon = "$imagePath/polygon.png";
  static const avatarBg = "$imagePath/avatarBg.png";
  static RxString profileImg = "$imagePath/profileImg.png".obs;
  static const first = "$imagePath/first.png";
  static const second = "$imagePath/second.png";
  static const third = "$imagePath/third.png";
  static const flyFromTo = "$imagePath/flyFromTo.png";
  static const redeemSuccess = "$imagePath/redeemSuccess.png";
  static const deleteIt = "$imagePath/deleteIt.png";
  static const redeemBanner = "$imagePath/redeemBanner.png";
  static const inviteBtn = "$imagePath/invite.png";
  static const takeOff = "$iconPath/takeOff.png";
  static const addIcon = "$iconPath/addIcon.png";
  static const addIconWhite = "$iconPath/addIconWhite.png";
  static const helpIcon = "$iconPath/helpIcon.png";
  static const usdIcon = "$iconPath/usd.png";
  static const sapIcon = "$iconPath/sap.png";
  static const btcIcon = "$imagePath/btc.png";
  static const fuelIcon = "$iconPath/fuelIcon.png";

  static const wingIcon = "$imagePath/wing.png";
  static const engineIcon = "$imagePath/engine.png";
  static const radioIcon = "$imagePath/radio.png";
  static const blackBoxIcon = "$imagePath/black_box.png";

  static const durabilityIcon = "$iconPath/durabilityIcon.png";
  static const luckyIcon = "$iconPath/luckyIcon.png";
  static const mineIcon = "$iconPath/mineIcon.png";
  static const binanceIcon = "$iconPath/binance.png";
  static const boardNavIcon = "$iconPath/board.png";
  static const assetsNavIcon = "$iconPath/assets.png";
  static const flyNavIcon = "$iconPath/fly.png";
  static const marketNavIcon = "$iconPath/market.png";
  static const walletIcon = "$iconPath/wallet.png";
  static const vectorIcon = "$iconPath/Vector.png";
  static RxString backBtn = "$iconPath/backBtn.png".obs;
  static const logo = "$logoPath/new_logo.png";

  //Wallet
  static const walletHelp = "$imagePath/walletHelp.png";

  //controllers
  static final fieldController = TextControllers.fieldControllers;

  // <------------------ Sounds --------------------->
  static const comingSoonSound = "$sound/mixkit-arrow-whoosh-1491.mp3";
  static const checkInSound = "$sound/airport-checkin-soundeffect02-100081.mp3";
  static const redeemSound = "$sound/success-redeem.mp3";

}


