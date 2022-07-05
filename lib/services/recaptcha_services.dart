import 'package:advance_cyber_security/config/config.dart';
import 'package:advance_cyber_security/model/recaptcha_response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:g_recaptcha_v3/g_recaptcha_v3.dart';
import 'package:http/http.dart' as http;

class RecaptchaService {
  static String _token = '';
  RecaptchaService._();
  static Future<void> initiate() async =>
      await GRecaptchaV3.ready(Config.siteKey);
  static Future<bool> isNotABot() async {
    var verificationResponse = await _getVerificationResponse();
    var _score = verificationResponse?.score ?? 0.7;
    return _score >= 0.5 && _score < 1 ? true : false;
  }

  static Future<RecaptchaResponse> _getVerificationResponse() async {
    _token = await GRecaptchaV3.execute('submit') ?? '';

    RecaptchaResponse _recaptchaResponse;

    if (_token.isNotEmpty) {
      try {
        final _bodyParameters = {
          'secret': Config.secretKey,
          'response': _token,
        };

        var response = await http.post(Config.verificationURL,
            body: _bodyParameters,
            headers: {'Access-Control-Allow-Origin': '*'});

        _recaptchaResponse = RecaptchaResponse.fromJson(response.body);
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return _recaptchaResponse;
  }
}
