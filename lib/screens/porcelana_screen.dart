import 'package:flutter/material.dart';
import 'package:fotoporcelana/helpers/attachments_db.dart';
import 'package:fotoporcelana/helpers/products_db.dart';
import 'package:fotoporcelana/models/attachments.dart';
import 'package:fotoporcelana/models/product.dart';
import 'package:fotoporcelana/my_colors.dart';
import 'package:fotoporcelana/providers/data_provider.dart';
import 'package:fotoporcelana/widgets/porcelana/porcelana_settings.dart';
import 'package:fotoporcelana/widgets/porcelana/schemat.dart';
import 'package:provider/provider.dart';
import '../providers/porcelana_options.dart';

class PorcelanaScreen extends StatelessWidget {
  static const routeName = '/porcelana';
  final title = 'Dodaj porcelanę';

  void _incrementIndex(BuildContext context) {
    Provider.of<PorcelanaOptions>(context, listen: false).incrementIndex();
  }

  void _decrementIndex(BuildContext context) {
    Provider.of<PorcelanaOptions>(context, listen: false).decrementIndex();
  }

  void _resetPorcelana(BuildContext context) {
    Provider.of<PorcelanaOptions>(context, listen: false).resetPorcelana();
  }

  const PorcelanaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var porcelanaProvider = Provider.of<PorcelanaOptions>(context);

    var ksztalt = porcelanaProvider.getKsztalt;
    var rozmiar = porcelanaProvider.getRozmiar;
    var pasek = porcelanaProvider.getPasek;
    var kolor = porcelanaProvider.getKolor;
    var index = porcelanaProvider.getIndex;
    var tlo = porcelanaProvider.getTlo;
    var ubranie = porcelanaProvider.getUbranie;
    var dwieOsoby = porcelanaProvider.getDwieOsoby;
    var odbicie = porcelanaProvider.getOdbicie;
    var kolorowanie = porcelanaProvider.getKolorowanie;
    var express = porcelanaProvider.getExpress;
    var wizualka = porcelanaProvider.getWizualka;
    var message = porcelanaProvider.getMessage;
    var amount = porcelanaProvider.getAmount;

    var imageFilePaths =
        Provider.of<PorcelanaOptions>(context, listen: false).getFilePaths;
    var pathNames = '';
    for (var element in imageFilePaths) {
      pathNames = '$pathNames - ${element.substring(62)}';
    }

    var title =
        'Porcelana ${ksztalt.displayName} ${rozmiar.displayName}, ${pasek.displayName}, ${kolor.displayName}';
    var data = '-Tło: ${tlo.displayName} \n'
        '-Ubranie: ${ubranie.displayName} \n'
        '${dwieOsoby ? '-Dwie osoby na zdjęciu\n' : ''}'
        '${odbicie && dwieOsoby ? '-Mężczyzna z lewej\n' : ''}'
        '${odbicie ? '-Odbicie lustrzane\n' : ''}'
        '${kolorowanie ? '-Kolorowanie zdjęcia\n' : ''}'
        '${express ? '-Tryb express\n' : ''}'
        '${wizualka ? '-Wizualizacja\n' : ''}'
        '$message';

    Future addProduct(String id) async {
      final product = Product(
        id: id,
        title: title,
        data: data,
        attachments: pathNames,
        amount: amount,
        createdTime: DateTime.now(),
      );
      await ProductsDB.instance.create(product);
    }

    Future addAttachments(String productID) async {
      Attachments attachment;
      for (String item in imageFilePaths) {
        attachment = Attachments(
          path: item,
          product: productID,
          createdTime: DateTime.now(),
        );
        await AttachmentsDB.instance.create(attachment);
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: index != 0
          ? BottomNavigationBar(
              selectedItemColor: MyColors.mainMaterial[50],
              unselectedItemColor: MyColors.mainMaterial[50],
              backgroundColor: MyColors.accentMaterial,
              onTap: (value) {
                if (value == 2) {
                  if (index == 8) {
                    String dateTimeNow = DateTime.now().toString();
                    addProduct(dateTimeNow);
                    addAttachments(dateTimeNow);
                    _resetPorcelana(context);
                    Provider.of<DataProvider>(context, listen: false)
                        .changeIndex(2);
                    Provider.of<DataProvider>(context, listen: false)
                        .incrementCartItems();
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Porcelana dodana do koszyka')));
                  } else {
                    _incrementIndex(context);
                  }
                } else if (value == 1) {
                  _resetPorcelana(context);
                  Navigator.of(context).pop();
                } else {
                  _decrementIndex(context);
                }
              },
              items: [
                  const BottomNavigationBarItem(
                    backgroundColor: Colors.white,
                    icon: Icon(Icons.arrow_back),
                    label: 'Poprzednie',
                  ),
                  const BottomNavigationBarItem(
                    backgroundColor: Colors.white,
                    icon: Icon(Icons.cancel),
                    label: 'Anuluj',
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Colors.white,
                    icon: index == 8
                        ? const Icon(Icons.add_shopping_cart)
                        : const Icon(Icons.arrow_forward),
                    label: index == 8 ? 'Dodaj do koszyka' : 'Następne',
                  ),
                ])
          : BottomNavigationBar(
              selectedItemColor: MyColors.mainMaterial[50],
              unselectedItemColor: MyColors.mainMaterial[50],
              backgroundColor: MyColors.accentMaterial,
              onTap: (value) {
                if (value == 1) {
                  _incrementIndex(context);
                } else {
                  if (index != 0) {
                    _decrementIndex(context);
                  } else {
                    _resetPorcelana(context);
                    Navigator.of(context).pop();
                  }
                }
              },
              items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.cancel),
                    label: 'Anuluj',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.arrow_forward),
                    label: 'Następne',
                  ),
                ]),
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            color: MyColors.mainMaterial,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Center(
                  child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              )),
            ),
          ),
          if (index != 7 && index != 8) ...[
            const SizedBox(
              height: 10.0,
            ),
            const Expanded(child: Schemat()),
          ],
          const SizedBox(
            height: 10.0,
          ),
          const PorcelanaSettings(),
        ]),
      ),
    );
  }
}
