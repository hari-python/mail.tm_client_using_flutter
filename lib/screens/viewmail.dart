import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mailtm_client/API/downloadmail.dart';
import 'package:mailtm_client/logic/routes.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:mailtm_client/logic/smallclasses.dart';

class MailScreen extends StatefulWidget {
  late final TokenID details;
  late final Future<MailDetails> downloadMail;
  MailScreen({Key? key, required details}) : super(key: key) {
    var thisMail = DownloadMail(id: details.id, token: details.token);
    downloadMail = thisMail.download();
    log(details.toString());
  }

  @override
  State<MailScreen> createState() => _MailScreenState();
}

class _MailScreenState extends State<MailScreen> {

  late MailDetails mailDetails;
  bool showMail = false;


  @override
  Widget build(BuildContext context) {
    int a = 0;
    try {
      widget.downloadMail.then((value) {
      mailDetails = value;
      showMail = true;
      log("done alpha rendering ${a++}");

      setState(() {});
    });
    } catch (e) {
      log(e.toString());
    }
    
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.grey[100],
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushNamed(RouteGenerator.homePage);
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                      label: const Text("back"))
                ],
                
              ),
              const Divider(),
              if (showMail)
                Expanded(
                  child: SingleChildScrollView(
                    child: HtmlWidget(
                      mailDetails.emailBody,
                      renderMode: RenderMode.column,
                    ),
                  ),
                )
              else
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Lottie.asset("assets/loading-animation.zip"),
                )
            ],
          ),
        ),
      ),
    );
  }
}
