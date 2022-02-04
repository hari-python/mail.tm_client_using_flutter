import 'dart:developer';
import 'dart:math' hide log;
import 'package:motion_toast/motion_toast.dart';
import 'package:flutter/material.dart';
import '../API/Accounts.dart';

int a = 0;
List<Account>? myAccounts;

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
              children: const[
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
      floatingActionButton: FloatingActionButton(onPressed: () {}),
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
                title: Text("New account"),
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
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
                          50,
                          (index) => EmailListItem(
                            emailAddress: 'sender@example.com',
                            emailBody: 'Email body',
                            emailSubject: "Subject goes here",
                            name: "Sender $index",
                          ),
                        ),
                        const Divider(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {},
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
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const[
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
                          onPressed: () {
                            var newAccount = Account.create(
                                username: username, password: password);
                            myAccounts?.add(newAccount);
                            showLogin = false;
                            setState(
                              () {},
                            );
                          },
                          child: const Text("Create"),
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
                child: Row(
                  children: [
                    EmailAvatar(
                      colour: Colors.green,
                      textString: name[0],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            emailAddress,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              if (MediaQuery.of(context).size.width > 800)
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            emailSubject,
                            overflow: TextOverflow.ellipsis,
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
