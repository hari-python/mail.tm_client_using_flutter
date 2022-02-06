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
  List mails = [];
  late int lastPage;

  Account.existing(
      {required this.username, required this.password, this.isMailtm = true});
  //     {
  //   getDomain().whenComplete(
  //     () {
  //       createDefaultPayload();
  //       getTokenAndId().whenComplete(
  //         () {
  //           myUrls = MyUrls.withId(id: id, isMailtm: isMailtm);
  //           getMails();
  //         },
  //       );
  //     },
  //   );
  // }

  /// Creates a new account
  /// Do not call create account
  Account.create(
      {required this.username, required this.password, this.isMailtm = true});
  //     {
  //   getDomain().whenComplete(
  //     () {
  //       createDefaultPayload();
  //       createAccount().whenComplete(
  //         () {
  //           getTokenAndId().whenComplete(
  //             () {
  //               myUrls = MyUrls.withId(id: id, isMailtm: isMailtm);
  //             },
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  createDefaultPayload({then}) {
    log("createDefaultPayload");
    if (!username.contains("@")) {
      username = username + "@" + domain;
    }
    defaultPayload =
        convert.json.encode({'address': username, 'password': password});
    if (then != null) {
      then();
    }
  }

  Future createAccount({then}) async {
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
    if (then != null) {
      then();
    }
  }

  // String test() {
  //   return 'worked';
  // }

  Future getDomain({then}) async {
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
    if (then != null) {
      then();
    }
  }

  Future getTokenAndId({then}) async {
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
    if (then != null) {
      then();
    }
  }

  Future deleteAccount({then}) async {
    log("deleteAccounts");
    await diolib.Dio().delete(
      myUrls.deleteAccount,
    );
    if (then != null) {
      then();
    }
  }

  Future getMails({required int page, then}) async {
    log("getmails");
    log(myHeaders.getheader.toString());
    diolib.Response response = await diolib.Dio().get(
      myUrls.messages + "?page=$page",
      options: diolib.Options(
        headers: myHeaders.getheader,
      ),
    );
    log(response.data);
    mails = convert.jsonDecode(response.data)["hydra:member"];
    String lastPageUrl =
        convert.jsonDecode(response.data)["hydra:view"]["hydra:last"];
    lastPage = int.parse(lastPageUrl[lastPageUrl.length - 1]);

    if (then != null) {
      then();
    }
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
