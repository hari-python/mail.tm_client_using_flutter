import 'package:mailtm_client/API/Accounts.dart';

class AllAccounts{
  var accounts = <Account>[];
  void add({required String username, required String password,})
  {
    accounts.add(Account.create(username: username, password: password));
  }
  
}