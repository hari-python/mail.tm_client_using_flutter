  import 'package:flutter/material.dart';
import 'package:mailtm_client/screens/custom/emailavatar.dart';
import 'package:motion_toast/motion_toast.dart';

AppBar myAppBar(BuildContext context) {
    return AppBar(
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
    );
  }
