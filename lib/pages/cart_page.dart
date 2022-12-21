import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fotoporcelana/helpers/attachments_db.dart';

import 'package:fotoporcelana/helpers/products_db.dart';
import 'package:fotoporcelana/models/attachments.dart';
import 'package:fotoporcelana/models/product.dart';
import 'package:fotoporcelana/my_colors.dart';
import 'package:fotoporcelana/providers/data_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<Product> products;
  late List<Attachments> attachments;
  late List<String> attachmentsPath = [];
  late String body = '';
  bool isLoading = false;
  var title = '';
  var clientInfo = '';

  @override
  void initState() {
    super.initState();
    refreshProducts();
  }

  Future getData() async {}

  Future refreshProducts() async {
    setState(() {
      isLoading = true;
    });
    attachmentsPath = [];
    products = await ProductsDB.instance.readAllProducts();
    attachments = await AttachmentsDB.instance.readAllAttachments();
    for (Attachments item in attachments) {
      attachmentsPath.add(item.path);
    }
    body = '';
    for (Product product in products) {
      body = '''
$body \n
${product.title} - Ilość: ${product.amount} \n
${product.data} \n
${product.attachments.isEmpty ? '' : ' Załączniki ${product.attachments}\n'}
______________________________________
          ''';
    }
    setState(() {
      isLoading = false;
    });
  }

  Future deleteProduct(String id) async {
    await ProductsDB.instance.delete(id);
    await AttachmentsDB.instance.delete(id);
    refreshProducts();
  }

  Future deleteAllProducts() async {
    await ProductsDB.instance.deleteAll();
    await AttachmentsDB.instance.deleteAll();
    refreshProducts();
  }

  Future<void> sendEmail() async {
    final Email email = Email(
      subject: title,
      recipients: ['info@fotoporcelana.net'],
      body: '$body \n $clientInfo',
      attachmentPaths: attachmentsPath,
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  void fillData(BuildContext ctx) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text('Uzupełnij dane użytkownika przed złożeniem zamówienia!')));
    setState(() {
      Provider.of<DataProvider>(context, listen: false).changeIndex(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DataProvider>(context);
    title = provider.getTitle;
    provider.setClientData();
    bool clientData = provider.getClientData;
    clientInfo = provider.getClientInfo;
    return Center(
      child: isLoading
          ? const CircularProgressIndicator()
          : products.isEmpty
              ? const Text('Koszyk jest pusty')
              : Stack(alignment: AlignmentDirectional.bottomCenter, children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60.0),
                    child: buildProducts(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.mainMaterial[800],
                            foregroundColor: MyColors.mainMaterial[50]),
                        onPressed: () {
                          clientData
                              ? fillData(context)
                              : sendEmail()
                                  .whenComplete(() => deleteAllProducts());
                        },
                        icon: const Icon(
                          Icons.message,
                        ),
                        label: const FittedBox(
                          child: Text(
                            'Wyślij mail z zamówieniem',
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
    );
  }

  Widget buildProducts() {
    return ListView.builder(
        itemCount: products.length,
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
                      color: MyColors.mainMaterial[400],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                products[index].title,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: (() {
                              deleteProduct(products[index].id);

                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Produkt usunięty')));
                              Provider.of<DataProvider>(context, listen: false)
                                  .decrementCartItems();
                            }),
                            icon: const Icon(Icons.cancel),
                            color: MyColors.mainMaterial[50],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(18.0, 18.0, 0, 0),
                            child: Text(
                              products[index].data,
                            ),
                          ),
                        ),
                        Text('Ilość: ${products[index].amount} szt. ')
                      ],
                    ),
                    listOfAttachments(index),
                  ],
                )),
          );
        }));
  }

  Widget listOfAttachments(int index) {
    return FutureBuilder<List<Attachments>>(
        future: Provider.of<DataProvider>(context)
            .setAttachmentsByID(products[index].id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: snapshot.data!.isEmpty ? 0 : 80,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data?.length,
                      itemBuilder: ((context, index) {
                        return Image.file(
                            height: 80,
                            width: 80,
                            File(snapshot.data![index].path));
                      })),
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
