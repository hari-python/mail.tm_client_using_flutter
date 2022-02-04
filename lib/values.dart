// Request urls
class MyUrls {
  MyUrls.withId({required String id, required this.isMailtm}) {
    isMailtm
        ? createVariablesWithId(mailTm, id)
        : createVariablesWithId(mailGw, id);
  }

  ///
  /// Creates Essential variables without the need of Id.
  /// Required for initializing my urls even before getting ID
  /// by calling API
  MyUrls.withoutId({required this.isMailtm}) {
    isMailtm
        ? createVariablesWithoutId(mailTm)
        : createVariablesWithoutId(mailGw);
  }
  final bool isMailtm;
  static const String mailTm = "https://api.mail.tm/";
  static const String mailGw = "https://api.mail.gw/";
  late final String accounts,
      domain,
      token,
      usedSpace,
      messages,
      deleteAccount,
      deleteMail,
      downloadMail,
      sources;

  createVariablesWithoutId(String server) {
    domain = server + "domains";
    token = server + "token";
    accounts = server + "accounts";
  }

  createVariablesWithId(String server, String id) {
    createVariablesWithoutId(server);
    usedSpace = server + "me";
    messages = server + "messages";
    deleteAccount = "$accounts/$id";
    sources = "$server/sources/$id";
  }
}

class MailUrls {
  static const String mailTm = "https://api.mail.tm";
  static const String mailGw = "https://api.mail.gw";
  late final String deleteMail, downloadMail;
  MailUrls({required String id, required bool isMailtm}) {
    isMailtm ? createVariables(mailTm, id) : createVariables(mailGw, id);
  }
  createVariables(String server, String id) {
    deleteMail = "$server/messages/$id";
    downloadMail = "$server/messages/$id";
  }
}

class MyHeaders {
  final Map<String, String> getheader = {'accept': 'application/ld+json'};
  final Map<String, String> postheader = {
    'Content-Type': 'application/ld+json',
    'accept': 'application/ld+json'
  };
  // final Map<String, String> tokenheader = {
  //   'Content-Type': 'application/json',
  //   'accept': 'application/json'
  // };
}
