import 'package:flutter/material.dart';
import 'package:fotoporcelana/providers/porcelana_options.dart';
import 'package:provider/provider.dart';

class CheckboxPage extends StatefulWidget {
  const CheckboxPage({super.key});

  @override
  State<CheckboxPage> createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  bool dwieOsoby = false;
  bool odbicie = false;
  bool kolorowanie = false;
  bool express = false;

  @override
  Widget build(BuildContext context) {
    dwieOsoby =
        Provider.of<PorcelanaOptions>(context, listen: false).getDwieOsoby;
    odbicie = Provider.of<PorcelanaOptions>(context, listen: false).getOdbicie;
    kolorowanie =
        Provider.of<PorcelanaOptions>(context, listen: false).getKolorowanie;
    express = Provider.of<PorcelanaOptions>(context, listen: false).getExpress;

    return FittedBox(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.28,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Dwie osoby na jednym zdjęciu (+25 zł)'),
                        Checkbox(
                          value: dwieOsoby,
                          onChanged: (bool? value) {
                            setState(() {
                              dwieOsoby = value!;
                            });
                            Provider.of<PorcelanaOptions>(context,
                                    listen: false)
                                .changeDwieOsoby(dwieOsoby);
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(dwieOsoby
                            ? 'Mężczyzna z lewej kobieta z prawej'
                            : 'Odbicie lustrzane'),
                        Checkbox(
                          value: odbicie,
                          onChanged: (bool? value) {
                            setState(() {
                              odbicie = value!;
                            });
                            Provider.of<PorcelanaOptions>(context,
                                    listen: false)
                                .changeOdbicie(odbicie);
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Kolorowanie zdjęcia (+25 zł)'),
                        Checkbox(
                          value: kolorowanie,
                          onChanged: (bool? value) {
                            setState(() {
                              kolorowanie = value!;
                            });
                            Provider.of<PorcelanaOptions>(context,
                                    listen: false)
                                .changeKolorowanie(kolorowanie);
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Tryb Express 48h (+49 zł)'),
                        Checkbox(
                          value: express,
                          onChanged: (bool? value) {
                            setState(() {
                              express = value!;
                            });
                            Provider.of<PorcelanaOptions>(context,
                                    listen: false)
                                .changeExpress(express);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ]),
    );
  }
}
