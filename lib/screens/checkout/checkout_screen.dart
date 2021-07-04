import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/common/price_card.dart';
import 'package:virtual_store/models/cart_manager.dart';
import 'package:virtual_store/models/checkout_manager.dart';

class CheckOutScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager, CheckOutManager>(
      create: (_) => CheckOutManager(),
      update: (_, cartManager, checkOurManager) =>
          checkOurManager..updateCart(cartManager),
      lazy: false,
      child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: const Text('Pagamento'),
            centerTitle: true,
          ),
          body: Consumer<CheckOutManager>(
            builder: (_, checkOutManager, __) {
              if (checkOutManager.loading) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Processando seu pagamento...',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                );
              }
              return ListView(
                children: <Widget>[
                  PriceCard(
                    buttonText: 'Finalizar Pedido',
                    onPressed: () {
                      checkOutManager.checkOut(onStockFail: (e) {
                        Navigator.of(context).popUntil(
                            (route) => route.settings.name == '/cart');
                      }, onSucess: (order) {
                        Navigator.of(context).popUntil(
                            (route) => route.settings.name == '/base');
                        Navigator.of(context)
                            .pushNamed('/confirmation', arguments: order);
                      });
                    },
                  )
                ],
              );
            },
          )),
    );
  }
}
