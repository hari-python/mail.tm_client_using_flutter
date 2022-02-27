import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mailtm_client/values.dart';

class DownloadMail {
  var headers = MyHeaders();
  var downloadedMail= <String,String>{
    "body":"",

  };
  final String id;
  String token;
  DownloadMail({required this.id, required this.token});

  Future<Map<String,String>> download() async {
    headers.getheader["Authorization"] = "Bearer $token";
    var url = 'https://api.mail.tm/messages/$id';

    Response response = await Dio().get(
      url,
      options: Options(headers: headers.getheader),
    );
    downloadedMail["body"]=jsonDecode(response.data)["html"][0];
    return downloadedMail;

  }
}
