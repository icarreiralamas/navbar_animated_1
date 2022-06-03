import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavbarButton {
  final IconData icon;
  final String text;

  NavbarButton({required this.icon, required this.text});
}

class NavbarMenu extends StatelessWidget {
  final bool mostrar;

  final Color? backgroundColor;
  final Color? activeColor;
  final Color? inactiveColor;
  final List<NavbarButton> items;

  NavbarMenu(
      {this.mostrar = true,
      this.backgroundColor = Colors.white,
      this.activeColor = Colors.black,
      this.inactiveColor = Colors.black54,
      required this.items});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => _MenuModel(),
        child: AnimatedOpacity(
            duration: Duration(milliseconds: 250),
            opacity: (mostrar) ? 1 : 0,
            child: Builder(builder: (BuildContext context) {
              Provider.of<_MenuModel>(context).backgroundColor =
                  backgroundColor!;
              Provider.of<_MenuModel>(context).activeColor = this.activeColor!;
              Provider.of<_MenuModel>(context).inactiveColor =
                  this.inactiveColor!;

              return NavbarMenuBackground(child: _MenuItems(menuItems: items));
            })));
  }
}

class NavbarMenuBackground extends StatelessWidget {
  final Widget child;

  const NavbarMenuBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final backgroundColor = Provider.of<_MenuModel>(context).backgroundColor;

    return Container(
      child: child,
      width: screenWidth,
      height: 80,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(20)),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38,
                offset: Offset(10, 10),
                blurRadius: 10,
                spreadRadius: -5)
          ]),
    );
  }
}

class _MenuItems extends StatelessWidget {
  final List<NavbarButton> menuItems;

  const _MenuItems({required this.menuItems});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
          menuItems.length, (i) => _PinterestMenuButton(i, menuItems[i])),
    );
  }
}

class _PinterestMenuButton extends StatefulWidget {
  final int index;
  final NavbarButton item;

  const _PinterestMenuButton(this.index, this.item);

  @override
  State<_PinterestMenuButton> createState() => _PinterestMenuButtonState();
}

class _PinterestMenuButtonState extends State<_PinterestMenuButton> {
  double _width = 0;
  double _heigth = 50;
  Color _color = Color.fromARGB(61, 72, 181, 235);
  bool _valorInicial = true;

  @override
  Widget build(BuildContext context) {
    final itemSeleccionado = Provider.of<_MenuModel>(context).itemSeleccionado;
    final activeColor = Provider.of<_MenuModel>(context).activeColor;
    final inactiveColor = Provider.of<_MenuModel>(context).inactiveColor;

    return GestureDetector(
      onTap: () {
        
         Provider.of<_MenuModel>(context, listen: false).itemSeleccionado =
            widget.index;
        
        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            // Here you can write your code for open new view
            _valorInicial = !_valorInicial;
            
          });
        });
        
        setState(() {
          _valorInicial = !_valorInicial;
        });
      },
      //behavior: HitTestBehavior.translucent,
      child: Container(
        child: (itemSeleccionado == widget.index)
            ? AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                decoration: BoxDecoration(
                    color: _color,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                width: (_valorInicial) ? 130 : 50,
                height: _heigth,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Icon(
                        widget.item.icon,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      if(_valorInicial)
                      Text(
                        widget.item.text,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                      )
                    ],
                  ),
                ),
              )
            : Icon(widget.item.icon),
      ),
    );
  }
}

class _MenuModel with ChangeNotifier {
  int _itemSeleccionado = -1;

  Color _backgroundColor = Colors.white;
  Color _activeColor = Colors.black54;
  Color _inactiveColor = Colors.black54;

  int get itemSeleccionado => this._itemSeleccionado;

  set itemSeleccionado(int index) {
    this._itemSeleccionado = index;
    notifyListeners();
  }

  Color get backgroundColor => this._backgroundColor;

  set backgroundColor(Color value) {
    this._backgroundColor = value;
    //notifyListeners();
  }

  Color get activeColor => this._activeColor;

  set activeColor(Color value) {
    this._activeColor = value;
    //notifyListeners();
  }

  Color get inactiveColor => this._inactiveColor;

  set inactiveColor(Color value) {
    this._inactiveColor = value;
    //notifyListeners();
  }
}
