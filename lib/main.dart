import 'dart:async';
import 'package:realogy/screens/main-screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'dart:io' show Platform, SecurityContext;
import 'package:realogy/colors/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intercom_flutter/intercom_flutter.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'firebase_options.dart';
import 'providers/providers.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Request ATT tracking on iOS.
  if (!kIsWeb && Platform.isIOS) {
    await AppTrackingTransparency.requestTrackingAuthorization();
  }

  // Initialize Unity Ads.
  if (!kIsWeb) {
    await UnityAds.init(
      gameId: Platform.isAndroid ? "5182277" : "5182276",
      onComplete: () => print('Initialization Complete'),
      onFailed: (error, message) =>
          print('Initialization Failed: $error $message'),
    );
  }

  // Initalize Push Notifications.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  // Handle background Push Notifications.
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Manually add SSL certificate to the trusted certificates.
  try {
    ByteData data = await PlatformAssetBundle().load(
      'assets/ca/auth-encrypt-r3.pem',
    );
    SecurityContext.defaultContext.setTrustedCertificatesBytes(
      data.buffer.asUint8List(),
    );
  } catch (e) {
    print(e);
  }

  // Initialize In-app Purchases.
  if (!kIsWeb) {
    await initInAppPayments();
  }

  // Initalize Translation.
  await EasyLocalization.ensureInitialized();

  // Initialize the Intercom. Ignore failed initialization.
  try {
    await Intercom.instance.initialize(
      'yx6i3vay',
      iosApiKey: 'ios_sdk-fe118087e9d0ae081cf7ca8e986f4c2e98fe3c30',
      androidApiKey: 'android_sdk-0615ba21140c4891986c9bd92e1a11db39d91c9c',
    );
  } catch (e) {
    print(e);
  }

  // Save logged in user, if not already.
  // try {
  //   // Migrate user, if needed.
  //   await getData(
  //     authority: Globals.API_URL,
  //     endpoint: "api/migrate/$userId",
  //   );
  // } catch (e) {
  //   print(e);
  // }

  // Get user (if logged in) and save FCM token.
  // UserModel? user;
  // if (userId != null) {
  //   try {
  //     user = await UserModel.read(userId);
  //     user.fcmToken = await FirebaseMessaging.instance.getToken();
  //     await user.save();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Migrate data from Auth0, if needed.
  // This also creates a User if one does not exist.
  // try {
  //   await getData(
  //     authority: Globals.API_URL,
  //     endpoint: "api/migrate/${user?.userId}",
  //   );
  // } catch (ex) {
  //   print(ex);
  // }

  var startLocale = const Locale('en');

  // Login to RevenueCat.
  // try {
  //   if (user?.userId != null) {
  //     await Purchases.logIn(user!.userId!);
  //     await Purchases.collectDeviceIdentifiers();
  //   }
  // } catch (e) {
  //   print(e);
  // }

  // Auth0Flutter2.instance.logoutUser();

  // Initialize Branch.io.
  // try {
  //   FlutterBranchSdk.setIdentity(user!.userId!);
  // } catch (e) {
  //   print(e);
  // }

  // Login to Intercom.
  // try {
  //   if (user?.userId != null) {
  //     await loginToIntercom(user?.userId);
  //     await updateIntercom(user);
  //   }
  // } catch (e) {
  //   print(e);
  // }

  // Initial locale.
  // startLocale = user?.language != null
  //     ? Locale(
  //         user!.language!,
  //       )
  //     : const Locale('en');

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('es'),
          Locale('fr'),
          Locale('ja'),
          Locale('nl'),
          Locale('it'),
          Locale('de'),
          Locale('pt'),
        ],
        path: 'assets/translations',
        startLocale: startLocale,
        fallbackLocale: const Locale('en'),
        useOnlyLangCode: true,
        errorWidget: (e) => Text('Error${e?.stackTrace.toString()}'),
        child: const MyApp(),
      ),
    ),
  );
}

Future<void> loginToIntercom(String? userId) async {
  try {
    await Intercom.instance.loginIdentifiedUser(
      userId: userId,
    );
  } catch (e) {
    print("No chat available");
  }
}

Future<void> initInAppPayments() async {
  // await Purchases.setDebugLogsEnabled(true);
  // Do nothing if web.
  if (kIsWeb) {
    return;
  }

  if (!kIsWeb && Platform.isAndroid) {
    PurchasesConfiguration configuration = PurchasesConfiguration(
      "goog_uFIIMIjMMDRCrsDkaOIVBFaZOiR",
    );
    await Purchases.configure(configuration);
  } else if (!kIsWeb && Platform.isIOS) {
    PurchasesConfiguration configuration = PurchasesConfiguration(
      "appl_PGFAtHHqrhESJfxUGXjlezHFhCF",
    );
    await Purchases.configure(configuration);
  }
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  var rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 3,
    minLaunches: 3,
    remindDays: 10,
    remindLaunches: 10,
    googlePlayIdentifier: 'com.realogy.realogy',
    appStoreIdentifier: '1666054405',
  );

  @override
  void initState() {
    super.initState();

    // Initialize user provider.
    // ref.read(userProvider).refreshUserState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await rateMyApp.init();
      if (mounted) {
        //rateMyApp.shouldOpenDialog) {
        rateMyApp.showRateDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var dataState = ref.watch(dataProvider);

    Widget getHomeScreen() {
      return const HomeScreenContainer();
      // if (userState.isLoggedIn) {
      //   return const HomeScreenContainer();
      // } else if (userState.hasFetchedUser) {
      //   return const LoginScreen();
      // } else {
      //   return Center(
      //     child: Image.network(
      //       'https://i.imgur.com/nqBnLLE.gif',
      //       height: 200,
      //       width: 200,
      //     ),
      //   );
      // }
    }

    return ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      defaultThemeId: "light",
      themes: <AppTheme>[
        AppTheme(
          data: ThemeData.light().copyWith(
            backgroundColor: Colors.white,
            primaryColor: CustomColors.primary,
          ),
          id: "light",
          description: "Light Mode",
        ),
        AppTheme(
          data: ThemeData.dark().copyWith(
            backgroundColor: Colors.black,
            primaryColor: CustomColors.primary,
            bottomAppBarColor: Colors.black,
          ),
          id: "dark",
          description: "Dark Mode",
        ),
      ],
      child: ThemeConsumer(
        child: Builder(
          builder: (themeContext) => MaterialApp(
            title: 'Realogy',
            theme: ThemeProvider.themeOf(themeContext).data,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: getHomeScreen(),
          ),
        ),
      ),
    );
  }
}
