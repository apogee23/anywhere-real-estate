// import 'package:realogy/models/stripe/intents/payment_intent_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';

// void redirectToCheckout(
//   BuildContext context,
//   int price,
//   Future<void> Function() onComplete,
// ) async {
//   await presentPayment(context, price, onComplete);
// }

// Future<bool> presentPayment(
//   BuildContext context,
//   int price,
//   Future<void> Function() onComplete,
// ) async {
//   var stripeCustomerId = "cus_MISF99duuyAcH3";
//   try {
//     var paymentIntent = await PaymentIntentModel.create(
//       stripeCustomerId: stripeCustomerId,
//       amount: (price * 100).round(),
//     );

//     // 2. initialize the payment sheet
//     await Stripe.instance.initPaymentSheet(
//       paymentSheetParameters: SetupPaymentSheetParameters(
//         // Main parameters.
//         paymentIntentClientSecret: paymentIntent.clientSecret,
//         merchantDisplayName: 'Hohm',
//         // merchantCountryCode: 'US',
//         // Customer parameters.
//         customerId: stripeCustomerId,
//         customerEphemeralKeySecret: paymentIntent.ephemeralKey,
//         // Extra parameters.

//         applePay: const PaymentSheetApplePay(merchantCountryCode: "US"),
//         googlePay: const PaymentSheetGooglePay(
//           merchantCountryCode: "US",
//           currencyCode: "USD",
//           testEnv: true,
//         ),
//         style: ThemeMode.system,
//         // primaryButtonColor: Colors.redAccent,
//         // testEnv: true,
//       ),
//     );

//     // 3. display the payment sheet.
//     await Stripe.instance.presentPaymentSheet();

//     return true;

//     // Refresh payment methods list.
//   } on Exception catch (e) {
//     if (e is StripeException) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Payment Error: ${e.error.localizedMessage}'),
//         ),
//       );
//       return false;
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error: $e'),
//         ),
//       );
//       return false;
//     }
//   }
// }

// // class CheckoutPage extends StatefulWidget {
// //   final String sessionId;

// //   const CheckoutPage({Key key, this.sessionId}) : super(key: key);

// //   @override
// //   _CheckoutPageState createState() => _CheckoutPageState();
// // }

// // class _CheckoutPageState extends State<CheckoutPage> {
// //   WebViewController _webViewController;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       
// //       body: WebView(
// //         initialUrl: initialUrl,
// //         javascriptMode: JavascriptMode.unrestricted,
// //         onWebViewCreated: (webViewController) =>
// //             _webViewController = webViewController,
// //         onPageFinished: (String url) {
// //           if (url == initialUrl) {
// //             _redirectToStripe(widget.sessionId);
// //           }
// //         },
// //         navigationDelegate: (NavigationRequest request) {
// //           if (request.url.startsWith('http://localhost:8080/#/success')) {
// //             Navigator.of(context).pushReplacementNamed('/success');
// //           } else if (request.url.startsWith('http://localhost:8080/#/cancel')) {
// //             Navigator.of(context).pushReplacementNamed('/cancel');
// //           }
// //           return NavigationDecision.navigate;
// //         },
// //       ),
// //     );
// //   }

// //   String get initialUrl => 'https://marcinusx.github.io/test1/index.html';

// //   Future<void> _redirectToStripe(String sessionId) async {
// //     final redirectToCheckoutJs = '''
// // var stripe = Stripe(\'$apiKey\');
    
// // stripe.redirectToCheckout({
// //   sessionId: '$sessionId'
// // }).then(function (result) {
// //   result.error.message = 'Error'
// // });
// // ''';

// //     try {
// //       await _webViewController.evaluateJavascript(redirectToCheckoutJs);
// //     } on PlatformException catch (e) {
// //       if (!e.details.contains(
// //           'JavaScript execution returned a result of an unsupported type')) {
// //         rethrow;
// //       }
// //     }
// //   }
// // }
