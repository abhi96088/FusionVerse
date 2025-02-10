import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var languages = ["Hindi", "English"];
  var from = "From";
  var to = "To";

  var output = "";

  TextEditingController textController = TextEditingController();

  void translate(String source, String destination, String input) async{
    GoogleTranslator translator = new GoogleTranslator();
    var translation = await translator.translate(input, from: source, to: destination);
    setState(() {
      output = translation.text.toString();
    });

    if(source == '--' || destination == '--'){
      setState(() {
        output = "Failed to translate";
      });
    }

  }

  String getLangCode(String lang){
    if(lang == "English"){
      return "en";
    }else if(lang == "Hindi"){
      return "hi";
    }

    return '--';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("FusionVerse", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15) ,
          child: Column(
            children: [
              SizedBox(height: 50,),
              Row(
                children: [
                  DropdownButton(
                    hint: Text(
                      from
                    ),
                    icon: Icon(Icons.arrow_drop_down),
                    items: languages.map((String dropDownItem){
                      return DropdownMenuItem(child: Text(dropDownItem), value: dropDownItem,);
                    }).toList(),
                    onChanged: (String? value){
                      setState(() {
                        from = value!;
                      });
                    }
                  ),
                  Spacer(),
                  Icon(Icons.arrow_right_alt, size: 40,),
                  Spacer(),
                  DropdownButton(
                      hint: Text(
                          to
                      ),
                      icon: Icon(Icons.arrow_drop_down),
                      items: languages.map((String dropDownItem){
                        return DropdownMenuItem(child: Text(dropDownItem), value: dropDownItem,);
                      }).toList(),
                      onChanged: (String? value){
                        setState(() {
                          to = value!;
                        });
                      }
                  ),
                ],
              ),
              SizedBox(height: 50,),
              TextFormField(
                controller: textController,
                decoration: InputDecoration(
                  labelText: "Plese enter  your text",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.greenAccent
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.greenAccent
                    ),
                  ),
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "please enter text to translate";
                  }
                  return null;
                },
              ),
              SizedBox(height: 50,),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                    onPressed: (){
                      translate(getLangCode(from), getLangCode(to), textController.text.toString());                        },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white
                    ),
                    child: Text("Translate")
                ),
              ),
              SizedBox(height: 50,),
              Text("\n$output")
            ],
          ),
        ),
      ),
    );
  }
}
