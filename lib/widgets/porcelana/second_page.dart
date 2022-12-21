import 'package:flutter/material.dart';
import 'package:fotoporcelana/providers/porcelana_options.dart';
import 'package:provider/provider.dart';

import '../../models/name.dart';

class SecondPage extends StatelessWidget {
  final String _title;
  final List<Name> _list;
  final int _init;
  const SecondPage(this._title, this._list, this._init, {super.key});

  @override
  Widget build(BuildContext context) {
    var index = Provider.of<PorcelanaOptions>(context).getIndex;
    ScrollController controller =
        FixedExtentScrollController(initialItem: _init);

    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 32.0),
        child: Text(
          _title,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.2,
        child: ListWheelScrollView.useDelegate(
            controller: controller,
            itemExtent: 60,
            useMagnifier: true,
            magnification: 1.6,
            squeeze: 1.0,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (value) {
              switch (index) {
                case 1:
                  Provider.of<PorcelanaOptions>(context, listen: false)
                      .changeRozmiar(_list[value], value);
                  break;
                case 3:
                  Provider.of<PorcelanaOptions>(context, listen: false)
                      .changeKolor(_list[value], value);
                  break;
                case 6:
                  Provider.of<PorcelanaOptions>(context, listen: false)
                      .changeUbranie(_list[value], value);
                  break;
              }
            },
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: _list.length,
              builder: (context, index) {
                return Center(
                  child: Text(
                    _list[index].displayName.toString(),
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                );
              },
            )),
      ),
    ]);
  }
}
