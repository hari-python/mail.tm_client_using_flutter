import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mailtm_client/API/downloadmail.dart';
import 'package:mailtm_client/logic/routes.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:mailtm_client/logic/smallclasses.dart';

class MailScreen extends StatefulWidget {
late  final TokenID details;
late final Future<Map<String,String>> downloadMail;
   MailScreen({Key? key,required details}) : super(key: key) {
     var thisMail=DownloadMail(id: details.id, token: details.token);
      downloadMail = thisMail.download();
      log(details.toString());
       
   }

  @override
  State<MailScreen> createState() => _MailScreenState();
}

class _MailScreenState extends State<MailScreen> {
  Map<String,String> mailDetails={};

  @override
  Widget build(BuildContext context) {
    
    widget.downloadMail.then((value) {
        mailDetails = value;
        log("done alpha rendering 2000");
        setState(
        (){}
      );
      });
    return Scaffold(
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
            Expanded(
              child: SingleChildScrollView(
                child: HtmlWidget(
                
                 mailDetails.isEmpty ? "Loading" : mailDetails["body"]!,
                 
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
