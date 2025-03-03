import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // variable to store list of languages
  var languages = ["Hindi", "English", "Bengali", "Telugu", "Marathi", "Tamil", "Urdu", "Gujarati", "Malayalam", "Odia", "Punjabi", "Kannada", "Assamese", "Maithili"];
  var from = "From";  // value at from dropdown
  var to = "To";  // value at to dropdown
  var output = "";  // variable to store output

  // controller to get text of text field
  TextEditingController textController = TextEditingController();

  FlutterTts flutterTts = FlutterTts();   // initialized text to speech

  // function to translate the entered text
  void translate(String source, String destination, String input) async {
    GoogleTranslator translator = GoogleTranslator();   // initialize google translator
    var translation = await translator.translate(input, from: source, to: destination); // translate the text
    setState(() {
      output = translation.text.toString();   // set translated text as output
    });

    // check if language not provided
    if (source == '--' || destination == '--') {
      setState(() {
        output = "Failed to translate";
      });
    }
  }

  // function to get language code
  String getLangCode(String lang) {
    if (lang == "English") {
      return "en";
    } else if (lang == "Hindi") {
      return "hi";
    } else if (lang == "Bengali") {
      return "bn";
    } else if (lang == "Telugu") {
      return "te";
    } else if (lang == "Marathi") {
      return "mr";
    } else if (lang == "Tamil") {
      return "ta";
    } else if (lang == "Urdu") {
      return "ur";
    } else if (lang == "Gujarati") {
      return "gu";
    } else if (lang == "Malayalam") {
      return "ml";
    } else if (lang == "Odia") {
      return "or";
    } else if (lang == "Punjabi") {
      return "pa";
    } else if (lang == "Kannada") {
      return "kn";
    } else if (lang == "Assamese") {
      return "as";
    } else if (lang == "Maithili") {
      return "mai";
    }
    return '--';
  }

  // function to swap language vales of from and to when clicked on swap icon
  void swapLanguages() {
    if (from != "From" && to != "To") {
      setState(() {
        var temp = from;
        from = to;
        to = temp;
      });
    }
  }

  // function to speak the translated text
  void speak() async {
    if (output.isNotEmpty) {
      await flutterTts.setLanguage(getLangCode(to)); // Set language
      await flutterTts.setPitch(1.0); // Adjust pitch (1.0 = normal)
      await flutterTts.speak(output); // Speak the translated text
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("FusionVerse Translator", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              ///@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ from - to dropdowns @@@@@@@@@@@@@@@@@@@@@@@@@@///
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //----------> from dropdown button
                    DropdownButton(
                      value: from == "From" ? null : from,
                      hint: Text(from),
                      icon: Icon(Icons.arrow_drop_down),
                      items: languages.map((String dropDownItem) {
                        return DropdownMenuItem(
                          value: dropDownItem,
                          child: Text(dropDownItem),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          from = value!;
                        });
                      },
                    ),
                    //------> Swap icon button
                    IconButton(
                      icon: Icon(Icons.swap_horiz, size: 30, color: Colors.deepPurple),
                      onPressed: (from != "From" && to != "To") ? swapLanguages : null,
                    ),
                    //----------> to dropdown button
                    DropdownButton(
                      value: to == "To" ? null : to,
                      hint: Text(to),
                      icon: Icon(Icons.arrow_drop_down),
                      items: languages.map((String dropDownItem) {
                        return DropdownMenuItem(
                          value: dropDownItem,
                          child: Text(dropDownItem),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          to = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ///@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ text field to take text to translate @@@@@@@@@@@@@@@@@@@@@@@@///
              TextField(
                controller: textController,
                decoration: InputDecoration(
                  labelText: "Enter text to translate",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              ///@@@@@@@@@@@@@@@@@@@@@@@@@@ translate button @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@///
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    translate(getLangCode(from), getLangCode(to), textController.text.trim());
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text("Translate", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
              SizedBox(height: 20),
              ///@@@@@@@@@@@@@@@@@@@@@@@ container to show translated text @@@@@@@@@@@@@@@@@@@///
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        output == "" ? "Your translated text will appear here." : output,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    if (output.isNotEmpty) // Show button only if there's text
                      // show an speaker button to read aloud the translated text
                      IconButton(
                        icon: Icon(Icons.volume_up, size: 30, color: Colors.deepPurple),
                        onPressed: speak,
                      ),
                  ],
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
