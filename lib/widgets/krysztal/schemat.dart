import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/krysztal_options.dart';

class Schemat extends StatelessWidget {
  const Schemat({super.key});

  @override
  Widget build(BuildContext context) {
    var krysztalProvider = Provider.of<KrysztalOptions>(context);
    var index = krysztalProvider.getIndex;
    var ksztalt = krysztalProvider.getKsztalt;
    var kolor = krysztalProvider.getKolor;
    var tlo = krysztalProvider.getTlo;
    var ubranie = krysztalProvider.getUbranie;
    var dwieOsoby = krysztalProvider.getDwieOsoby;
    var odbicie = krysztalProvider.getOdbicie;
    bool rotate = false;
    var avatar = 'avatar';

    if (ksztalt.name == 'prostokat-fazowany' && dwieOsoby ||
        ksztalt.name == 'owal' && dwieOsoby ||
        ksztalt.name == 'owal-5mm' && dwieOsoby ||
        ksztalt.name == 'prostokat' && dwieOsoby ||
        ksztalt.name == 'osmiokat' && dwieOsoby) {
      rotate = true;
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
            child: Image.asset('assets/krysztaly/schematy/${ksztalt.name}.png'),
          ),
          ubranie.name != 'bez-zmian' && index == 5
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
