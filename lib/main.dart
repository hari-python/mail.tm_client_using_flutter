import 'package:flutter/material.dart';
import 'package:mailtm_client/API/allaccount.dart';
import 'package:mailtm_client/logic/routes.dart';

import 'package:mailtm_client/screens/apphome.dart';
// import 'API/Accounts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return  MaterialApp(
      initialRoute: RouteGenerator.homePage,
      onGenerateRoute: RouteGenerator.generateRoute,
      home: MotherWidget(child: const HomeScreen()),
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      showSemanticsDebugger: false,
    );
  }
}
class MotherWidget extends InheritedWidget {  

  MotherWidget({Key? key,required Widget child}) : super(child: child,key: key);
  final AllAccounts account = AllAccounts();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) =>true;
  static MotherWidget of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<MotherWidget>()!;
    }

}