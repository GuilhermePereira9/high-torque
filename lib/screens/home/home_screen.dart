import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/common/custom_drawer/custom_drawer.dart';
import 'package:virtual_store/models/home_manager.dart';
import 'package:virtual_store/models/user_manager.dart';
import 'package:virtual_store/screens/home/components/add_section_widget.dart';
import 'package:virtual_store/screens/home/components/section_list.dart';
import 'package:virtual_store/screens/home/components/section_staggered.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 142, 142, 142),
                Color.fromARGB(255, 184, 184, 184)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                snap: true,
                floating: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                flexibleSpace: const FlexibleSpaceBar(
                  title: Text('High Torque'),
                  centerTitle: true,
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    color: Colors.white,
                    onPressed: () => Navigator.of(context).pushNamed('/cart'),
                  ),
                  Consumer2<UserManager, HomeManager>(
                      builder: (_, userManager, homeManager, __) {
                    if (userManager.adminEnable && !homeManager.loading) {
                      if (homeManager.editing) {
                        return PopupMenuButton(
                          onSelected: (e) {
                            if (e == 'Salvar') {
                              homeManager.saveEditing();
                            } else {
                              homeManager.discartEditing();
                            }
                          },
                          itemBuilder: (_) {
                            return ['Salvar', 'Descartar'].map((e) {
                              return PopupMenuItem(
                                value: e,
                                child: Text(e),
                              );
                            }).toList();
                          },
                        );
                      } else {
                        return IconButton(
                          onPressed: homeManager.enterEditing,
                          icon: Icon(Icons.edit),
                        );
                      }
                    } else
                      return Container();
                  })
                ],
              ),
              Consumer<HomeManager>(builder: (_, homeManager, __) {
                if (homeManager.loading) {
                  return SliverToBoxAdapter(
                    child: LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                      backgroundColor: Colors.transparent,
                    ),
                  );
                }

                final List<Widget> children =
                    homeManager.sections.map<Widget>((section) {
                  switch (section.type) {
                    case 'List':
                      return SectionList(section);
                    case 'Staggered':
                      return SectionStaggered(section);
                    default:
                      return Container();
                  }
                }).toList();

                if (homeManager.editing)
                  children.add(AddSectionWidget(homeManager));

                return SliverList(
                  delegate: SliverChildListDelegate(children),
                );
              })
            ],
          ),
        ],
      ),
    );
  }
}
