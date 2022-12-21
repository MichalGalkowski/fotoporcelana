import 'package:flutter/material.dart';
import 'package:fotoporcelana/screens/krysztal_screen.dart';
import 'package:fotoporcelana/screens/other_products_screen.dart';
import 'package:fotoporcelana/screens/porcelana_screen.dart';
import 'package:fotoporcelana/widgets/main_button.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(PorcelanaScreen.routeName);
              },
              child: const MainButton('assets/btnPor.jpg', 'DODAJ PORCELANKĘ')),
          InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(KrysztalScreen.routeName);
              },
              child: const MainButton('assets/btnKr.jpg', 'DODAJ KRYSZTAŁ')),
          InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(OtherProductsScreen.routeName);
              },
              child:
                  const MainButton('assets/btnPoz.jpg', 'POZOSTAŁE PRODUKTY')),
        ],
      ),
    );
  }
}
