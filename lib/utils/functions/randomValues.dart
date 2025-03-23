import 'dart:math';

String generateRandomString(int len) {
  var r = Random();
  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

String generateRandomInteger(int len) {
  var r = Random();
  var _chars = '1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}