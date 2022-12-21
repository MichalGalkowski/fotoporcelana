import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fotoporcelana/models/name.dart';

class PorcelanaOptions extends ChangeNotifier {
  var _rozmiar = Name(name: '8x11', displayName: '8x11');
  var _rozmiarPage = 7;
  var _ksztalt = Name(name: 'owal', displayName: 'Owal');
  var _ksztaltPage = 0;
  var _pasek = Name(name: 'bialy-pasek', displayName: 'Biały pasek');
  var _pasekPage = 0;
  var _kolor = Name(name: 'kolor', displayName: 'Kolor');
  var _kolorPage = 0;
  var _tlo = Name(name: 'bez-zmian', displayName: 'Bez zmian');
  var _tloPage = 0;
  var _ubranie = Name(name: 'bez-zmian', displayName: 'Bez zmian');
  var _ubraniePage = 0;
  var _amount = 1;
  var _index = 0;
  var _dwieOsoby = false;
  var _odbicie = false;
  var _kolorowanie = false;
  var _express = false;
  var _wizualka = false;
  var _message = '';
  List<File> _files = [];
  List<String> _filePaths = [];

  int get getIndex {
    return _index;
  }

  Name get getRozmiar {
    return _rozmiar;
  }

  int get getRozmiarPage {
    return _rozmiarPage;
  }

  Name get getKsztalt {
    return _ksztalt;
  }

  int get getKsztaltPage {
    return _ksztaltPage;
  }

  Name get getPasek {
    return _pasek;
  }

  int get getPasekPage {
    return _pasekPage;
  }

  Name get getKolor {
    return _kolor;
  }

  int get getKolorPage {
    return _kolorPage;
  }

  Name get getTlo {
    return _tlo;
  }

  int get getTloPage {
    return _tloPage;
  }

  Name get getUbranie {
    return _ubranie;
  }

  int get getUbraniePage {
    return _ubraniePage;
  }

  int get getAmount {
    return _amount;
  }

  List<File> get getFiles {
    return _files;
  }

  List<String> get getFilePaths {
    return _filePaths;
  }

  bool get getDwieOsoby {
    return _dwieOsoby;
  }

  bool get getOdbicie {
    return _odbicie;
  }

  bool get getKolorowanie {
    return _kolorowanie;
  }

  bool get getExpress {
    return _express;
  }

  bool get getWizualka {
    return _wizualka;
  }

  String get getMessage {
    return _message;
  }

  void changeRozmiar(Name rozmiar, int page) {
    _rozmiar = rozmiar;
    _rozmiarPage = page;
    notifyListeners();
  }

  void changeKsztalt(Name ksztalt, int page) {
    _ksztalt = ksztalt;
    _ksztaltPage = page;
    ksztaltRozmiar(ksztalt.name.toString());
    notifyListeners();
  }

  void changePasek(Name pasek, int page) {
    _pasek = pasek;
    _pasekPage = page;
    notifyListeners();
  }

  void changeKolor(Name kolor, int page) {
    _kolor = kolor;
    _kolorPage = page;
    notifyListeners();
  }

  void changeTlo(Name tlo, int page) {
    _tlo = tlo;
    _tloPage = page;
    notifyListeners();
  }

  void changeUbranie(Name ubranie, int page) {
    _ubranie = ubranie;
    _ubraniePage = page;
    notifyListeners();
  }

  void changeDwieOsoby(bool dwieOsoby) {
    _dwieOsoby = dwieOsoby;
    notifyListeners();
  }

  void changeOdbicie(bool odbicie) {
    _odbicie = odbicie;
    notifyListeners();
  }

  void changeKolorowanie(bool kolorowanie) {
    _kolorowanie = kolorowanie;
    notifyListeners();
  }

  void changeExpress(bool express) {
    _express = express;
    notifyListeners();
  }

  void changeWizualka(bool wizualka) {
    _wizualka = wizualka;
    notifyListeners();
  }

  void changeMessage(String message) {
    _message = message;
    notifyListeners();
  }

  void addFile(File file) {
    _files.add(file);
    notifyListeners();
  }

  void addFilePath(String path) {
    _filePaths.add(path);
    notifyListeners();
  }

  void removeFile(File file) {
    _files.remove(file);
    notifyListeners();
  }

  void removeFilePath(String filePath) {
    _filePaths.remove(filePath);
    notifyListeners();
  }

  void incrementIndex() {
    _index += 1;
    notifyListeners();
  }

  void decrementIndex() {
    _index -= 1;
    notifyListeners();
  }

