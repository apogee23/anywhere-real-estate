// import 'package:auth0_flutter2/auth0_flutter2.dart';
// import 'package:realogy/models/auth0/user_model.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:realogy/main.dart' as app;

// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//   group(
//     'end-to-end test',
//     () {
//       setUpAll(
//         () => app.isRunningIntegrationTests = true,
//       );

//       testWidgets(
//         'tap on the floating action button, verify counter',
//         (tester) async {
//           app.main();

//           print(app.isRunningIntegrationTests);

//           // Wait for the app to start.
//           await tester.pumpAndSettle();

//           // Verify dashboard screen shows up.
//           // expect(find.by('DashboardScreen'), findsOneWidget);

//           // // Verify the counter starts at 0.
//           // expect(find.text('0'), findsOneWidget);

//           // // Finds the floating action button to tap on.
//           // final Finder fab = find.byTooltip('Increment');

//           // // Emulate a tap on the floating action button.
//           // await tester.tap(fab);

//           // Trigger a frame.
//           await tester.pumpAndSettle();

//           // Verify the counter increments by 1.
//           // expect(find.text('1'), findsOneWidget);
//         },
//       );
//     },
//   );
// }
