class ActivitiesHelpers {
  static String replaceAccent(String value) {
    String newValue = value;

    newValue = newValue.replaceAll('á', 'a');
    newValue = newValue.replaceAll('é', 'e');
    newValue = newValue.replaceAll('í', 'i');
    newValue = newValue.replaceAll('ó', 'o');
    newValue = newValue.replaceAll('u', 'u');

    return newValue;
  }
}
