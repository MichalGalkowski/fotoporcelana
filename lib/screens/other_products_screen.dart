import 'package:flutter/material.dart';
import 'package:fotoporcelana/models/other_product.dart';
import 'package:fotoporcelana/my_colors.dart';
import 'package:fotoporcelana/my_lists.dart';
import 'package:fotoporcelana/providers/data_provider.dart';
import 'package:provider/provider.dart';

class OtherProductsScreen extends StatefulWidget {
  static const routeName = '/pozostale';
  const OtherProductsScreen({super.key});

  @override
  State<OtherProductsScreen> createState() => _OtherProductsScreenState();
}

class _OtherProductsScreenState extends State<OtherProductsScreen> {
  late List<OtherProduct> otherProducts = MyLists().otherProducts;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
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
      body: SafeArea(
          child: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : otherProducts.isEmpty
                ? const Text('Brak produktów')
                : buildOtherProducts(),
      )),
    );
  }

  Widget buildOtherProducts() {
    return ListView.builder(
        itemCount: otherProducts.length,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                children: [
                  Container(
                      color: MyColors.mainMaterial[500],
                      child: Row(
                        children: [
                          Flexible(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              otherProducts[index].title.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          )),
                        ],
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(otherProducts[index].data.toString()),
                          )),
                      Flexible(
                          flex: 1,
                          child: IconButton(
                            onPressed: () {
                              modalAddProduct(context, otherProducts[index]);
                            },
                            icon: const Icon(Icons.add_shopping_cart),
                            color: MyColors.accentMaterial,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          );
        }));
  }

  void modalAddProduct(BuildContext context, OtherProduct product) {
    showModalBottomSheet(
        context: context,
        builder: ((context) {
          return SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                children: [
                  Container(
                    color: MyColors.mainMaterial[50],
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(child: Text(product.title.toString())),
                    ),
                  ),
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Ilość: ',
                                  style: TextStyle(fontSize: 18),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        Provider.of<DataProvider>(context,
                                                listen: false)
                                            .decrementAddProductAmount();
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.remove_circle,
                                      color: MyColors.mainMaterial,
                                      size: 32,
                                    )),
                                Text(
                                  '${Provider.of<DataProvider>(context).getAddProductAmount}',
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        Provider.of<DataProvider>(context,
                                                listen: false)
                                            .incrementAddProductAmount();
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.add_circle,
                                      color: MyColors.mainMaterial,
                                      size: 32,
                                    )),
                              ]),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton.icon(
                                  label: const Text('Anuluj'),
                                  onPressed: () {
                                    setState(() {
                                      Provider.of<DataProvider>(context,
                                              listen: false)
                                          .setAddProductAmount(1);
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          MyColors.accentMaterial[300],
                                      foregroundColor:
                                          MyColors.accentMaterial[50]),
                                  icon: const Icon(Icons.cancel)),
                              ElevatedButton.icon(
                                  label: const Text('Dodaj produkt'),
                                  onPressed: () {
                                    Provider.of<DataProvider>(context,
                                            listen: false)
                                        .addProduct(
                                            product, DateTime.now().toString());
                                    setState(() {
                                      Provider.of<DataProvider>(context,
                                              listen: false)
                                          .setAddProductAmount(1);
                                    });
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Produkt dodany do koszyka')));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          MyColors.mainMaterial[700],
                                      foregroundColor:
                                          MyColors.mainMaterial[50]),
                                  icon: const Icon(Icons.add)),
                            ],
                          ),
                        ]),
                  ),
                ],
              ));
        }));
  }
}
