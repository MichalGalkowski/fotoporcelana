import 'package:flutter/material.dart';
import 'package:fotoporcelana/my_lists.dart';
import 'package:fotoporcelana/providers/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShipmentData extends StatefulWidget {
  const ShipmentData({super.key});

  @override
  State<ShipmentData> createState() => _ShipmentDataState();
}

class _ShipmentDataState extends State<ShipmentData> {
  var _selectedIndex = 0;
  final _shipments = MyLists().shipment;
  var _isVisible = true;
  var _payment = false;

  void changeIndex() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('shipmentIndex') == null) {
      prefs.setInt('shipmentIndex', 0);
    } else {
      _selectedIndex = prefs.getInt('shipmentIndex') as int;
    }
    if (prefs.getBool('payment') == null) {
      prefs.setBool('payment', false);
    } else {
      _payment = prefs.getBool('payment') as bool;
    }
    setState(() {});
  }

  @override
  void initState() {
    changeIndex();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          height: 80,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _shipments.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () => setState(() {
                      _selectedIndex = index;
                      Provider.of<DataProvider>(context, listen: false)
                          .changeShipmentIndex(index);
                    }),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: _selectedIndex == index
                                  ? Border.all(width: 3.0, color: Colors.green)
                                  : const Border()),
                          width: 50,
                          height: 50,
                          child: Image.asset(
                              'assets/shipment/${_shipments[index].name}.jpg'),
                        ),
                      ],
                    ),
                  ),
                );
              })),
        ),
        FittedBox(child: shipmentRow()),
      ],
    );
  }

  Widget shipmentRow() {
    String name = '';

    switch (_selectedIndex) {
      case 0:
        name = 'Pocztex Kurier 2.0';
        _isVisible = true;
        break;
      case 1:
        name = 'InPost Kurier 24h';
        _isVisible = true;
        break;
      case 2:
        name = 'InPost Paczkomaty 24/7';
        _isVisible = true;
        break;
      case 3:
        name = 'Dodaj zamówienie do poprzedniego';
        _isVisible = false;
        break;
      case 4:
        name = 'Odbiór osobisty';
        _isVisible = false;
        break;
    }
    return Row(
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
        ),
        _isVisible
            ? Row(
                children: [
                  Text(
                    _payment ? ' przelew' : ' za pobraniem',
                    style: const TextStyle(
                        fontSize: 15.0, fontWeight: FontWeight.w500),
                  ),
                  Switch(
                      value: _payment,
                      onChanged: ((value) => setState(() {
                            _payment = value;
                            Provider.of<DataProvider>(context, listen: false)
                                .changePayment(value);
                          }))),
                ],
              )
            : const SizedBox(),
      ],
    );
  }
}
