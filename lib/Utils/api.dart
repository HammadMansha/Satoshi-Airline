class ApiData {
  static const baseUrl = "https://satoshiap.herokuapp.com";
  static const user = '/users';
  static const loginSignupCode = "$user/send_email_code";
  static const loginSignup = "$user/login_signup";
  static const login = "$user/login";
  static const getUser = '$user/getUser/';
  static const updateUser = '$user/update_profile';
  static const updatePassword = '$user/update_password';
  static const deleteAccount = '$user/deleteAccount';
  static const getAvatar = '/avatar/get-avatars';
  static const setAvatar = '$user/set_avatar';
  static const mapUrl = 'https://maps.googleapis.com';
  static const querypath = '/maps/api/place/autocomplete/json';
  static const getAttributes = '/token/getTokenAttributes/';
  static const getReward = '/travel/get-sapOnDistance/';
  static const runesPurchase="$baseUrl/runes/runesPurchase";

  // <--------- Blockchain path ------------->

  static const postMint = '/blockchain/mint';
  static const transferMint = '/blockchain/transfer';
  static const record = '/travel/add-travelRecord';
  static const nftdata = '/blockchain/nfts/';

  static const updateRecord = '/buy/buy-tokenAttribute';
  static const buyAttributes = '/blockchain/buyAttributes';
  static const getBalance = '/blockchain/checkBalanceApi/';

  static const getGraph = '/travel/get-travel-history/';

  static const updateLevel = '/cardLevel/level-up';
  static const boostLevel = '/cardLevel/boost-level';
  static const getLevelInfo = '/cardLevel/getCardInfo/';
  static const cancelRecord = '/travel/cancel-travelRecord';

  static const nftData = '/blockchain/nftData';
  static const ranking = '/ranking/userRankings/';

  static const saveaddress = '/blockchain/userAddress';
  static const getaddress = '/blockchain/getUserAddress/';

  static const getReferalHistory = '/users/userReferralHistory/';

  static const addview = '/adView/ad-view';
  static const viewAd = '/adView/ad-sapReward';

  static const sendEmailCodeWallet = '/users/send_wallet_email_code';
  static const verifysendEmailCodeWallet = '/users/verify_wallet_email_code';

  // https://satoshiap.herokuapp.com/ranking/userRankings/day


//------------------Api for 2FA authentication--------------------

 static const String get2FAKey="$baseUrl/users/get2fa";
  static const verify2FAEmailCode = '$baseUrl/users/verify_2fa_email_code';
  static const update2FA = '$baseUrl/users/update2fa';
  static const verify2FA = '$baseUrl/users/verifyTwoFactor';
  static const getAuthStatus='$baseUrl/users/check2faStatus';
  static const disableGoogleAuth='$baseUrl/users/delete2fa';




}