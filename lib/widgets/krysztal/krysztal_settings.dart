import 'package:flutter/material.dart';
import 'package:fotoporcelana/models/name.dart';
import 'package:fotoporcelana/my_lists.dart';
import 'package:fotoporcelana/providers/krysztal_options.dart';
import 'package:fotoporcelana/widgets/krysztal/checkbox_page.dart';
import 'package:fotoporcelana/widgets/krysztal/image_page.dart';
import 'package:fotoporcelana/widgets/krysztal/option_page.dart';
import 'package:fotoporcelana/widgets/krysztal/second_page.dart';
import 'package:fotoporcelana/widgets/krysztal/summary_page.dart';
import 'package:provider/provider.dart';

class KrysztalSettings extends StatelessWidget {
  const KrysztalSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var index = Provider.of<KrysztalOptions>(context).getIndex;
    var ksztalt = Provider.of<KrysztalOptions>(context).getKsztalt;

    var rozmiarPage =
        Provider.of<KrysztalOptions>(context, listen: false).getRozmiarPage;
    var ksztaltPage =
        Provider.of<KrysztalOptions>(context, listen: false).getKsztaltPage;
    var kolorPage =
        Provider.of<KrysztalOptions>(context, listen: false).getKolorPage;
    var tloPage =
        Provider.of<KrysztalOptions>(context, listen: false).getTloPage;
    var ubraniePage =
        Provider.of<KrysztalOptions>(context, listen: false).getUbraniePage;

    List<Name> rozmiary;
    if (ksztalt.name == 'owal' || ksztalt.name == 'osmiokat') {
      rozmiary = MyLists().krysztalORozmiary;
    } else if (ksztalt.name == 'owal-5mm') {
      rozmiary = MyLists().krysztalOwal5mmRozmiary;
    } else if (ksztalt.name == 'prostokat-fazowany') {
      rozmiary = MyLists().krysztalProstokatFazowanyRozmiary;
    } else if (ksztalt.name == 'kwadrat' ||
        ksztalt.name == 'kwadrat-fazowany') {
      rozmiary = MyLists().krysztalKwadratRozmiary;
    } else {
      rozmiary = MyLists().krysztalProstokatRozmiary;
    }
    List<Name> ksztalty = MyLists().ksztaltyKrysztal;
    List<Name> kolory = MyLists().kolory;
    List<Name> tla = MyLists().tla;
    List<Name> ubrania = MyLists().ubrania;

    Widget conditionalWidget(int i) {
      switch (i) {
        case 0:
          return OptionPage('Ksztalt', ksztalty, ksztaltPage);
        case 1:
          return SecondPage('Rozmiary', rozmiary, rozmiarPage);
        case 2:
          return OptionPage('Kolor', kolory, kolorPage);
        case 3:
          return SecondPage('Tło', tla, tloPage);
        case 4:
          return const CheckboxPage();
        case 5:
          return OptionPage('Ubranie', ubrania, ubraniePage);
        case 6:
          return const ImagePage();
        case 7:
          return const SummaryPage();
        default:
          return OptionPage('Rozmiar', rozmiary, rozmiarPage);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        child: conditionalWidget(index),
      ),
    );
  }
}
