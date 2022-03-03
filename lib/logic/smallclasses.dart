class TokenID {
  final String token, id;

  TokenID({required this.token, required this.id});
  @override
  String toString() {
    return "ID is $id Token is $token";
  }
}

class MailDetails {
  late  String sender, senderName, subject, emailBody;
  Map response;
  late  bool isRead;

  MailDetails(this.response) {
    emailBody = response["html"][0];
    sender = response["from"]["address"];
    subject=response["subject"];
    isRead = response["seen"]=="true";
  }
}
