import 'package:flutter/material.dart';
import 'package:fotoporcelana/models/name.dart';
import 'package:fotoporcelana/my_lists.dart';
import 'package:fotoporcelana/widgets/porcelana/checkbox_page.dart';
import 'package:fotoporcelana/widgets/porcelana/image_page.dart';
import 'package:fotoporcelana/widgets/porcelana/option_page.dart';
import 'package:fotoporcelana/widgets/porcelana/second_page.dart';
import 'package:fotoporcelana/widgets/porcelana/summary_page.dart';
import 'package:provider/provider.dart';

import '../../providers/porcelana_options.dart';

class PorcelanaSettings extends StatelessWidget {
  const PorcelanaSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var index = Provider.of<PorcelanaOptions>(context).getIndex;
    var ksztalt = Provider.of<PorcelanaOptions>(context).getKsztalt;
    var rozmiar = Provider.of<PorcelanaOptions>(context).getRozmiar;

    var rozmiarPage =
        Provider.of<PorcelanaOptions>(context, listen: false).getRozmiarPage;
    var ksztaltPage =
        Provider.of<PorcelanaOptions>(context, listen: false).getKsztaltPage;
    var pasekPage =
        Provider.of<PorcelanaOptions>(context, listen: false).getPasekPage;
    var kolorPage =
        Provider.of<PorcelanaOptions>(context, listen: false).getKolorPage;
    var tloPage =
        Provider.of<PorcelanaOptions>(context, listen: false).getTloPage;
    var ubraniePage =
        Provider.of<PorcelanaOptions>(context, listen: false).getUbraniePage;

    List<Name> rozmiary;
    if (ksztalt.name == 'owal') {
      if (ksztalt.displayName == 'Owal 3D') {
        rozmiary = MyLists().owal3dRozmiary;
      } else {
        rozmiary = MyLists().owalRozmiary;
      }
    } else if (ksztalt.name == 'prostokat') {
      if (ksztalt.displayName == 'Prostokąt 3D') {
        rozmiary = MyLists().prostokat3dRozmiary;
      } else {
        rozmiary = MyLists().prostokatRozmiary;
      }
    } else if (ksztalt.name == 'kolo') {
      rozmiary = MyLists().koloRozmiary;
    } else if (ksztalt.name == 'kwadrat') {
      rozmiary = MyLists().kwadratRozmiary;
    } else if (ksztalt.name == 'serce') {
      rozmiary = MyLists().serceRozmiary;
    } else if (ksztalt.name == 'serce-lewe' || ksztalt.name == 'serce-prawe') {
      rozmiary = MyLists().serceAsymetryczneRozmiary;
    } else if (ksztalt.name == 'bohemia') {
      rozmiary = MyLists().bohemiaRozmiary;
    } else if (ksztalt.name == 'kopulka') {
      rozmiary = MyLists().kopulkaRozmiary;
    } else if (ksztalt.name == 'ksiazka-egiziani') {
      rozmiary = MyLists().ksiazkaEgizianiRozmiary;
    } else if (ksztalt.name == 'ksiazka-egitto') {
      rozmiary = MyLists().ksiazkaEgittoRozmiary;
    } else if (ksztalt.name == 'pergamin-kronos') {
      rozmiary = MyLists().pergaminKronosRozmiary;
    } else if (ksztalt.name == 'pergamin-kreta') {
      rozmiary = MyLists().pergaminKretaRozmiary;
    } else if (ksztalt.name == 'pergamin-egitto') {
      rozmiary = MyLists().pergaminEgittoRozmiary;
    } else if (ksztalt.name == 'papirus') {
      rozmiary = MyLists().papirusRozmiary;
    } else {
      rozmiary = MyLists().owalRozmiary;
    }
    List<Name> ksztalty = MyLists().ksztalty;
    List<Name> paski;
    if (rozmiar.name == '20x25' ||
        rozmiar.name == '20x28' ||
        rozmiar.name == '24x30' ||
        rozmiar.name == '30x40') {
      paski = MyLists().bezPaska;
    } else if (ksztalt.name == 'owal' ||
        ksztalt.name == 'prostokat' ||
        ksztalt.name == 'kolo' ||
        ksztalt.name == 'kwadrat') {
      paski = MyLists().paski;
    } else if (ksztalt.name == 'serce' ||
        ksztalt.name == 'serce-lewe' ||
        ksztalt.name == 'serce-prawe' ||
        ksztalt.name == 'bohemia' ||
        ksztalt.name == 'kopulka') {
      paski = MyLists().paskiBS;
    } else {
      paski = MyLists().bezPaska;
    }

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
          return OptionPage('Wykończenie', paski, pasekPage);
        case 3:
          return SecondPage('Kolor', kolory, kolorPage);
        case 4:
          return OptionPage('Tło', tla, tloPage);
        case 5:
          return const CheckboxPage();
        case 6:
          return SecondPage('Ubrania', ubrania, ubraniePage);
        case 7:
          return const ImagePage();
        case 8:
          return const SummaryPage();
        default:
          return OptionPage('Rozmiar', rozmiary, rozmiarPage);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: conditionalWidget(index),
    );
  }
}
