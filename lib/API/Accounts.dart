import 'dart:developer';
import 'package:dio/dio.dart' as diolib;
import 'dart:convert' as convert;
import 'package:mailtm_client/values.dart';

class Account {
  late MyUrls myUrls = MyUrls.withoutId(isMailtm: isMailtm);
  final MyHeaders myHeaders = MyHeaders();
  String password, username;
  late String defaultPayload, token, id, domain;
  bool isMailtm;
  List mails = [];
  late int lastPage;

  Account({required this.username, required this.password, this.isMailtm = true});

  Account.existing(
      {required this.username, required this.password, this.isMailtm = true});

  Account.create(
      {required this.username, required this.password, this.isMailtm = true});
 
  createDefaultPayload() {
    log("createDefaultPayload");
    if (!username.contains("@")) {
      username = username + "@" + domain;
    }
    defaultPayload =
        convert.json.encode({'address': username, 'password': password});
   
  }

  Future createAccount() async {
    log("createAccount");
    diolib.Response response = await diolib.Dio().post(
      myUrls.accounts,
      options: diolib.Options(
        headers: myHeaders.postheader,
      ),
      data: defaultPayload,
    );
    Map body = convert.jsonDecode(response.data);
    id = body["id"];
   
  }

  Future getDomain() async {
    log("beta");
    diolib.Response response = await diolib.Dio().get(
      myUrls.domain,
      options: diolib.Options(
        headers: myHeaders.getheader,
      ),
    );
    Map data = convert.jsonDecode(response.data);
    domain = data["hydra:member"][0]["domain"];
    log("domain assigned");
   
  }

  Future getTokenAndId() async {
    log("getID token");
    diolib.Response response = await diolib.Dio().post(
      myUrls.token,
      data: defaultPayload,
      options: diolib.Options(
        headers: myHeaders.postheader,
      ),
    );
    token = response.data["token"];
    id = response.data["id"];
    myHeaders.getheader["Authorization"] = "Bearer $token";
    
  }

  Future deleteAccount() async {
    log("deleteAccounts");
    await diolib.Dio().delete(
      myUrls.deleteAccount,
    );
    
  }

  Future getMails({required int page}) async {
    log("getmails");
    log(myHeaders.getheader.toString());
    diolib.Response response = await diolib.Dio().get(
      myUrls.messages + "?page=$page",
      options: diolib.Options(
        headers: myHeaders.getheader,
      ),
    );
    mails = convert.jsonDecode(response.data)["hydra:member"];
    String lastPageUrl =
        convert.jsonDecode(response.data)["hydra:view"]["hydra:last"];
    lastPage = int.parse(lastPageUrl[lastPageUrl.length - 1]);

  
  }

  // Future getAllMails() async {
  //   do {
  //     getMails();
  //   } while (false);

  // } // Future info() async {
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
