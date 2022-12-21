import 'package:flutter/material.dart';
import 'package:fotoporcelana/my_colors.dart';
import 'package:fotoporcelana/pages/cart_page.dart';
import 'package:fotoporcelana/pages/main_page.dart';
import 'package:fotoporcelana/pages/user_page.dart';
import 'package:fotoporcelana/providers/data_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _conditionalWidget(int index) {
    switch (index) {
      case 0:
        return const MainPage();
      case 1:
        return const UserPage();
      case 2:
        return const CartPage();
      default:
        return const MainPage();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void onItemTapped(int index) {
    switch (index) {
      case 0:
        setState(() {
          Provider.of<DataProvider>(context, listen: false).changeIndex(index);
          _conditionalWidget(index);
        });
        break;
      case 1:
        setState(() {
          Provider.of<DataProvider>(context, listen: false).changeIndex(index);
          _conditionalWidget(index);
        });
        break;
      case 2:
        setState(() {
          Provider.of<DataProvider>(context, listen: false).changeIndex(index);
          _conditionalWidget(index);
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<DataProvider>(context);
    dataProvider.setCartItems();
    dataProvider.setClientData();

    int items = dataProvider.getCartItems;
    bool clientData = dataProvider.getClientData;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/logo.png',
          height: 16,
        ),
        backgroundColor: MyColors.accentMaterial,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: MyColors.accentMaterial[500],
        unselectedItemColor: MyColors.mainMaterial[50],
        backgroundColor: MyColors.mainMaterial[600],
        currentIndex: dataProvider.getIndex,
        onTap: onItemTapped,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Strona główna'),
          BottomNavigationBarItem(
              icon: Badge(
                  isLabelVisible: clientData,
                  backgroundColor: Colors.white.withOpacity(0),
                  textColor: Colors.red,
                  label: const Icon(
                    Icons.error,
                    size: 16,
                    color: Colors.red,
                  ),
                  child: const Icon(Icons.person)),
              label: 'Profil użytkownika'),
          BottomNavigationBarItem(
              icon: Badge(
                isLabelVisible: items == 0 ? false : true,
                textColor: Colors.white,
                backgroundColor: const Color(MyColors.secondary),
                label: Text('$items'),
                child: const Icon(
                  Icons.shopping_cart,
                ),
              ),
              label: 'Koszyk'),
        ],
      ),
      body: _conditionalWidget(dataProvider.getIndex),
    );
  }
}
