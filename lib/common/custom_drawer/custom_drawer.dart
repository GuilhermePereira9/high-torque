import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/common/custom_drawer/custom_drawer_header.dart';
import 'package:virtual_store/common/custom_drawer/drawer_tile.dart';
import 'package:virtual_store/models/user_manager.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 142, 142, 142),
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
          ),
          ListView(
            children: <Widget>[
              CustomDrawerHeader(),
              const Divider(),
              DrawerTile(
                iconData: Icons.home,
                title: 'Inicio',
                page: 0,
              ),
              DrawerTile(
                iconData: Icons.list,
                title: 'Serviços',
                page: 1,
              ),
              DrawerTile(
                iconData: Icons.playlist_add_check,
                title: 'Ordens de Serviço',
                page: 2,
              ),
              DrawerTile(
                iconData: Icons.location_on,
                title: 'Lojas',
                page: 3,
              ),
              Consumer<UserManager>(
                builder: (_, userManager, __) {
                  if (userManager.adminEnable) {
                    return Column(
                      children: <Widget>[
                        const Divider(),
                        DrawerTile(
                          iconData: Icons.settings,
                          title: 'Usuarios',
                          page: 4,
                        ),
                        DrawerTile(
                          iconData: Icons.settings,
                          title: 'Serviços',
                          page: 5,
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
