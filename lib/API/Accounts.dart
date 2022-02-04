import 'dart:developer';

import 'package:dio/dio.dart' as diolib;
import 'dart:convert' as convert;
import 'package:mailtm_client/values.dart';

// import 'package:requests/requests.dart' as re;

class Account {
  late MyUrls myUrls = MyUrls.withoutId(isMailtm: isMailtm);
  final MyHeaders myHeaders = MyHeaders();
  String password, username;
  late String defaultPayload, token, id, domain;
  bool isMailtm;

  Account.existing(
      {required this.username, required this.password, this.isMailtm = true}) {
    createDefaultPayload();
    getTokenAndId();
    myUrls = MyUrls.withId(id: id, isMailtm: isMailtm);
  }

  /// Creates a new account
  /// Do not call create account
  Account.create(
      {required this.username, required this.password, this.isMailtm = true}) {
    initialize();
  }
  initialize() async {
    log("acc 1");
    await getDomain();
    log("Goint to createDefaultPayload();");
    createDefaultPayload();
    await createAccount();
    await getTokenAndId();
  }
  //TODO Create a Random Constructor

  createDefaultPayload() {
    if (!username.contains("@")) {
      username = username + "@" + domain;
    }
    defaultPayload =
        convert.json.encode({'address': username, 'password': password});
  }

  Future createAccount() async {
    diolib.Response response = await diolib.Dio().post(myUrls.accounts,
        options: diolib.Options(headers: myHeaders.postheader),
        data: defaultPayload);
    Map body = convert.jsonDecode(response.data);
    id = body["id"];
    log("Status code is ............. $response.statusCode.toString()");
  }

  // String test() {
  //   return 'worked';
  // }

  Future getDomain() async {
    log("started function");
    diolib.Response response = await diolib.Dio().get(
      myUrls.domain,
      options: diolib.Options(headers: myHeaders.getheader),
    );
    Map data = convert.jsonDecode(response.data);
    domain = data["hydra:member"][0]["domain"];
    log("domain assigned");
  }

  Future getTokenAndId() async {
    diolib.Response response = await diolib.Dio().post(
      myUrls.token,
      data: defaultPayload,
      options: diolib.Options(headers: myHeaders.postheader),
    );
    token = response.data["token"];
    id = response.data["id"];
    myHeaders.getheader["Authorization"] = "Bearer $token";
  }

  Future deleteAccount() async {
    await diolib.Dio().delete(myUrls.deleteAccount);
  }
  // Future info() async {
  //   if (id != "unassigned") {
  //     Map<String, String> header = {'accept': 'application/ld+json'};
  //     String url = "https://api.mail.tm/accounts/" + id;
  //     diolib.Response response =
  //         await diolib.Dio().get(url, options: diolib.Options(headers: header));
  //     return convert.jsonDecode(response.data);
  //   } else {
  //     return false;
  //   }
  // }
}
