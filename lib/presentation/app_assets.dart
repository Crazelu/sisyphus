class AppAssets {
  static String _getAssetPath(String asset) {
    return "assets/icons/$asset.png";
  }

  static String searchIcon = _getAssetPath("search");
  static const String avatar = "assets/icons/avatar.png";
  static String btc = _getAssetPath("btc");
  static String usdt = _getAssetPath("usdt");
  static String clock = _getAssetPath("clock");
  static String expand = _getAssetPath("expand");
  static const String globe = "assets/icons/globe.png";
  static const String lightLogo = "assets/icons/logo_dark.png";
  static const String darkLogo = "assets/icons/logo.png";
  static const String menu = "assets/icons/menu.png";
  static String dropDown = _getAssetPath("drop_down");
  static String dropDownBordered = _getAssetPath("drop_down_bordered");
  static String arrowUp = _getAssetPath("arrow_up");
  static String arrowDown = _getAssetPath("arrow_down");
  static String candleChart = _getAssetPath("candle_chart");
}
