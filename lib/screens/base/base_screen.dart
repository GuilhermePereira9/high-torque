import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/models/page_manager.dart';
import 'package:virtual_store/models/user_manager.dart';
import 'package:virtual_store/screens/admin_users/admin_users_screen.dart';
import 'package:virtual_store/screens/home/home_screen.dart';
import 'package:virtual_store/screens/products/products_screen.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomeScreen(),
              ProductsScreen(),
              if (userManager.adminEnable) ...[
                AdminUserScreen(),
              ]
            ],
          );
        },
      ),
    );
  }
}
