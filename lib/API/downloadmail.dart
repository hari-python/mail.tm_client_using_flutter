import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mailtm_client/logic/smallclasses.dart';
import 'package:mailtm_client/values.dart';

class DownloadMail {
  var headers = MyHeaders();
  
  final String id;
  String token;
  DownloadMail({required this.id, required this.token});

  Future<MailDetails> download() async {
    headers.getheader["Authorization"] = "Bearer $token";
    var url = 'https://api.mail.tm/messages/$id';

    Response response = await Dio().get(
      url,
      options: Options(headers: headers.getheader),
    );
    
    var mailDetails = MailDetails(jsonDecode(response.data));
    

    return mailDetails;

  }
}
