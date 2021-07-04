import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/models/cart_manager.dart';
import 'package:virtual_store/models/product.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:virtual_store/models/user_manager.dart';
import 'package:virtual_store/screens/product/components/size_widget.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.name),
          centerTitle: true,
          actions: <Widget>[
            Consumer<UserManager>(
              builder: (_, userManager, __) {
                if (userManager.adminEnable && !product.deleted) {
                  return IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(
                          '/edit_product',
                          arguments: product);
                    },
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Carousel(
                images: product.images.map((url) {
                  return NetworkImage(url);
                }).toList(),
                dotSize: 4,
                dotSpacing: 15,
                dotBgColor: Colors.transparent,
                dotColor: Theme.of(context).primaryColor,
                autoplay: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  if (product.hasStock)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'A partir de',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    )
                  else ...{
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8),
                      child: Text(
                        'Indisponivel',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.red),
                      ),
                    ),
                  },
                  Text(
                    'R\$ ${product.basePrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      'Descrição',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  if (product.deleted)
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8),
                      child: Text(
                        'Indisponivel',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.red),
                      ),
                    )
                  else ...{
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Text(
                        'Tipo',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 10,
                      children: product.sizes.map((s) {
                        return SizeWidget(size: s);
                      }).toList(),
                    ),
                  },
                  const SizedBox(
                    height: 20,
                  ),
                  if (product.hasStock)
                    Consumer2<UserManager, Product>(
                      builder: (_, userManager, product, __) {
                        return SizedBox(
                          height: 44,
                          child: ElevatedButton(
                            onPressed: product.selectedSize != null
                                ? () {
                                    if (userManager.isLoggedIn) {
                                      context
                                          .read<CartManager>()
                                          .addToCart(product);
                                      Navigator.of(context).pushNamed('/cart');
                                    } else {
                                      Navigator.of(context).pushNamed('/login');
                                    }
                                  }
                                : null,
                            child: Text(
                              userManager.isLoggedIn
                                  ? 'Adicionar ao Carrinho'
                                  : 'Entre para Continuar',
                              style: const TextStyle(fontSize: 18),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                                onSurface: Theme.of(context)
                                    .primaryColor
                                    .withAlpha(100)),
                          ),
                        );
                      },
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
