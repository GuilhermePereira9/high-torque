import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/common/custom_drawer/custom_drawer.dart';
import 'package:virtual_store/common/empty_card.dart';
import 'package:virtual_store/common/login_card.dart';
import 'package:virtual_store/models/orders_manager.dart';
import 'package:virtual_store/screens/orders/components/order_tile.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Orders de Serviço'),
        centerTitle: true,
      ),
      body: Consumer<OrdersManager>(
        builder: (_, ordersManager, __) {
          if (ordersManager.user == null) {
            return LoginCard();
          }
          if (ordersManager.orders.isEmpty) {
            return EmptyCard(
              title: 'Nenhum Serviço em Aberto!',
              iconData: Icons.miscellaneous_services_rounded,
            );
          }
          return ListView.builder(
              itemCount: ordersManager.orders.length,
              itemBuilder: (_, index) {
                return OrderTile(ordersManager.orders.reversed.toList()[index]);
              });
        },
      ),
    );
  }
}