  void incrementAmount() {
    if (_amount != 5) {
      _amount += 1;
    }
    notifyListeners();
  }

  void decrementAmount() {
    if (_amount != 1) {
      _amount -= 1;
    }
    notifyListeners();
  }

  void resetPorcelana() {
    _rozmiar = Name(name: '8x11', displayName: '8x11');
    _rozmiarPage = 7;
    _ksztalt = Name(name: 'owal', displayName: 'Owal');
    _ksztaltPage = 0;
    _pasek = Name(name: 'bialy-pasek', displayName: 'Bez paska');
    _pasekPage = 0;
    _kolor = Name(name: 'kolor', displayName: 'Kolor');
    _kolorPage = 0;
    _tlo = Name(name: 'bez-zmian', displayName: 'Bez zmian');
    _tloPage = 0;
    _ubranie = Name(name: 'bez-zmian', displayName: 'Bez zmian');
    _ubraniePage = 0;
    _message = '';
    _dwieOsoby = false;
    _odbicie = false;
    _kolorowanie = false;
    _express = false;
    _wizualka = false;
    _tloPage = 0;
    _index = 0;
    _files = [];
    _filePaths = [];
    _amount = 1;
    notifyListeners();
  }

  void ksztaltRozmiar(String ksztalt) {
    Name rozmiar;
    Name pasek;
    int page;
    switch (ksztalt) {
      case 'owal':
        rozmiar = Name(name: '8x11', displayName: '8x11');
        page = 7;
        changeRozmiar(rozmiar, page);
        break;
      case 'prostokat':
        rozmiar = Name(name: '8x11', displayName: '8x11');
        page = 6;
        changeRozmiar(rozmiar, page);
        break;
      case 'kolo':
        rozmiar = Name(name: '10', displayName: '10x10');
        page = 5;
        changeRozmiar(rozmiar, page);
        break;
      case 'kwadrat':
        rozmiar = Name(name: '10', displayName: '10x10');
        page = 1;
        changeRozmiar(rozmiar, page);
        break;
      case 'serce':
        rozmiar = Name(name: '10', displayName: '10x10');
        page = 1;
        changeRozmiar(rozmiar, page);
        break;
      case 'serce-prawe':
        rozmiar = Name(name: '11x12', displayName: '11x12');
        page = 2;
        changeRozmiar(rozmiar, page);
        break;
      case 'serce-lewe':
        rozmiar = Name(name: '11x12', displayName: '11x12');
        page = 2;
        changeRozmiar(rozmiar, page);
        break;
      case 'bohemia':
        rozmiar = Name(name: '10x11,8', displayName: '10x11,8');
        page = 2;
        changeRozmiar(rozmiar, page);
        break;
      case 'kopulka':
        rozmiar = Name(name: '9x12', displayName: '9x12');
        page = 0;
        changeRozmiar(rozmiar, page);
        break;
      case 'ksiazka-egiziani':
        rozmiar = Name(name: '17x15', displayName: '17x15');
        pasek = Name(name: 'bialy-pasek', displayName: 'Biały pasek');
        page = 0;
        changeRozmiar(rozmiar, page);
        changePasek(pasek, page);
        break;
      case 'ksiazka-egitto':
        rozmiar = Name(name: '20x13', displayName: '20x13');
        pasek = Name(name: 'bialy-pasek', displayName: 'Biały pasek');
        page = 0;
        changeRozmiar(rozmiar, page);
        changePasek(pasek, page);
        break;
      case 'pergamin-kronos':
        rozmiar = Name(name: '22x15', displayName: '22x15');
        pasek = Name(name: 'bialy-pasek', displayName: 'Biały pasek');
        page = 0;
        changeRozmiar(rozmiar, page);
        changePasek(pasek, page);
        break;
      case 'pergamin-kreta':
        rozmiar = Name(name: '22x15', displayName: '22x15');
        pasek = Name(name: 'bialy-pasek', displayName: 'Biały pasek');
        page = 0;
        changeRozmiar(rozmiar, page);
        changePasek(pasek, page);
        break;
      case 'pergamin-egitto':
        rozmiar = Name(name: '15x11', displayName: '15x11');
        pasek = Name(name: 'bialy-pasek', displayName: 'Biały pasek');
        page = 0;
        changeRozmiar(rozmiar, page);
        changePasek(pasek, page);
        break;
      case 'papirus':
        rozmiar = Name(name: '12x8', displayName: '12x8');
        pasek = Name(name: 'bialy-pasek', displayName: 'Biały pasek');
        page = 0;
        changeRozmiar(rozmiar, page);
        changePasek(pasek, page);
        break;
    }
  }
}
