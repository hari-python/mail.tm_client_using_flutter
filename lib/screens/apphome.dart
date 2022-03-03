import 'dart:developer';
import 'package:mailtm_client/API/Accounts.dart';
import 'package:mailtm_client/logic/randomstring.dart';
import 'package:mailtm_client/logic/smallclasses.dart';
import 'package:mailtm_client/screens/custom/appbar.dart';
import 'package:mailtm_client/screens/custom/emailitem.dart';
import 'package:mailtm_client/screens/custom/mydrawer.dart';
import 'package:flutter/material.dart';

int a = 0;
int currentPage = 0, lastPage = 0;
List<Account> myAccounts = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showLogin = false;
  String myVal = "";
  late String username, password;
  TextEditingController? passwordEditingController;
  TextEditingController? usernameEditingController;

  Function showLoginFunc(Function setState) => (bool value) {
        showLogin = value;
        setState(() {});
      };

  @override
  Widget build(BuildContext context) {
    // Scaffold.of(context).openDrawer();

    log("this is a logged message $a");

    a++;
    return Scaffold(
      appBar: myAppBar(context),
      drawer: myDrawer(context, showLoginFunc(setState), showLogin),
      body: Stack(
        children: [
          Container(
            color: Colors.grey[100],
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width > 800 ? 40 : 5,
               5,
                MediaQuery.of(context).size.width > 800 ? 40 : 5,
                5,
                ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Inbox",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      "Page $currentPage",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            var myTokenID = TokenID(
                              token: myAccounts[0].token,
                              id: myAccounts[0].mails[index]["id"],
                            );
                            return EmailListItem(
                              emailAddress: myAccounts[0].mails[index]["from"]
                                  ["address"],
                              emailBody: myAccounts[0].mails[index]["intro"],
                              emailSubject: myAccounts[0].mails[index]
                                  ["subject"],
                              name: myAccounts[0].mails[index]["from"]["name"],
                              details: myTokenID,
                            );
                          },
                          itemCount: myAccounts.isEmpty
                              ? 0
                              : myAccounts[0].mails.length,
                        ),
                      ),
                      const Divider(
                        height: 1,
                      ),
                      if (currentPage != 0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Visibility(
                              visible: currentPage > 1,
                              child: TextButton(
                                onPressed: () async {
                                  if (currentPage > 1) {
                                    currentPage--;
                                    await myAccounts[0]
                                        .getMails(page: currentPage);
                                    setState(() {});
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Icon(Icons.arrow_back),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Previous Page")
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: currentPage < lastPage,
                              child: TextButton(
                                onPressed: () async {
                                  if (currentPage < lastPage) {
                                    currentPage++;
                                    await myAccounts[0]
                                        .getMails(page: currentPage);
                                    setState(() {});
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Text("Next Page"),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(Icons.arrow_forward),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (showLogin)
            Center(
              child: Dialog(
                child: SizedBox(
                  // height: 300,
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Divider(),
                        Form(
                          child: TextFormField(
                            controller: usernameEditingController,
                            decoration: InputDecoration(
                              suffixIcon: TextButton(
                                child: const Icon(Icons.refresh),
                                onPressed: () {
                                  setState(() {
                                    username = generateRandomString(10);
                                    usernameEditingController =
                                        TextEditingController(
                                      text: username,
                                    );
                                  });
                                },
                              ),
                              hintText: "Username",
                              fillColor: Colors.white,
                              prefixIcon: const Icon(Icons.email_outlined),
                            ),
                            onChanged: (value) {
                              username = value;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Form(
                          child: TextFormField(
                            controller: passwordEditingController,
                            decoration: InputDecoration(
                                hintText: "Password",
                                fillColor: Colors.white,
                                prefixIcon: const Icon(Icons.password),
                                suffixIcon: TextButton(
                                  child: const Icon(Icons.refresh),
                                  onPressed: () {
                                    setState(() {
                                      password = generateRandomString(20);
                                      passwordEditingController =
                                          TextEditingController(
                                        text: password,
                                      );
                                    });
                                  },
                                )),
                            onChanged: (value) {
                              password = value;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            currentPage = 1;
                            log(myAccounts.length.toString());
                            var newAccount = Account.create(
                              username: username,
                              password: password,
                            );
                            await newAccount.getDomain();
                            newAccount.createDefaultPayload();
                            // await newAccount.createAccount();
                            await newAccount.getTokenAndId();
                            await newAccount.getMails(page: currentPage);
                            myAccounts.add(newAccount);
                            showLogin = false;
                            lastPage = myAccounts[0].lastPage;
                            setState(
                              () {},
                            );
                            log(myAccounts.toString());
                          },
                          child: const Text("Login"),
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}



// class MyDrawer extends StatelessWidget {
//   const MyDrawer({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       elevation: 0,
//       backgroundColor: Colors.amber,
//       child: ListView(
//         children: [
//           DrawerHeader(
//             child: Text(""),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: ListTile(
//               leading: Icon(Icons.inbox_outlined),
//               title: Text("Inbox"),
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: ListTile(
//               leading: Icon(Icons.refresh),
//               title: Text("Refresh"),
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: ListTile(
//               leading: Icon(Icons.add),
//               title: Text("New account"),
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: ListTile(
//               leading: Icon(Icons.auto_awesome_sharp),
//               title: Text("About"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// 