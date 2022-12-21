import 'package:flutter/material.dart';
import 'package:fotoporcelana/providers/porcelana_options.dart';
import 'package:provider/provider.dart';

class PorcelanaData extends StatefulWidget {
  const PorcelanaData({super.key});

  @override
  State<PorcelanaData> createState() => _PorcelanaDataState();
}

class _PorcelanaDataState extends State<PorcelanaData> {
  bool wizualka = false;
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _messageController.value = TextEditingValue(
        text: Provider.of<PorcelanaOptions>(context, listen: false).getMessage);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PorcelanaOptions>(context, listen: false);
    var tlo = provider.getTlo;
    var ubranie = provider.getUbranie;
    var dwieOsoby = provider.getDwieOsoby;
    var odbicie = provider.getOdbicie;
    var kolorowanie = provider.getKolorowanie;
    var express = provider.getExpress;
    wizualka = provider.getWizualka;
    return Column(
      children: [
        TextField(
          controller: _messageController,
          keyboardType: TextInputType.multiline,
          maxLength: 10000,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Wiadomość',
          ),
          onChanged: (value) {
            Provider.of<PorcelanaOptions>(context, listen: false)
                .changeMessage(_messageController.text);
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tło: ${tlo.displayName}',
              ),
              Text(
                'Ubranie: ${ubranie.displayName}',
              ),
              dwieOsoby
                  ? const Text(
                      'Dwie osoby na jednym zdjęciu',
                    )
                  : const SizedBox(),
              odbicie
                  ? Text(
                      dwieOsoby
                          ? 'Mężczyzna z lewej, kobieta z prawej'
                          : 'Odbicie lustrzane',
                    )
                  : const SizedBox(),
              kolorowanie
                  ? const Text('Kolorowanie zdjęcia')
                  : const SizedBox(),
              express ? const Text('Tryb express') : const SizedBox(),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
                'Chcę zobaczyć wizualizację \n(Pierwsza gratis, kolejne +20zł)'),
            Checkbox(
              value: wizualka,
              onChanged: (bool? value) {
                setState(() {
                  wizualka = value!;
                });
                Provider.of<PorcelanaOptions>(context, listen: false)
                    .changeWizualka(wizualka);
              },
            ),
          ],
        ),
      ],
    );
  }
}
