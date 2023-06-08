class ParserUtil {
  static String clampDigits(String value, [int limit = 7]) {
    try {
      final split = value.split('');
      String result = "";

      final splitLength = split.length;

      int length = 0;
      int index = 0;
      while (length < limit && index <= splitLength - 1) {
        if (int.tryParse(split[index]) != null) {
          length++;
        }
        result += split[index];
        index++;
      }
      return result;
    } catch (e) {
      return value;
    }
  }
}
