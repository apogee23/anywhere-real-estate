enum Flavor {
  simpsons,
  wire,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get apiQuery {
    switch (appFlavor) {
      case Flavor.simpsons:
        return 'simpsons';
      case Flavor.wire:
        return 'the+wire';
      default:
        return '';
    }
  }
}
