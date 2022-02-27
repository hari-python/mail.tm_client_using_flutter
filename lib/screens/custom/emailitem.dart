import 'package:flutter/material.dart';
import 'package:mailtm_client/screens/custom/emailavatar.dart';

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