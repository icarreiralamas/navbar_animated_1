import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../widgets/navbar.dart';

class NavbarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _MenuModel(),
      child: Scaffold(
        backgroundColor: Color.fromARGB(207, 92, 151, 255),
        body: Stack(
          children: [_PinterestMenuLocation()],
        ),
      ),
    );
  }
}

class _PinterestMenuLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final mostrar = Provider.of<_MenuModel>(context).mostrar;

    return Positioned(
      bottom: 0,
      child: Container(
        width: width,
        child: Align(
          child: NavbarMenu(
            mostrar: mostrar,
            //backgroundColor: Colors.green,
            //activeColor: Colors.white,
            //inactiveColor: Colors.grey,
            items: [
              NavbarButton(icon: Icons.home, text: 'Home'),
              NavbarButton(
                  icon: Icons.search, text: 'Search'),
              NavbarButton(
                  icon: Icons.chat_sharp, text: 'Chat'),
              NavbarButton(
                  icon: Icons.person, text: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuModel with ChangeNotifier {
  bool _mostrar = true;

  bool get mostrar => this._mostrar;

  set mostrar(bool valor) {
    this._mostrar = valor;
    notifyListeners();
  }
}
