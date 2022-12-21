import 'package:flutter/material.dart';
import 'package:fotoporcelana/my_colors.dart';
import 'package:fotoporcelana/providers/data_provider.dart';
import 'package:fotoporcelana/widgets/user/shipment_data.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _formKey = GlobalKey<FormState>();

  final _prefs = SharedPreferences.getInstance();

  final _username = TextEditingController();

  final _phone = TextEditingController();

  final _street = TextEditingController();

  final _code = TextEditingController();

  final _city = TextEditingController();

  final _email = TextEditingController();

  void saveData(String shipmentData, int shipmentIndex, bool payment) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('username', _username.text);
    prefs.setString('email', _email.text);
    prefs.setString('phone', _phone.text);
    prefs.setString('street', _street.text);
    prefs.setString('code', _code.text);
    prefs.setString('city', _city.text);
    prefs.setInt('shipmentIndex', shipmentIndex);
    prefs.setBool('payment', payment);
    prefs.setString('shipment', shipmentData);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _prefs,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String code = snapshot.data!.getString('code') ?? '';
            String city = snapshot.data!.getString('city') ?? '';
            String phone = snapshot.data!.getString('phone') ?? '';
            String street = snapshot.data!.getString('street') ?? '';
            String email = snapshot.data!.getString('email') ?? '';
            String username = snapshot.data!.getString('username') ?? '';

            _code.value = TextEditingValue(text: code.toString());
            _phone.value = TextEditingValue(text: phone.toString());
            _city.value = TextEditingValue(text: city.toString());
            _street.value = TextEditingValue(text: street.toString());
            _email.value = TextEditingValue(text: email.toString());
            _username.value = TextEditingValue(text: username.toString());
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('błąd: ${snapshot.error}');
              } else {
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(26.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text('Dane użytkownika:'),
                              TextFormField(
                                textCapitalization: TextCapitalization.words,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Uzupełnij nazwę';
                                  } else if (value.length < 4) {
                                    return 'Nazwa musi mieć min. 4 znaki';
                                  }
                                  return null;
                                },
                                controller: _username,
                                autofocus: false,
                                decoration: const InputDecoration(
                                  labelText: 'Nazwa klienta',
                                ),
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Uzupełnij email';
                                  } else if (!RegExp(r'\S+@\S+\.\S+')
                                      .hasMatch(value)) {
                                    return 'Niewłaściwy adres email';
                                  }
                                  return null;
                                },
                                controller: _email,
                                autofocus: false,
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                ),
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Uzupełnij numer telefonu';
                                  } else if (value.length < 9) {
                                    return 'Numer telefonu musi mieć minimum 9 znaków';
                                  }
                                  return null;
                                },
                                controller: _phone,
                                autofocus: false,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  labelText: 'Numer telefonu',
                                ),
                              ),
                              const SizedBox(
                                height: 18.0,
                              ),
                              const Text('Adres do wysyłki:'),
                              TextFormField(
                                textCapitalization: TextCapitalization.words,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Uzupełnij ulicę';
                                  } else if (value.length < 5) {
                                    return 'Ulica musi mieć min. 5 znaków';
                                  }
                                  return null;
                                },
                                controller: _street,
                                autofocus: false,
                                decoration: const InputDecoration(
                                  labelText: 'Ulica',
                                ),
                              ),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Uzupełnij kod pocztowy';
                                  } else if (value.length < 5) {
                                    return 'Kod pocztowy musi mieć min. 5 znaków';
                                  }
                                  return null;
                                },
                                controller: _code,
                                autofocus: false,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Kod pocztowy',
                                ),
                              ),
                              TextFormField(
                                textCapitalization: TextCapitalization.words,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Uzupełnij miasto';
                                  } else if (value.length < 3) {
                                    return 'Miasto musi mieć min. 3 znaki';
                                  }
                                  return null;
                                },
                                controller: _city,
                                decoration: const InputDecoration(
                                  labelText: 'Miasto',
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              const ShipmentData(),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: MyColors.mainMaterial[800],
                                foregroundColor: MyColors.mainMaterial[50]),
                            onPressed: (() {
                              final provider = Provider.of<DataProvider>(
                                  context,
                                  listen: false);
                              provider.changeShipment();
                              String shipmentData = provider.getShipment;
                              if (_formKey.currentState!.validate()) {
                                saveData(
                                    shipmentData,
                                    provider.getShipmentIndex,
                                    provider.getPayment);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Dane użytkownika zapisane')));
                                Provider.of<DataProvider>(context,
                                        listen: false)
                                    .setClientData;
                              }
                            }),
                            icon: const Icon(
                              Icons.save,
                            ),
                            label: const Text(
                              'Zapisz',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
          }
        });
  }
}
