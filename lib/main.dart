import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/models/admin_users_manager.dart';
import 'package:virtual_store/models/cart_manager.dart';
import 'package:virtual_store/models/home_manager.dart';
import 'package:virtual_store/models/product.dart';
import 'package:virtual_store/models/product_manager.dart';
import 'package:virtual_store/models/user_manager.dart';
import 'package:virtual_store/screens/base/base_screen.dart';
import 'package:virtual_store/screens/cart/cart_screen.dart';
import 'package:virtual_store/screens/edit_product/edit_product_screen.dart';
import 'package:virtual_store/screens/login/login_screen.dart';
import 'package:virtual_store/screens/product/product_screen.dart';
import 'package:virtual_store/screens/select_product/select_product_screen.dart';
import 'package:virtual_store/screens/signup/signup_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserManager(),
      lazy: false,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => UserManager(),
            lazy: false,
          ),
          ChangeNotifierProvider(
            create: (_) => ProductManager(),
            lazy: false,
          ),
          ChangeNotifierProvider(
            create: (_) => HomeManager(),
            lazy: false,
          ),
          ChangeNotifierProxyProvider<UserManager, CartManager>(
            create: (_) => CartManager(),
            lazy: false,
            update: (_, userManager, cartManager) =>
                cartManager..updateUser(userManager),
          ),
          ChangeNotifierProxyProvider<UserManager, AdminUserManager>(
            create: (_) => AdminUserManager(),
            lazy: false,
            update: (_, userManager, adminUserManager) =>
                adminUserManager..updateUser(userManager),
          )
        ],
        child: MaterialApp(
          title: 'Violent Store',
          theme: ThemeData(
            //primaryColor: const Color.fromARGB(255, 4, 125, 141),
            primaryColor: const Color.fromARGB(255, 211, 118, 130),
            scaffoldBackgroundColor: const Color.fromARGB(255, 211, 118, 130),
            appBarTheme: const AppBarTheme(elevation: 0),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: '/base',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/login':
                return MaterialPageRoute(builder: (_) => LoginScreen());
              case '/signup':
                return MaterialPageRoute(builder: (_) => SingUpScreen());
              case '/product':
                return MaterialPageRoute(
                    builder: (_) =>
                        ProductScreen(settings.arguments as Product));
              case '/cart':
                return MaterialPageRoute(builder: (_) => CartScreen());
              case '/edit_product':
                return MaterialPageRoute(
                    builder: (_) =>
                        EditProductScreen(settings.arguments as Product));
              case '/select_product':
                return MaterialPageRoute(builder: (_) => SelectProductScreen());
              case '/base':
              default:
                return MaterialPageRoute(builder: (_) => BaseScreen());
            }
          },
        ),
      ),
    );
  }
}
