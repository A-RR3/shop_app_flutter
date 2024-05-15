class AssetsKeys {
  static String getImagePath(String name, {String extension = 'jpg'}) =>
      'assets/$IMAGES/$name.$extension';

  static String getIconPath(String name, {String extension = 'svg'}) =>
      'assets/$ICONS/$name.$extension';

  //SUB PATH KEYS
  static const String IMAGES = 'images';
  static const String ICONS = 'icons';
  static const String FILES = 'files';

  //IMAGES KEYS
  static const String ON_BOARDING_IMG = 'on_boarding';

  //ICON KEYS
}
