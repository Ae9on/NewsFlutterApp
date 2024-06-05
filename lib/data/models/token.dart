class Token {
  String? accessToken;
  String? refreshToken;

  Token({this.accessToken, this.refreshToken});

  Token.fromJson(Map<String, dynamic> json)
      : accessToken = json['token'],
        refreshToken = json['refresh'] ?? '';
}
