import 'dart:math' show Random;

String generateRandomString(int len) {
  var r = Random();
  const _chars = 'abcdefghiklmnopqrstuvwxyz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}