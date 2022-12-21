import 'package:flutter/material.dart';
import 'package:fotoporcelana/my_colors.dart';
import 'package:fotoporcelana/providers/krysztal_options.dart';
import 'package:provider/provider.dart';

class SelectAmount extends StatefulWidget {
  const SelectAmount({super.key});

  @override
  State<SelectAmount> createState() => _SelectAmountState();
}

void _incrementAmount(BuildContext context) {
  Provider.of<KrysztalOptions>(context, listen: false).incrementAmount();
}

void _decrementAmount(BuildContext context) {
  Provider.of<KrysztalOptions>(context, listen: false).decrementAmount();
}

class _SelectAmountState extends State<SelectAmount> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(children: [
        const Text(
          'Ilość: ',
          style: TextStyle(fontSize: 18),
        ),
        IconButton(
            onPressed: () {
              _decrementAmount(context);
            },
            icon: const Icon(
              Icons.remove_circle,
              color: MyColors.mainMaterial,
              size: 32,
            )),
        Text(
          Provider.of<KrysztalOptions>(context).getAmount.toString(),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        IconButton(
            onPressed: () {
              _incrementAmount(context);
            },
            icon: const Icon(
              Icons.add_circle,
              color: MyColors.mainMaterial,
              size: 32,
            )),
      ]),
    );
  }
}
