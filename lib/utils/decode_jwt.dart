import 'dart:convert';

Map<String, dynamic> decodeJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('Token JWT invalide');
  }

  final payload = parts[1];

  final normalized = base64Url.normalize(payload);
  final decoded = utf8.decode(base64Url.decode(normalized));

  return json.decode(decoded) as Map<String, dynamic>;
}

DateTime jwtTimestampToDate(int seconds) {
  return DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
}

