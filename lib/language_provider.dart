import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageProvider extends ChangeNotifier{

  String _from = "From";  // value at from dropdown
  String _to = "To";  // value at to dropdown
  String _output = "";  // variable to store output


  String get from => _from;
  String get to => _to;
  String get output => _output;

  void updateFrom(String newFrom){
    _from = newFrom;
    notifyListeners();
  }

  void updateTo(String newTo){
    _to = newTo;
    notifyListeners();
  }

  void swapLanguage(){
    if(_from != "From" && _to != "To"){
      var temp = _from;
      _from = _to;
      _to = temp;
      notifyListeners();
    }
  }

  // function to translate the entered text
  void translate(String source, String destination, String input) async {
    // check if language not provided
    if (source == '--' || destination == '--') {
      _output = "Failed to translate";
    }else{
      GoogleTranslator translator = GoogleTranslator();   // initialize google translator
      var translation = await translator.translate(input, from: source, to: destination); // translate the text
      _output = translation.text.toString();   // set translated text as output
    }
    notifyListeners();
  }

}