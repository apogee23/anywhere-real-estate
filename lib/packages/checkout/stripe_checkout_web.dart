@JS()
library stripe;

import 'package:flutter/material.dart';
import 'package:js/js.dart';

void redirectToCheckout(
  BuildContext _,
  int price,
  Future<void> Function() onComplete,
) async {
  // final stripe = Stripe("pk_test_xC1Nf1Djo2wx3DF72PmBiC5W00bBLUgjpf");
  final stripe = Stripe("pk_live_H293e3qNvoJB8isKoALzyCFs00v6DmDPGg");

  stripe.redirectToCheckout(
    CheckoutOptions(
      lineItems: [
        LineItem(
          price: "price_1M4tESGVYGkmHIWnFbybEAGT",
          quantity: price,
        ),
      ],
      mode: 'payment',
      successUrl: 'http://app.trydownstream.io/checkout/success',
      cancelUrl: 'http://app.trydownstream.io',
    ),
  );
}

@JS()
class Stripe {
  external Stripe(String key);

  external redirectToCheckout(CheckoutOptions options);
}

@JS()
@anonymous
class CheckoutOptions {
  external List<LineItem> get lineItems;

  external String get mode;

  external String get successUrl;

  external String get cancelUrl;

  external factory CheckoutOptions({
    List<LineItem> lineItems,
    String mode,
    String successUrl,
    String cancelUrl,
    String sessionId,
  });
}

@JS()
@anonymous
class LineItem {
  external String get price;

  external int get quantity;

  external factory LineItem({String price, int quantity});
}
