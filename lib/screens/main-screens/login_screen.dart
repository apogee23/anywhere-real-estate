// import 'package:realogy/packages/modern_snackbar/custom_snack_bar.dart';
// import 'package:realogy/packages/modern_snackbar/top_snack_bar.dart';
// import 'package:realogy/providers/providers.dart';
// import 'package:realogy/widgets/submit-button/submit_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intercom_flutter/intercom_flutter.dart';
// import 'package:realogy/colors/custom_colors.dart';
// import 'package:theme_provider/theme_provider.dart';

// class LoginScreen extends ConsumerStatefulWidget {
//   const LoginScreen({
//     super.key,
//   });

//   @override
//   ConsumerState<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends ConsumerState<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {
//     var screenSize = MediaQuery.of(context).size;
//     var userState = ref.watch(userProvider);

//     return Scaffold(
//       backgroundColor: ThemeProvider.themeOf(context).data.backgroundColor,
//       body: Center(
//         child: SizedBox(
//           width: screenSize.width / 2,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "This is Realogy. Welcome.",
//                 style: TextStyle(
//                   fontSize: 24,
//                   color: ThemeProvider.themeOf(context)
//                       .data
//                       .textTheme
//                       .bodyText1
//                       ?.color,
//                 ),
//               ),
//               const SizedBox(height: 30),
//               SubmitButton(
//                 text: "Login",
//                 onPressed: () async {
//                   try {
//                     // await userState.login();
//                   } catch (e) {
//                     showTopSnackBar(
//                       // ignore: use_build_context_synchronously
//                       Overlay.of(context),
//                       CustomSnackBar.success(
//                         message: "Login error: ${e.toString()}.",
//                       ),
//                       displayDuration: const Duration(seconds: 2),
//                     );
//                   }
//                 },
//               ),
//               const SizedBox(height: 30),
//               const Text(
//                 "Trouble logging in?",
//                 style: TextStyle(
//                   fontSize: 14,
//                 ),
//               ),
//               const SizedBox(width: 5),
//               TextButton(
//                 child: const Text(
//                   "Refresh",
//                   style: TextStyle(
//                     color: CustomColors.primary,
//                   ),
//                 ),
//                 // onPressed: () async => await userState.logout(),
//                 onPressed: () {},
//               ),
//               const SizedBox(width: 5),
//               TextButton(
//                 child: const Text(
//                   "Chat Us",
//                   style: TextStyle(
//                     color: CustomColors.primary,
//                   ),
//                 ),
//                 onPressed: () async {
//                   try {
//                     await Intercom.instance.displayMessenger();
//                   } catch (e) {
//                     print("Intercom error: $e");
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
