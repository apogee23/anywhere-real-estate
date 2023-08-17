// // ignore_for_file: use_build_context_synchronously

// import 'package:currency_picker/currency_picker.dart';
// import 'package:realogy/colors/custom_colors.dart';
// import 'package:realogy/globals.dart';
// import 'package:realogy/packages/modern_snackbar/custom_snack_bar.dart';
// import 'package:realogy/packages/modern_snackbar/top_snack_bar.dart';
// import 'package:realogy/providers/providers.dart';
// import 'package:realogy/screens/celebrations/celebration_screen.dart';
// import 'package:realogy/screens/main-screens/home_screen.dart';
// import 'package:realogy/utils/api/get_data.dart';
// import 'package:realogy/utils/show_common_modal_bottom_sheet.dart';
// import 'package:realogy/widgets/common/share_and_add_header.dart';
// import 'package:realogy/widgets/future-builder/future_builder.dart';
// import 'package:realogy/widgets/submit-button/submit_button.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intercom_flutter/intercom_flutter.dart';
// import 'package:language_picker/language_picker.dart';
// import 'package:language_picker/languages.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';
// import 'package:theme_provider/theme_provider.dart';
// import 'package:url_launcher/url_launcher.dart';

// class SettingsScreen extends ConsumerStatefulWidget {
//   const SettingsScreen({
//     super.key,
//   });

//   @override
//   ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends ConsumerState<SettingsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     var userState = ref.watch(userProvider);
//     var itemState = ref.watch(itemProvider);

