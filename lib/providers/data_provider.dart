import 'package:flutter/material.dart';
import 'package:fotoporcelana/helpers/attachments_db.dart';
import 'package:fotoporcelana/helpers/products_db.dart';
import 'package:fotoporcelana/models/attachments.dart';
import 'package:fotoporcelana/models/other_product.dart';
import 'package:fotoporcelana/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataProvider extends ChangeNotifier {
  var _cartItems = 0;
  var _clientData = false;
  var _payment = false;
  var _index = 0;
  var _shipmentIndex = 0;
  var _username = '';
  var _email = '';
  var _city = '';
  var _code = '';
  var _phone = '';
  var _street = '';
  var _shipment = '';
  var _addProductAmount = 1;
  List<Product> _products = [];
  final _title = 'Zamówienie z aplikacji';

  int get getCartItems {
    return _cartItems;
  }

  List<Product> get getProducts {
    return _products;
  }

  String get getTitle {
    return '$_title - $_username - $_shipment';
  }

  String get getClientInfo {
    return 'Klient: $_username \n email: $_email \n nr. tel: $_phone \n adres: $_street, $_code $_city \n $_shipment';
  }

  String get getShipment {
    return _shipment;
  }

  int get getIndex {
    return _index;
  }

  int get getShipmentIndex {
    return _shipmentIndex;
  }

  int get getAddProductAmount {
    return _addProductAmount;
  }

  bool get getClientData {
    return _clientData;
  }

  bool get getPayment {
    return _payment;
  }

  void changeCarItems(int cartItems) {
    _cartItems = cartItems;
    notifyListeners();
  }

  void changeShipment() {
    String shipment = '';
    if (_shipmentIndex == 0) {
      shipment = 'K2.0 ${_payment ? ' Przelew' : ' Pobranie'}';
    } else if (_shipmentIndex == 1) {
      shipment = 'InPost Kurier ${_payment ? ' Przelew' : ' Pobranie'}';
    } else if (_shipmentIndex == 2) {
      shipment = 'InPost Paczkomaty ${_payment ? ' Przelew' : ' Pobranie'}';
    } else if (_shipmentIndex == 3) {
      shipment = 'Dodaj zamówienie do poprzedniego';
    } else if (_shipmentIndex == 4) {
      shipment = 'Odbiór osobisty';
    }
    _shipment = shipment;
    notifyListeners();
  }

  void changeIndex(int index) {
    _index = index;
    notifyListeners();
  }

  void changePayment(bool payment) {
    _payment = payment;
  }

  void changeShipmentIndex(int index) {
    _shipmentIndex = index;
    notifyListeners();
  }

  void incrementCartItems() {
    _cartItems += 1;
    notifyListeners();
  }

  void decrementCartItems() {
    _cartItems -= 1;
    notifyListeners();
  }

  void incrementAddProductAmount() {
    _addProductAmount += 1;
    notifyListeners();
  }

  void decrementAddProductAmount() {
    if (_addProductAmount != 1) {
      _addProductAmount -= 1;
    }
    notifyListeners();
  }

  void setCartItems() async {
    int cartItems = await ProductsDB.instance
        .readAllProducts()
        .then((value) => value.length);
    _cartItems = cartItems;
    notifyListeners();
  }

  void setAddProductAmount(int amount) {
    _addProductAmount = amount;
  }

  void setProducts() async {
    List<Product> products =
        await ProductsDB.instance.readAllProducts().then((value) => value);
    _products = products;
  }

  Future<List<Attachments>> setAttachmentsByID(String id) async {
    List<Attachments> attachments = await AttachmentsDB.instance
        .readAttachmentsById(id)
        .then((value) => value);
    return attachments;
  }

  void setClientData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _username = prefs.getString('username') ?? '';
    _email = prefs.getString('email') ?? '';
    _street = prefs.getString('street') ?? '';
    _phone = prefs.getString('phone') ?? '';
    _city = prefs.getString('city') ?? '';
    _code = prefs.getString('code') ?? '';
    _shipment = prefs.getString('shipment') ?? '';

    if (_username.isEmpty ||
        _email.isEmpty ||
        _street.isEmpty ||
        _phone.isEmpty ||
        _city.isEmpty ||
        _code.isEmpty) {
      _clientData = true;
    } else {
      _clientData = false;
    }
    notifyListeners();
  }

  Future addProduct(OtherProduct product, String id) async {
    final productToAdd = Product(
        id: id,
        title: product.title.toString(),
        data: product.data.toString(),
        attachments: '',
        amount: _addProductAmount,
        createdTime: DateTime.now());
    await ProductsDB.instance.create(productToAdd);
  }
}
