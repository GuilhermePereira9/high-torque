import 'package:flutter/material.dart';
import 'package:virtual_store/models/order.dart';

class CancelOrderDialog extends StatelessWidget {
  const CancelOrderDialog(this.order);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Cancelar ${order.formattedId}?'),
      content: const Text('Esta ação não poderá ser defeita!'),
      actions: <Widget>[
        TextButton(
            child: const Text('Cancelar Serviço'),
            onPressed: () {
              order.cancel();
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              primary: Colors.red,
            )),
      ],
    );
  }
}
