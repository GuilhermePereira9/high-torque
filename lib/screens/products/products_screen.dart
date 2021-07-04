import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/common/custom_drawer/custom_drawer.dart';
import 'package:virtual_store/models/product_manager.dart';
import 'package:virtual_store/models/user_manager.dart';
import 'package:virtual_store/screens/products/components/product_list_tile.dart';
import 'package:virtual_store/screens/products/components/search_dialog.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Consumer<ProductManager>(
          builder: (_, productManager, __) {
            if (productManager.search.isEmpty) {
              return const Text('Serviços');
            } else {
              return LayoutBuilder(
                builder: (_, constrains) {
                  return GestureDetector(
                    onTap: () async {
                      final search = await showDialog<String>(
                          context: context,
                          builder: (_) => SearchDialog(productManager.search));
                      if (search != null) {
                        productManager.search = search;
                      }
                    },
                    child: Container(
                        width: constrains.biggest.width,
                        child: Text(
                          productManager.search,
                          textAlign: TextAlign.center,
                        )),
                  );
                },
              );
            }
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          Consumer<ProductManager>(builder: (_, productManager, __) {
            if (productManager.search.isEmpty) {
              return IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  final search = await showDialog<String>(
                      context: context,
                      builder: (_) => SearchDialog(
                            productManager.search,
                          ));
                  if (search != null) {
                    productManager.search = search;
                  }
                },
              );
            } else {
              return IconButton(
                icon: Icon(Icons.close),
                onPressed: () async {
                  productManager.search = '';
                },
              );
            }
          }),
          Consumer<UserManager>(
            builder: (_, userManager, __) {
              if (userManager.adminEnable) {
                return IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      '/edit_product',
                    );
                  },
                );
              } else {
                return Container();
              }
            },
          )
        ],
      ),
      body: Consumer<ProductManager>(builder: (_, productManager, __) {
        // ignore: unused_local_variable
        final filteredProducts = productManager.filteredProducts;
        return ListView.builder(
          itemCount: productManager.filteredProducts.length,
          itemBuilder: (_, index) {
            return ProductListTile(productManager.filteredProducts[index]);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).pushNamed('/cart');
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
