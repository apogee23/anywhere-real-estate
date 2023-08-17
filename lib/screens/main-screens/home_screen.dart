import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:realogy/colors/custom_colors.dart';
import 'package:realogy/providers/providers.dart';
import 'package:realogy/screens/main-screens/container_screen.dart';

bool _initialUriIsHandled = false;

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    super.key,
    this.selectedScreen,
  });

  final int? selectedScreen;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Uri? _initialUri;
  Uri? _latestUri;
  Object? _err;

  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    ref.read(dataProvider).getData();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  WidgetBuilder builder = buildProgressIndicator;

  void showRateDialog(BuildContext context, RateMyApp rateMyApp) {
    rateMyApp.showRateDialog(
      context,
      title: 'Rate this app', // The dialog title.
      message:
          'If you like this app, please take a little bit of your time to review it !\nIt really helps us and it shouldn\'t take you more than one minute.', // The dialog message.
      rateButton: 'RATE', // The dialog "rate" button text.
      noButton: 'NO THANKS', // The dialog "no" button text.
      laterButton: 'MAYBE LATER', // The dialog "later" button text.
      listener: (button) {
        // The button click listener (useful if you want to cancel the click event).
        switch (button) {
          case RateMyAppDialogButton.rate:
            print('Clicked on "Rate".');
            break;
          case RateMyAppDialogButton.later:
            print('Clicked on "Later".');
            break;
          case RateMyAppDialogButton.no:
            print('Clicked on "No".');
            break;
        }

        return true; // Return false if you want to cancel the click event.
      },
      ignoreNativeDialog: Platform
          .isAndroid, // Set to false if you want to show the Apple's native app rating dialog on iOS or Google's native app rating dialog (depends on the current Platform).
      dialogStyle: const DialogStyle(), // Custom dialog styles.
      onDismissed: () => rateMyApp.callEvent(RateMyAppEventType
          .laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
      // contentBuilder: (context, defaultContent) => content, // This one allows you to change the default dialog content.
      // actionsBuilder: (context) => [], // This one allows you to use your own buttons.
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: ContainerScreen(
        selectedScreen: widget.selectedScreen,
      ),
    );
  }

  // /// Builds the progress indicator, allowing to wait for Rate my app to initialize.
  static Widget buildProgressIndicator(BuildContext context) => const Center(
        child: CircularProgressIndicator(
          color: CustomColors.primary,
        ),
      );
}

class HomeScreenContainer extends ConsumerStatefulWidget {
  const HomeScreenContainer({
    super.key,
  });

  @override
  ConsumerState<HomeScreenContainer> createState() =>
      _HomeScreenContainerState();
}

