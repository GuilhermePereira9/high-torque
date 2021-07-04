import 'package:flutter/material.dart';
import 'package:virtual_store/models/order.dart';
import 'package:virtual_store/screens/orders/components/cancel_order_dialog.dart';
import 'package:virtual_store/screens/orders/components/exports_address_dialog.dart';
import 'package:virtual_store/screens/orders/components/order_product_tile.dart';

class OrderTile extends StatelessWidget {
  const OrderTile(this.order, {this.showControls = false});

  final Order order;
  final bool showControls;
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(order.formattedId,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    )),
                Text(
                  'R\$ ${order.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Text(
              order.statusText,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: order.status == Status.canceled
                      ? Colors.red
                      : primaryColor,
                  fontSize: 14),
            ),
          ],
        ),
        children: <Widget>[
          Column(
            children: order.items.map((e) {
              return OrderProductTile(e);
            }).toList(),
          ),
          Text(
            'Ordem de Serviço aberta em: ${order.date.toDate()}',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 12,
            ),
          ),
          if (showControls && order.status != Status.canceled)
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.cancel),
                      color: primaryColor,
                      iconSize: 30,
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => CancelOrderDialog(order));
                      }),
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: primaryColor,
                    iconSize: 30,
                    padding: const EdgeInsets.only(right: 50, left: 50),
                    onPressed: order.back,
                  ),
                  IconButton(
                      icon: Icon(Icons.arrow_forward),
                      color: primaryColor,
                      iconSize: 30,
                      padding: const EdgeInsets.only(right: 50, left: 20),
                      onPressed: order.advance),
                  IconButton(
                      icon: Icon(Icons.home),
                      color: primaryColor,
                      iconSize: 30,
                      padding: const EdgeInsets.only(right: 50, left: 20),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => ExportAddressDialog(order.address));
                      }),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
