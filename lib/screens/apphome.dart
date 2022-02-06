import 'dart:developer';
import 'dart:math' hide log;
import 'package:motion_toast/motion_toast.dart';
import 'package:flutter/material.dart';
import '../API/Accounts.dart';

int a = 0;
int currentPage = 0, lastPage = 0;
List<Account> myAccounts = [];
int numberOfMails() {
  return myAccounts.isEmpty ? 0 : myAccounts[0].mails.length;
}

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

  @override
  Widget build(BuildContext context) {
    // Scaffold.of(context).openDrawer();

    log("this is a logged message $a");
    a++;
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {},
            child: const EmailAvatar(
              textString: "LE",
              colour: Colors.black,
            ),
          ),
        ],
        title: TextButton(
            onPressed: () {
              MotionToast(
                      primaryColor: Colors.yellow,
                      icon: Icons.done,
                      title: const Text("Value"),
                      description: const Text("copied to clipboard"),
                      width: 350)
                  .show(context);
            },
            child: Row(
              children: const [
                Icon(
                  Icons.mail_outline,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 7,
                ),
                Text(
                  "example@mail.tm",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            )),
      ),
      drawer: Drawer(
        elevation: 0,
        backgroundColor: Colors.amber,
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text(""),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const ListTile(
                leading: Icon(Icons.inbox_outlined),
                title: Text("Inbox"),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const ListTile(
                leading: Icon(Icons.refresh),
                title: Text("Refresh"),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (showLogin == false) {
                  showLogin = true;
                  setState(() {});
                }
              },
              child: const ListTile(
                leading: Icon(Icons.add),
                title: Text("Login"),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const ListTile(
                leading: Icon(Icons.auto_awesome_sharp),
                title: Text("About"),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.grey[100],
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width > 800 ? 40 : 5,
                vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Inbox",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        ...List.generate(
                          myAccounts.isEmpty ? 0 : myAccounts[0].mails.length,
                          (index) => EmailListItem(
                            emailAddress: myAccounts[0].mails[index]["from"]
                                ["address"],
                            emailBody: myAccounts[0].mails[index]["intro"],
                            emailSubject: myAccounts[0].mails[index]["subject"],
                            name: myAccounts[0].mails[index]["from"]["name"],
                          ),
                        ),
                        const Divider(
                          height: 30,
                        ),
                        if (currentPage != 0)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
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
                                    Text("Previous")
                                  ],
                                ),
                              ),
                              TextButton(
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
                                    Text("Next"),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(Icons.arrow_forward),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
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

String generateRandomString(int len) {
  var r = Random();
  const _chars = 'abcdefghiklmnopqrstuvwxyz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
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

class EmailListItem extends StatelessWidget {
  const EmailListItem({
    Key? key,
    required this.name,
    required this.emailAddress,
    required this.emailBody,
    required this.emailSubject,
  }) : super(key: key);
  final String name, emailAddress, emailBody, emailSubject;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(30),
            backgroundColor: Colors.white,
          ),
          onPressed: () {},
          child: Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    EmailAvatar(
                      colour: Colors.green,
                      textString: name == "" ? "#" : name[0],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.mark_email_read),
                            Container(
                              constraints: BoxConstraints(maxWidth: 200),
                              child: Text(
                                emailAddress + emailSubject,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(),
              if (MediaQuery.of(context).size.width > 800)
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              emailSubject,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              emailBody,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                )
            ],
          ),
        ),
        const Divider(
          height: 2,
          color: Colors.black12,
        ),
      ],
    );
  }
}

class EmailAvatar extends StatelessWidget {
  const EmailAvatar({
    Key? key,
    required this.colour,
    required this.textString,
  }) : super(key: key);
  final Color colour;
  final String textString;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: colour,
      child: Center(
        child: Text(
          textString,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
