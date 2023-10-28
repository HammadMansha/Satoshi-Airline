import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satoshi/Utils/app_constants.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(
        textScaleFactor:
            mqData.textScaleFactor > 1.0 ? 1.0 : mqData.textScaleFactor);
    return MediaQuery(
      data: mqDataNew,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Satoshi Airlines Privacy'),
        ),
        body: SizedBox(
          height: Get.height,
          width: Get.width,
          child: SfPdfViewer.asset(
            AppConstants.privacy
          ),
        ),
        // SingleChildScrollView(
        //   padding: const EdgeInsets.all(16.0),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: const [
        //       Text(
        //         'Privacy Policy',
        //         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         'Your privacy is important to us. It is SATOSHI AIRLINES LIMITED. policy to respect your privacy and comply with any applicable law and regulation regarding any personal information we may collect about you, including via our app, Satoshi Airlines, and its associated services.',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         'Accessible URL Links related to our service*',
        //         style: TextStyle(fontWeight: FontWeight.bold),
        //       ),
        //       SizedBox(height: 8.0),
        //       TextLink(
        //         text: 'Website: https://satoshiair.xyz',
        //         url: 'https://satoshiair.xyz',
        //       ),
        //       TextLink(
        //         text: 'Telegram Announcement: https://t.me/satoshiairline_info',
        //         url: 'https://t.me/satoshiairline_info',
        //       ),
        //       TextLink(
        //         text: 'Telegram (GLOBAL): https://t.me/satoshiairlines',
        //         url: 'https://t.me/satoshiairlines',
        //       ),
        //       TextLink(
        //         text: 'Discord: https://discord.com/invite/7pVTcHYHn7',
        //         url: 'https://discord.com/invite/7pVTcHYHn7',
        //       ),
        //       TextLink(
        //         text: 'Twitter: https://twitter.com/Satoshiairlines',
        //         url: 'https://twitter.com/Satoshiairlines',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '1. What information is covered under this policy?',
        //         style: TextStyle(fontWeight: FontWeight.bold),
        //       ),
        //       SizedBox(height: 8.0),
        //       Text(
        //         'Personal information is any information about you that can be used to identify you. This includes information about you as a person (such as name, address, and date of birth), your devices, payment details, and even information about how you use an app or online service.',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         'In the event our app contains links to third-party sites and services, please be aware that those sites and services have their own privacy policies. After following a link to any third-party content, you should read their posted privacy policy information about how they collect and use personal information. This Privacy Policy does not apply to any of your activities after you leave our app.',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         'This policy is effective as of 26 Mar 2023.',
        //         style: TextStyle(fontWeight: FontWeight.bold),
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '2. Personal information that we may collect from you',
        //         style: TextStyle(fontWeight: FontWeight.bold),
        //       ),
        //       SizedBox(height: 8.0),
        //       Text(
        //         'Information we collect falls into one of two categories: “voluntarily provided” information and “automatically collected” information.',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '(1) “Voluntarily provided” information refers to any information you knowingly and actively provide us when using our app and its associated services.',
        //       ),
        //       SizedBox(height: 8.0),
        //       Text(
        //         '(2) “Automatically collected” information refers to any information automatically sent by your device in the course of accessing our app and its associated services.',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '3. Log Data',
        //         style: TextStyle(fontWeight: FontWeight.bold),
        //       ),
        //       SizedBox(height: 8.0),
        //       Text(
        //         'When you access our servers via our app, we may automatically log the standard data provided by your device. It may include your device"s Internet Protocol (IP) address, your device type and version, your activity within the app, time and date, and other details about your usage.',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         'Additionally, when you encounter certain errors while using the app, we automatically collect data about the error and the circumstances surrounding its occurrence. This data may include technical details about your device, what you were trying to do when the error happened, and other technical information relating to the problem. You may or may not receive notice of such errors, even at the moment they occur, that they have occurred, or what the nature of the error is.',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         'Please be aware that while this information may not be personally identifying by itself, it may be possible to combine it with other data to personally identify individual persons.',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '4. Device Data',
        //         style: TextStyle(fontWeight: FontWeight.bold),
        //       ),
        //       SizedBox(height: 8.0),
        //       Text(
        //         'Our app may access and collect data via your device"s in-built tools, such as:',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         'Location data',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         'Camera',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         'Accelerometer',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         'Body sensor',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         'Storage, photos, and/or media',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         'Google user data (The way we use Google user data is limited to what we have described in the privacy policy).',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         'When you install the app or use your device’s tools within the app, we request permission to access this information. The specific data we collect can depend on the individual settings of your device and the permissions you grant when you install and use the app.',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '5. Personal Information',
        //         style: TextStyle(fontWeight: FontWeight.bold),
        //       ),
        //       SizedBox(height: 8.0),
        //       Text(
        //         'We may ask for personal information — for example, when you submit content to us or when you contact us — which may include one or more of the following:',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         'Email',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         'Date of birth',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         'travel history',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '6. Sensitive Information',
        //         style: TextStyle(fontWeight: FontWeight.bold),
        //       ),
        //       SizedBox(height: 8.0),
        //       Text(
        //         '“Sensitive information” or “special categories of data” is a subset of personal information that is given a higher level of protection. Examples of sensitive information include information relating to your racial or ethnic origin, political opinions, religion, trade union or other professional associations or memberships, philosophical beliefs, sexual orientation, sexual practices or sex life, criminal records, health information, or biometric information.',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         'The types of sensitive information that we may collect about you include:',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         'Health information',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         'Biometric information',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         'We will not collect sensitive information about you without first obtaining your consent, and we will only use or disclose your sensitive information as permitted, required, or authorized by law.',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '7. User-Generated Content',
        //         style: TextStyle(fontWeight: FontWeight.bold),
        //       ),
        //       SizedBox(height: 8.0),
        //       Text(
        //         'We consider “user-generated content” to be materials (text, image, and/or video content) voluntarily supplied to us by our users for the purpose of publication on our platform, website, or re-publishing on our social media channels. All user-generated content is associated with the account or email address used to submit the materials.',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         'Please be aware that any content you submit for the purpose of publication will be public after posting (and subsequent review or vetting process). Once published, it may be accessible to third parties not covered under this privacy policy.',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '8. Legitimate Reasons for Processing Your Personal Information',
        //         style: TextStyle(fontWeight: FontWeight.bold),
        //       ),
        //       SizedBox(height: 8.0),
        //       Text(
        //         'We only collect and use your personal information when we have a legitimate reason for doing so. In this instance, we only collect personal information that is reasonably necessary to provide our services to you.',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '9. Collection and Use of Information',
        //         style: TextStyle(fontWeight: FontWeight.bold),
        //       ),
        //       SizedBox(height: 8.0),
        //       Text(
        //         'We may collect personal information from you when you do any of the following on our website:',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '(1) Register for an account (2) Enter any of our competitions, contests, sweepstakes, and surveys (3) Use a mobile device or web browser to access our content (4) Contact us via email, social media, or on any similar technologies (5) When you mention us on social media',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         'We may collect, hold, use, and disclose information for the following purposes, and personal information will not be further processed in a manner that is incompatible with these purposes:',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '(1) to provide you with our app and platform"s core features and services (2) to enable you to customize or personalize your experience of our website (3) for analytics, market research, and business development, including operating and improving our app, associated applications, and associated social media platforms (4) for advertising and marketing, including to send you promotional information about our products and services and information about third parties that we consider may be of interest to you (5) to run competitions, sweepstakes, and/or offer additional benefits to you (6) for technical assessment, including to operate and improve our app, associated applications, and associated social media platforms',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         'We may combine voluntarily provided and automatically collected personal information with general information or research data we receive from other trusted sources. For example, If you consent to us accessing your social media profiles, we may combine information sourced from those profiles with information received from you directly to provide you with an enhanced experience of our app and services.',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '10. Security of Your Personal Information',
        //         style: TextStyle(fontWeight: FontWeight.bold),
        //       ),
        //       SizedBox(height: 8.0),
        //       Text(
        //         'When we collect and process personal information, and while we retain this information, we will protect it within commercially acceptable means to prevent loss and theft, as well as unauthorized access, disclosure, copying, use, or modification.',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         'Although we will do our best to protect the personal information you provide to us, we advise that no method of electronic transmission or storage is 100% secure, and no one can guarantee absolute data security.',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         'You are responsible for selecting any password and its overall security strength, ensuring the security of your own information within the bounds of our services. For example, ensuring any passwords associated with accessing your personal information and accounts are secure and confidential.',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '11. How Long do We Keep Your Personal Information',
        //         style: TextStyle(fontWeight: FontWeight.bold),
        //       ),
        //       SizedBox(height: 8.0),
        //       Text(
        //         'We keep your personal information only for as long as we need to. This time period may depend on what we are using your information for, in accordance with this privacy policy. For example, if you have provided us with personal information as part of creating an account with us, we may retain this information for the duration your account exists on our system. If your personal information is no longer required for this purpose, we will delete it or make it anonymous by removing all details that identify you.',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         'However, if necessary, we may retain your personal information for our compliance with a legal, accounting, or reporting obligation or for archiving purposes in the public interest, scientific, or historical research purposes, or statistical purposes.',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '12. Children’s Privacy',
        //         style: TextStyle(fontWeight: FontWeight.bold),
        //       ),
        //       SizedBox(height: 8.0),
        //       Text(
        //         'We do not aim any of our products or services directly at children under the age of 13, and we do not knowingly collect personal information about children under 13.',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '13. Disclosure of Personal Information to Third Parties',
        //         style: TextStyle(fontWeight: FontWeight.bold),
        //       ),
        //       SizedBox(height: 8.0),
        //       Text(
        //         'We may disclose personal information to:',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '(1) a parent, subsidiary, or affiliate of our company',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '(2) third-party service providers for the purpose of enabling them to provide their services,',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '(3) including (without limitation) IT service providers, data storage, hosting, and server',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '(4) providers, analytics, error loggers, debt collectors, maintenance or problem-solving',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '(5) providers, professional advisors, and payment systems operators',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '(6) our employees, contractors, and/or related entities',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '(7) our existing or potential agents or business partners',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '(8) sponsors or promoters of any competition, sweepstakes, or promotion we run',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '(9) credit reporting agencies, courts, tribunals, and regulatory authorities, in the event you fail',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '(10) to pay for goods or services we have provided to you',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '(11) courts, tribunals, regulatory authorities, and law enforcement officers, as required by law',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '(12) in connection with any actual or prospective legal proceedings, or in order to establish',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '(13) exercise, or defend our legal rights',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '(14) third parties, including agents or sub-contractors, who assist us in providing information',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '(15) products, services, or direct marketing to you',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '(16) third parties to collect and process data',
        //       ),
        //       SizedBox(height: 16.0),
        //       Text(
        //         '(17) an entity that buys, or to which we transfer all or substantially all of our assets and business',
        //       ),
        //       SizedBox(height: 16.0),
        //     ],
        //   ),
        // ),
     
      ),
    );
  }
}

class TextLink extends StatelessWidget {
  final String text;
  final String url;

  const TextLink({
    required this.text,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        text,
        style: TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
      onTap: () => launchURL(url),
    );
  }

  Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
