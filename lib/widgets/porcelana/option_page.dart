import 'package:flutter/material.dart';
import 'package:fotoporcelana/providers/porcelana_options.dart';
import 'package:provider/provider.dart';

class OptionPage extends StatelessWidget {
  final String _title;
  final List<dynamic> _list;
  final int _init;
  const OptionPage(this._title, this._list, this._init, {super.key});

  @override
  Widget build(BuildContext context) {
    var index = Provider.of<PorcelanaOptions>(context).getIndex;

    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: Text(
              _title,
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.2,
            child: ListWheelScrollView.useDelegate(
                controller: FixedExtentScrollController(initialItem: _init),
                itemExtent: 60,
                useMagnifier: true,
                magnification: 1.6,
                squeeze: 1.0,
                physics: const FixedExtentScrollPhysics(),
                onSelectedItemChanged: (value) {
                  switch (index) {
                    case 0:
                      Provider.of<PorcelanaOptions>(context, listen: false)
                          .changeKsztalt(_list[value], value);
                      break;
                    case 2:
                      Provider.of<PorcelanaOptions>(context, listen: false)
                          .changePasek(_list[value], value);
                      break;
                    case 4:
                      Provider.of<PorcelanaOptions>(context, listen: false)
                          .changeTlo(_list[value], value);
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