//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           const SizedBox(height: 20),
//           GestureDetector(
//             onTap: () => _handleUpdateNickname(userState),
//             child: FittedBox(
//               fit: BoxFit.fitWidth,
//               child: Text(
//                 userState.user!.name ?? "[Set Name]",
//                 style: const TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           RichText(
//             text: TextSpan(
//               children: [
//                 WidgetSpan(
//                   child: FittedBox(
//                     fit: BoxFit.fitWidth,
//                     child: Text(
//                       "@${userState.user!.nickname ?? "[Set Handle]"}",
//                       style: const TextStyle(
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const WidgetSpan(
//                   child: SizedBox(
//                     width: 5,
//                   ),
//                 ),
//                 WidgetSpan(
//                   alignment: PlaceholderAlignment.middle,
//                   child: GestureDetector(
//                     onTap: () => _handleUpdateNickname(userState),
//                     child: const Icon(Icons.edit, size: 14),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 10),
//           if (userState.user!.email != null)
//             FittedBox(
//               fit: BoxFit.fitWidth,
//               child: Text(
//                 userState.user!.email ?? "",
//                 style: const TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey,
//                 ),
//               ),
//             ),
//           const SizedBox(height: 20),
//           ListTile(
//             title: const Text("Accounts"),
//             subtitle: Text(
//               "${itemState.connectedItems.length} Tracked Accounts",
//             ),
//             trailing: const Icon(Icons.chevron_right),
//             onTap: () => widget.goToItemsScreen(),
//           ),
//           const Divider(
//             thickness: 2,
//             height: 1,
//           ),
//           ListTile(
//             title: const Text("Language"),
//             subtitle: Text(
//               Language.fromIsoCode(
//                 userState.user!.language ?? "en",
//               ).name,
//             ),
//             trailing: const Icon(Icons.chevron_right),
//             onTap: () => _openLanguagePicker(
//               context,
//               userState,
//             ),
//           ),
//           const Divider(
//             thickness: 2,
//             height: 1,
//           ),
//           ListTile(
//             title: const Text("Currency"),
//             subtitle: Text(
//               "${userState.user!.currency ?? "USD"}"
//               " (${NumberFormat.simpleCurrency(
//                 name: userState.user!.currency ?? "USD",
//               ).currencySymbol})",
//             ),
//             trailing: const Icon(Icons.chevron_right),
//             onTap: () => _openCurrencyPicker(userState),
//           ),
//           if (!kIsWeb)
//             const Divider(
//               thickness: 2,
//               height: 1,
//             ),
//           if (!kIsWeb)
//             PBFutureBuilder(
//               future: Purchases.getCustomerInfo(),
//               body: (customerInfo) =>
//                   (customerInfo?.entitlements.all['pro']?.isActive ?? false)
//                       ? ListTile(
//                           title: const Text("Subscrition Plan: Pro"),
//                           trailing: const Icon(Icons.chevron_right),
//                           onTap: () => showDialog<void>(
//                             context: context,
//                             barrierDismissible: false, // user must tap button!
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 title: const Text(
//                                   'Subscription Plan Details',
//                                 ),
//                                 content: const SingleChildScrollView(
//                                   child: ListBody(
//                                     children: [
//                                       SizedBox(height: 20),
//                                       Row(
//                                         children: [
//                                           Icon(
//                                             Icons.check_circle,
//                                             size: 14,
//                                             color: CustomColors.secondary,
//                                           ),
//                                           SizedBox(
//                                             width: 10,
//                                           ), //space between bullet and text
//                                           Expanded(
//                                             child: Text(
//                                               "No more ads. Ever.",
//                                             ), //text
//                                           )
//                                         ],
//                                       ),
//                                       SizedBox(height: 5),
//                                       Row(
//                                         children: [
//                                           Icon(
//                                             Icons.check_circle,
//                                             size: 14,
//                                             color: CustomColors.secondary,
//                                           ),
//                                           SizedBox(
//                                             width: 10,
//                                           ), //space between bullet and text
//                                           Expanded(
//                                             child: Text(
//                                               "Unlimited manual holdings",
//                                             ), //text
//                                           )
//                                         ],
//                                       ),
//                                       SizedBox(height: 5),
//                                       Row(
//                                         children: [
//                                           Icon(
//                                             Icons.check_circle,
//                                             size: 14,
//                                             color: CustomColors.secondary,
//                                           ),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Expanded(
//                                             child: Text(
//                                               "Unlimited automatically linked accounts (US only)",
//                                             ), //text
//                                           )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 actions: <Widget>[
//                                   TextButton(
//                                     child: const Text(
//                                       'Close',
//                                     ),
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                   ),
//                                 ],
//                               );
//                             },
//                           ),
//                         )
//                       : ListTile(
//                           title: const Text("Upgrade to Pro"),
//                           trailing: const Icon(Icons.chevron_right),
//                           onTap: _handleCheckout,
//                         ),
//             ),
//           const Divider(
//             thickness: 2,
//             height: 1,
//           ),
//           ListTile(
//             title: const Text("Customer Support & FAQ"),
//             trailing: const Icon(Icons.chevron_right),
//             onTap: () async => await Intercom.instance.displayMessenger(),
//           ),
//           const SizedBox(height: 20),
//           PBFutureBuilder(
//             future: PackageInfo.fromPlatform(),
//             body: (packageInfo) => Text(
//               "Version ${packageInfo?.version}.${packageInfo?.buildNumber}",
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           OutlinedButton.icon(
//             // onPressed: () async => await userState.logout(),
//             onPressed: () {},
//             style: OutlinedButton.styleFrom(
//               side: const BorderSide(
//                 color: CustomColors.primary,
//               ),
//               padding: const EdgeInsets.all(12),
//             ),
//             icon: const Icon(
//               Icons.logout,
//               color: CustomColors.primary,
//             ),
//             label: const Text(
//               "Logout",
//               style: TextStyle(
//                 color: CustomColors.primary,
//               ),
//             ),
//           ),
//           const SizedBox(height: 5),
//           const Text(
//             "Log out to change password.",
//             style: TextStyle(
//               fontSize: 10,
//             ),
//           ),
//           const SizedBox(height: 40),
//           const Text(
//             "Danger Zone",
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 5),
//           OutlinedButton.icon(
//             onPressed: () async => _showDeleteAccountModal(context, userState),
//             style: OutlinedButton.styleFrom(
//               side: const BorderSide(
//                 color: Colors.red,
//               ),
//             ),
//             icon: const Icon(
//               Icons.delete,
//               color: Colors.red,
//             ),
//             label: const Text(
//               "Delete Account",
//               style: TextStyle(
//                 color: Colors.red,
//               ),
//             ),
//           ),
//           const SizedBox(height: 30),
//         ],
//       ),
//     );
//   }

//   void _openLanguagePicker(
//     BuildContext mainContext,
//     UserStateNotifier userState,
//   ) =>
//       showDialog(
//         context: context,
//         builder: (context) => Theme(
//           data: Theme.of(context).copyWith(
//             primaryColor: CustomColors.secondary,
//           ),
//           child: LanguagePickerDialog(
//             languages: [
//               Language.fromIsoCode("en"),
//               Language.fromIsoCode("es"),
//               Language.fromIsoCode("fr"),
//               Language.fromIsoCode("it"),
//               Language.fromIsoCode("ja"),
//               Language.fromIsoCode("nl"),
//               Language.fromIsoCode("de"),
//               Language.fromIsoCode("pt"),
//             ],
//             titlePadding: const EdgeInsets.all(8.0),
//             searchCursorColor: CustomColors.secondary,
//             searchInputDecoration: const InputDecoration(
//               hintText: 'Search...',
//             ),
//             isSearchable: true,
//             title: const Text(
//               'Select your language',
//             ),
//             onValuePicked: (Language language) async {
//               // ignore: use_build_context_synchronously
//               await mainContext.setLocale(Locale(language.isoCode));

//               userState.user!.language = language.isoCode;
//               await userState.user!.save();
//               userState.refreshUserState();
//             },
//             itemBuilder: _buildDialogItem,
//           ),
//         ),
//       );

//   void _openCurrencyPicker(
//     UserStateNotifier userState,
//   ) =>
//       showCurrencyPicker(
//         context: context,
//         showFlag: false,
//         showCurrencyName: true,
//         showCurrencyCode: true,
//         currencyFilter: <String>[
//           'USD',
//           'EUR',
//           'JPY',
//           'GBP',
//           'CHF',
//           'CAD',
//           'AUD',
//           'CNY',
//           'HKD',
//           'SGD',
//           'NZD',
//           'TRY',
//           'MXN',
//           'INR',
//           'KRW',
//           'THB',
//           'NOK',
//           'SEK',
//           'DKK',
//           'RUB',
//           // 'IDR',
//           // 'MYR',
//           // 'PHP',
//           // 'BRL',
//           // 'CZK',
//           // 'PLN',
//           // 'ZAR',
//           // 'ILS',
//           // 'RON',
//           // 'HUF',
//           // 'SAR',
//           // 'BHD',
//           // 'TWD',
//           // 'CLP',
//           // 'COP',
//           // 'PEN',
//           // 'VEF',
//           // 'PKR',
//           // 'LKR',
//           // 'NGN',
//           // 'KES',
//           // 'UAH',
//         ],
//         onSelect: (Currency currency) async {
//           userState.user!.currency = currency.code;
//           await userState.user!.save();
//           userState.refreshUserState();

//           // ignore: use_build_context_synchronously
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const HomeScreenContainer(),
//             ),
//           );
//         },
//       );

//   Widget _buildDialogItem(Language language) => Row(
//         children: <Widget>[
//           Text(language.name),
//           const SizedBox(width: 8.0),
//           Flexible(child: Text("(${language.isoCode})"))
//         ],
//       );

//   void _handleCheckout() async {
//     try {
//       Offerings offerings = await Purchases.getOfferings();
//       // showDialog(
//       //   context: context,
//       //   builder: (context) => Text(
//       //     offerings.current.toString(),
//       //   ),
//       // );
//       if (offerings.current != null &&
//           offerings.current!.availablePackages.isNotEmpty) {
//         // Display packages for sale.
//         showCommonModalBottomSheet(
//           context: context,
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 20),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Unlock Realogy Pro",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Container(
//                     padding: const EdgeInsets.all(15),
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.grey,
//                       ),
//                       borderRadius: const BorderRadius.all(
//                         Radius.circular(10),
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         const Text("MANUAL TRACKING"),
//                         const SizedBox(height: 5),
//                         Text(
//                           "${NumberFormat.simpleCurrency().format(
//                             (offerings.current?.weekly?.storeProduct.price ??
//                                     0) /
//                                 12,
//                           )}/month",
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ),
//                         ),
//                         const SizedBox(height: 5),
//                         const Text("BILLED ANNUALLY"),
//                         const SizedBox(height: 5),
//                         const Row(
//                           children: [
//                             Icon(
//                               Icons.check_circle,
//                               size: 14,
//                               color: CustomColors.secondary,
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Expanded(
//                               child: Text(
//                                 "No more ads. Ever.",
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                         const SizedBox(height: 5),
//                         const Row(
//                           children: [
//                             Icon(
//                               Icons.check_circle,
//                               size: 14,
//                               color: CustomColors.secondary,
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Expanded(
//                               child: Text(
//                                 "Unlimited accounts.",
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                         const SizedBox(height: 5),
//                         const Row(
//                           children: [
//                             Icon(
//                               Icons.check_circle,
//                               size: 14,
//                               color: CustomColors.secondary,
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Expanded(
//                               child: Text(
//                                 "Unlimited holdings.",
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                         const SizedBox(height: 5),
//                         const Row(
//                           children: [
//                             Icon(
//                               Icons.info_outline,
//                               size: 14,
//                               color: Colors.grey,
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Expanded(
//                               child: Text(
//                                 "Manually add holdings.",
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                         const SizedBox(height: 20),
//                         SubmitButton(
//                           text: "Purchase Pro",
//                           onPressed: () async {
//                             try {
//                               final customerInfo =
//                                   await Purchases.purchasePackage(
//                                 offerings.current!.weekly!,
//                               );
//                               final isPro = customerInfo.entitlements
//                                       .all['manual_pro']?.isActive ??
//                                   false;
//                               if (isPro) {
//                                 // ignore: use_build_context_synchronously
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => CelebrationScreen(
//                                       title: "Welcome to Realogy PRO!",
//                                       subtitle:
//                                           "You've unlocked everythng Purple"
//                                           " Brick has to offer!",
//                                       actionText: "Continue to PRO",
//                                       action: (cntx) => Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (cntx) =>
//                                               const HomeScreenContainer(),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               }
//                             } on PlatformException catch (e) {
//                               final errorCode =
//                                   PurchasesErrorHelper.getErrorCode(e);
//                               if (errorCode ==
//                                   PurchasesErrorCode.purchaseCancelledError) {
//                                 print('User cancelled');
//                               } else if (errorCode ==
//                                   PurchasesErrorCode.purchaseNotAllowedError) {
//                                 print('User not allowed to purchase');
//                               } else if (errorCode ==
//                                   PurchasesErrorCode.paymentPendingError) {
//                                 print('Payment is pending');
//                               }
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   Container(
//                     padding: const EdgeInsets.all(15),
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.grey,
//                       ),
//                       borderRadius: const BorderRadius.all(
//                         Radius.circular(10),
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         const Text("AUTO-TRACKING"),
//                         const SizedBox(height: 5),
//                         Text(
//                           "${NumberFormat.simpleCurrency().format(
//                             offerings.current?.monthly?.storeProduct.price,
//                           )}/month",
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ),
//                         ),
//                         const SizedBox(height: 5),
//                         const Text(
//                           "Live in the United States?",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const Text(
//                           "You can auto-link your brokerage accounts! No more"
//                           " manual entry of holdings! Powered by Plaid.",
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(height: 10),
//                         SubmitButton(
//                           text:
//                               "Monthly (${NumberFormat.simpleCurrency().format(
//                             offerings.current?.monthly?.storeProduct.price,
//                           )}/month)",
//                           onPressed: () async {
//                             try {
//                               final customerInfo =
//                                   await Purchases.purchasePackage(
//                                 offerings.current!.monthly!,
//                               );
//                               final isPro = customerInfo
//                                       .entitlements.all['pro']?.isActive ??
//                                   false;
//                               if (isPro) {
//                                 // ignore: use_build_context_synchronously
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => CelebrationScreen(
//                                       title: "Welcome to Realogy PRO!",
//                                       subtitle:
//                                           "You've unlocked everythng Purple"
//                                           " Brick has to offer!",
//                                       actionText: "Continue to PRO",
//                                       action: (cntx) => Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (cntx) =>
//                                               const HomeScreenContainer(),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               }
//                             } on PlatformException catch (e) {
//                               final errorCode =
//                                   PurchasesErrorHelper.getErrorCode(e);
//                               if (errorCode ==
//                                   PurchasesErrorCode.purchaseCancelledError) {
//                                 print('User cancelled');
//                               } else if (errorCode ==
//                                   PurchasesErrorCode.purchaseNotAllowedError) {
//                                 print('User not allowed to purchase');
//                               } else if (errorCode ==
//                                   PurchasesErrorCode.paymentPendingError) {
//                                 print('Payment is pending');
//                               }
//                             }
//                           },
//                         ),
//                         const SizedBox(height: 10),
//                         SubmitButton(
//                           text: "Annual (${NumberFormat.simpleCurrency().format(
//                             offerings.current?.annual?.storeProduct.price,
//                           )}/year)",
//                           onPressed: () async {
//                             try {
//                               final customerInfo =
//                                   await Purchases.purchasePackage(
//                                 offerings.current!.annual!,
//                               );
//                               final isPro = customerInfo
//                                       .entitlements.all['pro']?.isActive ??
//                                   false;
//                               if (isPro) {
//                                 // ignore: use_build_context_synchronously
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => CelebrationScreen(
//                                       title: "Welcome to Realogy PRO!",
//                                       subtitle:
//                                           "You've unlocked everythng Purple"
//                                           " Brick has to offer!",
//                                       actionText: "Continue to PRO",
//                                       action: (cntx) => Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (cntx) =>
//                                               const HomeScreenContainer(),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               }
//                             } on PlatformException catch (e) {
//                               final errorCode =
//                                   PurchasesErrorHelper.getErrorCode(e);
//                               if (errorCode ==
//                                   PurchasesErrorCode.purchaseCancelledError) {
//                                 print('User cancelled');
//                               } else if (errorCode ==
//                                   PurchasesErrorCode.purchaseNotAllowedError) {
//                                 print('User not allowed to purchase');
//                               } else if (errorCode ==
//                                   PurchasesErrorCode.paymentPendingError) {
//                                 print('Payment is pending');
//                               }
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   TextButton(
//                     onPressed: () async {
//                       try {
//                         var restoredInfo = await Purchases.restorePurchases();
//                         // ... check restored purchaserInfo to see if entitlement is now active
//                       } on PlatformException catch (e) {
//                         // Error restoring purchases
//                       }
//                     },
//                     child: const Text(
//                       "Restore Purchase",
//                       style: TextStyle(
//                         color: CustomColors.secondary,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     "Subscription automatically renews unless it is cancelled"
//                     " at least 24 hours before the end of the current period."
//                     " Your account will be charged for renewal within 24 hours"
//                     " prior to the end of the current period. You can manage"
//                     " and cancel your subscriptions by going to your account"
//                     " settings on the App Store after purchase.",
//                     style: TextStyle(
//                       color: Colors.grey.shade500,
//                       fontSize: 12,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   TextButton(
//                     onPressed: () => launchUrl(
//                       Uri.parse(
//                         "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/",
//                       ),
//                     ),
//                     child: const Text(
//                       "Terms of Use (EULA)",
//                       style: TextStyle(
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () => launchUrl(
//                       Uri.parse(
//                         "https://drive.google.com/file/d/1FTRMAcW7gclNk0jkhkg9xw4bXYgWMu1-/view?usp=sharing",
//                       ),
//                     ),
//                     child: const Text(
//                       "Privacy Policy",
//                       style: TextStyle(
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }
//     } on PlatformException catch (e) {
//       showTopSnackBar(
//         // ignore: use_build_context_synchronously
//         Overlay.of(context),
//         const CustomSnackBar.error(
//           message: "Oops, something went wrong. Let's try that again!",
//         ),
//       );
//     }
//   }

//   void _handleUpdateNickname(UserStateNotifier userState) {
//     var nameController = TextEditingController(
//       text: userState.user!.name,
//     );
//     var nicknameController = TextEditingController(
//       text: userState.user!.nickname,
//     );

//     showCommonModalBottomSheet(
//       context: context,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           TextField(
//             controller: nameController,
//             textInputAction: TextInputAction.done,
//             cursorColor: CustomColors.primary,
//             style: const TextStyle(),
//             decoration: const InputDecoration(
//               icon: Icon(
//                 Icons.person,
//               ),
//               hintText: "Your Name",
//               fillColor: Colors.transparent,
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: CustomColors.primary, width: 0.0),
//               ),
//               filled: true,
//               border: OutlineInputBorder(),
//               contentPadding: EdgeInsets.only(
//                 left: 15,
//                 bottom: 11,
//                 top: 11,
//                 right: 15,
//               ),
//             ),
//           ),
//           const SizedBox(height: 12),
//           TextField(
//             controller: nicknameController,
//             textInputAction: TextInputAction.done,
//             cursorColor: CustomColors.primary,
//             style: const TextStyle(),
//             decoration: const InputDecoration(
//               icon: Icon(
//                 Icons.alternate_email,
//               ),
//               hintText: "Your Name",
//               fillColor: Colors.transparent,
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: CustomColors.primary, width: 0.0),
//               ),
//               filled: true,
//               border: OutlineInputBorder(),
//               contentPadding: EdgeInsets.only(
//                 left: 15,
//                 bottom: 11,
//                 top: 11,
//                 right: 15,
//               ),
//             ),
//           ),
//           const SizedBox(height: 12),
//           SubmitButton(
//             text: "Save",
//             // disabled: _selectedTicker == null ||
//             //     double.tryParse(quantityController.text) == null,
//             onPressed: () async {
//               if (nicknameController.text.isNotEmpty) {
//                 try {
//                   await getData(
//                     authority: Globals.API_URL,
//                     endpoint: "/api/nickname/${nicknameController.text}",
//                   );
//                 } on Exception catch (e) {
//                   showTopSnackBar(
//                     // ignore: use_build_context_synchronously
//                     Overlay.of(context),
//                     const CustomSnackBar.error(
//                       message:
//                           "Oops, that handle is already taken. Try another one!",
//                     ),
//                   );
//                 }
//               }

//               if (nameController.text.isNotEmpty) {
//                 await getData(
//                   authority: Globals.API_URL,
//                   endpoint: "/api/name/${nameController.text}",
//                 );
//               }

//               setState(() {
//                 userState.user!.nickname = nicknameController.text;
//                 userState.user!.name = nameController.text;
//               });

//               // ignore: use_build_context_synchronously
//               Navigator.pop(context);

//               showTopSnackBar(
//                 // ignore: use_build_context_synchronously
//                 Overlay.of(context),
//                 const CustomSnackBar.success(
//                   message: "Changes have been saved successfully!",
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _showDeleteAccountModal(
//     BuildContext context,
//     UserStateNotifier userState,
//   ) async {
//     TextEditingController emailController = TextEditingController();

//     return showCupertinoDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text(
//             'Wait, just a minute.',
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 "Are you sure you want to delete your whole account?"
//                 " You'll lose everything, forever. And we will miss you.",
//               ),
//               const SizedBox(height: 15),
//               const Tooltip(
//                 message: "Billing for an auto-renewable subscription continues"
//                     " through Apple until you cancel the subscription,"
//                     " regardless of whether you delete your account. After"
//                     " deleting your account, you need to cancel your"
//                     " subscription or request a refund.",
//                 triggerMode: TooltipTriggerMode.tap,
//                 showDuration: Duration(seconds: 5),
//                 child: Row(
//                   children: [
//                     Text(
//                       'Currently subscribed to Pro? ',
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Icon(
//                       Icons.info_outline,
//                       size: 12,
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 15),
//               const Text(
//                 "If you're sure, confirm by typing in your email address below.",
//               ),
//               const SizedBox(height: 15),
//               TextField(
//                 controller: emailController,
//                 textInputAction: TextInputAction.done,
//                 cursorColor: CustomColors.primary,
//                 style: const TextStyle(),
//                 decoration: const InputDecoration(
//                   hintText: "Confirm your email address",
//                   fillColor: Colors.transparent,
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: CustomColors.primary,
//                       width: 0.0,
//                     ),
//                   ),
//                   filled: true,
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               Text(
//                 "Enter: ${userState.user!.email}",
//                 style: const TextStyle(
//                   fontSize: 12,
//                 ),
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             OutlinedButton(
//               style: OutlinedButton.styleFrom(
//                 side: const BorderSide(
//                   color: Colors.grey,
//                 ),
//               ),
//               child: Text(
//                 'CANCEL',
//                 style: TextStyle(
//                   color: ThemeProvider.themeOf(context)
//                       .data
//                       .textTheme
//                       .bodyText1
//                       ?.color,
//                 ),
//               ),
//               onPressed: () {
//                 setState(
//                   () => Navigator.pop(context),
//                 );
//               },
//             ),
//             ElevatedButton(
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(
//                   Colors.red,
//                 ),
//               ),
//               child: const Text('DELETE ACCOUNT'),
//               onPressed: () async {
//                 if (emailController.text == userState.user!.email) {
//                   // Delete User.
//                   await userState.user!.delete();

//                   showTopSnackBar(
//                     // ignore: use_build_context_synchronously
//                     Overlay.of(context),
//                     const CustomSnackBar.info(
//                       message: "Your account has been deleted.",
//                     ),
//                   );

//                   // Logout user.
//                   // await userState.logout();
//                 } else {
//                   showTopSnackBar(
//                     // ignore: use_build_context_synchronously
//                     Overlay.of(context),
//                     const CustomSnackBar.error(
//                       message: "Oops, that's not your email address!",
//                     ),
//                   );
//                 }
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
