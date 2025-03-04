import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fusionverse/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // variable to store list of languages
  var languages = ["Hindi", "English", "Bengali", "Telugu", "Marathi", "Tamil", "Urdu", "Gujarati", "Malayalam", "Odia", "Punjabi", "Kannada", "Assamese", "Maithili"];

  // controller to get text of text field
  TextEditingController textController = TextEditingController();

  FlutterTts flutterTts = FlutterTts();   // initialized text to speech



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


  // function to speak the translated text
  void speak(BuildContext context) async {
    final toLanguage = context.read<LanguageProvider>().to;
    String output = context.read<LanguageProvider>().output;
    if (output.isNotEmpty) {
      await flutterTts.setLanguage(getLangCode(toLanguage)); // Set language
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
                    Consumer(builder: (ctx, LanguageProvider provider, _) => DropdownButton(
                      value: provider.from == "From" ? null : provider.from,
                      hint: Text(provider.from),
                      icon: Icon(Icons.arrow_drop_down),
                      items: languages.map((String dropDownItem) {
                        return DropdownMenuItem(
                          value: dropDownItem,
                          child: Text(dropDownItem),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        provider.updateFrom(value!);
                      },
                    ),
                    ),
                    //------> Swap icon button
                    IconButton(
                      icon: Icon(Icons.swap_horiz, size: 30, color: Colors.deepPurple),
                      onPressed: (){
                        final provider = context.read<LanguageProvider>();
                        if(provider.from != "From" && provider.to != "To"){
                          provider.swapLanguage();
                        }
                      }
                    ),
                    //----------> to dropdown button
                    Consumer(builder: (ctx, LanguageProvider provider, _) => DropdownButton(
                      value: provider.to == "To" ? null : provider.to,
                      hint: Text(provider.to),
                      icon: Icon(Icons.arrow_drop_down),
                      items: languages.map((String dropDownItem) {
                        return DropdownMenuItem(
                          value: dropDownItem,
                          child: Text(dropDownItem),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        provider.updateTo(value!);
                      },
                    ),
                    )
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
                    var provider = context.read<LanguageProvider>();
                    provider.translate(getLangCode(provider.from), getLangCode(provider.to), textController.text.toString().trim());
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
                      child: Consumer<LanguageProvider>(builder: (_, provider, __) => Text(
                        provider.output.isEmpty ? "Your translated text will appear here." : provider.output,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),)
                    ),
                   Consumer<LanguageProvider>(builder: (_, provider, __){
                     return provider.output.isNotEmpty ? IconButton(
                         onPressed: () => speak(context),
                         icon: Icon(Icons.volume_up, size: 30, color: Colors.deepPurple,)) : SizedBox();
                   })
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
