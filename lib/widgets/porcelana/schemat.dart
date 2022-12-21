import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/porcelana_options.dart';

class Schemat extends StatelessWidget {
  const Schemat({super.key});

  @override
  Widget build(BuildContext context) {
    var porcelanaProvider = Provider.of<PorcelanaOptions>(context);
    var index = porcelanaProvider.getIndex;
    var rozmiar = porcelanaProvider.getRozmiar;
    var ksztalt = porcelanaProvider.getKsztalt;
    var pasek = porcelanaProvider.getPasek;
    var kolor = porcelanaProvider.getKolor;
    var tlo = porcelanaProvider.getTlo;
    var ubranie = porcelanaProvider.getUbranie;
    var dwieOsoby = porcelanaProvider.getDwieOsoby;
    var odbicie = porcelanaProvider.getOdbicie;
    bool rotate = false;
    bool bezPaska = false;
    var avatar = 'avatar';
    if (ksztalt.name == 'owal' && dwieOsoby ||
        ksztalt.name == 'prostokat' && dwieOsoby ||
        ksztalt.name == 'bohemia' && dwieOsoby) {
      rotate = true;
    }
    if (ksztalt.name == 'ksiazka-egiziani' ||
        ksztalt.name == 'ksiazka-egitto' ||
        ksztalt.name == 'pergamin-kronos' ||
        ksztalt.name == 'pergamin-kreta' ||
        ksztalt.name == 'pergamin-egitto' ||
        ksztalt.name == 'papirus') {
      avatar = 'avatarBook';
    }
    if (pasek.name == 'na-spad' ||
        rozmiar.name == '20x25' ||
        rozmiar.name == '20x28' ||
        rozmiar.name == '24x30' ||
        rozmiar.name == '30x40') {
      bezPaska = true;
    }
    if (dwieOsoby) {
      avatar = 'avatar2osoby';
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
        child: Stack(alignment: AlignmentDirectional.topCenter, children: [
          Image.asset('assets/bg/${kolor.name}/${tlo.name}.png'),
          Transform(
            transform:
                Matrix4.rotationY((odbicie ? -2 : 0) * 3.141592653587932 / 2),
            alignment: Alignment.center,
            child: Image.asset('assets/avatar/${kolor.name}/$avatar.png'),
          ),
          RotatedBox(
            quarterTurns: rotate ? 1 : 0,
            child: Image.asset('assets/porcelana/schematy/${ksztalt.name}.png'),
          ),
          RotatedBox(
            quarterTurns: rotate ? 1 : 0,
            child: bezPaska
                ? const SizedBox()
                : Image.asset(
                    'assets/porcelana/paski/${ksztalt.name}-${pasek.name}.png',
                    scale: 0.5,
                  ),
          ),
          ubranie.name != 'bez-zmian' && index == 6
              ? Stack(alignment: AlignmentDirectional.topCenter, children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                  ),
                  Image.asset(
                    'assets/ubrania/${ubranie.name}.webp',
                  ),
                ])
              : const SizedBox(),
        ]),
      ),
    );
  }
}
