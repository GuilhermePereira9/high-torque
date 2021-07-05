import 'package:flutter/material.dart';
import 'package:virtual_store/models/product.dart';

class ItemDeleteDialog extends StatelessWidget {
  const ItemDeleteDialog(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Deletar ${product.name}?'),
      content: const Text('Esta ação não poderá ser defeita!'),
      actions: <Widget>[
        TextButton(
            child: const Text('Excluir Anuncio'),
            onPressed: () {
              product.delete();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              primary: Colors.red,
            )),
      ],
    );
  }
}