class _HomeScreenContainerState extends ConsumerState<HomeScreenContainer> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  BranchContentMetaData metadata = BranchContentMetaData();
  BranchUniversalObject? buo;
  BranchLinkProperties lp = BranchLinkProperties();
  BranchEvent? eventStandard;
  BranchEvent? eventCustom;

  StreamSubscription<Map>? streamSubscription;
  StreamController<String> controllerData = StreamController<String>();
  StreamController<String> controllerInitSession = StreamController<String>();

  @override
  void initState() {
    super.initState();

    listenDynamicLinks();

    initDeepLinkData();

    FlutterBranchSdk.setIdentity('branch_user_test');

    // requestATTTracking();
  }

  @override
  void dispose() {
    super.dispose();
    controllerData.close();
    controllerInitSession.close();
    streamSubscription?.cancel();
  }

  void requestATTTracking() async {
    AppTrackingStatus status;
    status = await FlutterBranchSdk.requestTrackingAuthorization();
    if (kDebugMode) {
      print(status);
    }

    status = await FlutterBranchSdk.getTrackingAuthorizationStatus();
    if (kDebugMode) {
      print(status);
    }

    final uuid = await FlutterBranchSdk.getAdvertisingIdentifier();
    if (kDebugMode) {
      print(uuid);
    }
  }

  void listenDynamicLinks() async {
    streamSubscription = FlutterBranchSdk.initSession().listen((data) {
      print('listenDynamicLinks - DeepLink Data: $data');
      controllerData.sink.add((data.toString()));
      if (data.containsKey('+clicked_branch_link') &&
          data['+clicked_branch_link'] == true) {
        print(
            '------------------------------------Link clicked----------------------------------------------');
        print('Custom string: ${data['custom_string']}');
        print('Custom number: ${data['custom_number']}');
        print('Custom bool: ${data['custom_bool']}');
        print('Custom list number: ${data['custom_list_number']}');
        print(
            '------------------------------------------------------------------------------------------------');
        showSnackBar(
            message: 'Link clicked: Custom string - ${data['custom_string']}',
            duration: 10);
      }
    }, onError: (error) {
      print('InitSesseion error: ${error.toString()}');
    });
  }

  void initDeepLinkData() {
    metadata = BranchContentMetaData()
      ..addCustomMetadata('custom_string', 'abcd')
      ..addCustomMetadata('custom_number', 12345)
      ..addCustomMetadata('custom_bool', true)
      ..addCustomMetadata('custom_list_number', [1, 2, 3, 4, 5])
      ..addCustomMetadata('custom_list_string', ['a', 'b', 'c'])
      //--optional Custom Metadata
      ..contentSchema = BranchContentSchema.COMMERCE_PRODUCT
      ..price = 50.99
      ..currencyType = BranchCurrencyType.BRL
      ..quantity = 50
      ..sku = 'sku'
      ..productName = 'productName'
      ..productBrand = 'productBrand'
      ..productCategory = BranchProductCategory.ELECTRONICS
      ..productVariant = 'productVariant'
      ..condition = BranchCondition.NEW
      ..rating = 100
      ..ratingAverage = 50
      ..ratingMax = 100
      ..ratingCount = 2
      ..setAddress(
          street: 'street',
          city: 'city',
          region: 'ES',
          country: 'Brazil',
          postalCode: '99999-987')
      ..setLocation(31.4521685, -114.7352207);

    buo = BranchUniversalObject(
        canonicalIdentifier: 'flutter/branch',
        //parameter canonicalUrl
        //If your content lives both on the web and in the app, make sure you set its canonical URL
        // (i.e. the URL of this piece of content on the web) when building any BUO.
        // By doing so, we’ll attribute clicks on the links that you generate back to their original web page,
        // even if the user goes to the app instead of your website! This will help your SEO efforts.
        canonicalUrl: 'https://flutter.dev',
        title: 'Flutter Branch Plugin',
        imageUrl: "https://i.imgur.com/nqBnLLE.gif",
        contentDescription: 'Flutter Branch Description',
        /*
        contentMetadata: BranchContentMetaData()
          ..addCustomMetadata('custom_string', 'abc')
          ..addCustomMetadata('custom_number', 12345)
          ..addCustomMetadata('custom_bool', true)
          ..addCustomMetadata('custom_list_number', [1, 2, 3, 4, 5])
          ..addCustomMetadata('custom_list_string', ['a', 'b', 'c']),
         */
        contentMetadata: metadata,
        keywords: ['Plugin', 'Branch', 'Flutter'],
        publiclyIndex: true,
        locallyIndex: true,
        expirationDateInMilliSec: DateTime.now()
            .add(const Duration(days: 365))
            .millisecondsSinceEpoch);

    lp = BranchLinkProperties(
        channel: 'facebook',
        feature: 'sharing',
        //parameter alias
        //Instead of our standard encoded short url, you can specify the vanity alias.
        // For example, instead of a random string of characters/integers, you can set the vanity alias as *.app.link/devonaustin.
        // Aliases are enforced to be unique** and immutable per domain, and per link - they cannot be reused unless deleted.
        //alias: 'https://branch.io' //define link url,
        stage: 'new share',
        campaign: 'campaign',
        tags: ['one', 'two', 'three'])
      ..addControlParam('\$uri_redirect_mode', '1')
      ..addControlParam('\$ios_nativelink', true)
      ..addControlParam('\$match_duration', 7200)
      ..addControlParam('\$always_deeplink', true)
      ..addControlParam('\$android_redirect_timeout', 750)
      ..addControlParam('referring_user_id', 'user_id');

    eventStandard = BranchEvent.standardEvent(BranchStandardEvent.ADD_TO_CART)
      //--optional Event data
      ..transactionID = '12344555'
      ..currency = BranchCurrencyType.BRL
      ..revenue = 1.5
      ..shipping = 10.2
      ..tax = 12.3
      ..coupon = 'test_coupon'
      ..affiliation = 'test_affiliation'
      ..eventDescription = 'Event_description'
      ..searchQuery = 'item 123'
      ..adType = BranchEventAdType.BANNER
      ..addCustomData(
          'Custom_Event_Property_Key1', 'Custom_Event_Property_val1')
      ..addCustomData(
          'Custom_Event_Property_Key2', 'Custom_Event_Property_val2');

    eventCustom = BranchEvent.customEvent('Custom_event')
      ..addCustomData(
          'Custom_Event_Property_Key1', 'Custom_Event_Property_val1')
      ..addCustomData(
          'Custom_Event_Property_Key2', 'Custom_Event_Property_val2');
  }

  void showSnackBar({required String message, int duration = 1}) {
    scaffoldMessengerKey.currentState!.removeCurrentSnackBar();
    scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: duration),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var dataState = ref.watch(dataProvider);

    return dataState.data == null
        ? Center(
            child: Image.network(
              'https://i.imgur.com/nqBnLLE.gif',
              height: 200,
              width: 200,
            ),
          )
        : const HomeScreen();
  }
}
