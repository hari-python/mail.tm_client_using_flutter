import 'package:flutter/material.dart';

Drawer myDrawer(BuildContext context,var showLoginFunc,bool showLoginbool) {
    return Drawer(
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
              if (showLoginbool == false) {
                showLoginFunc(true);
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
    );
  }