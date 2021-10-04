import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mofakera/Screen/home_screen.dart';
import 'package:mofakera/helper/helper_note.dart';
import '../constant.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class DiscScreen extends StatefulWidget {
  @override
  _DiscScreenState createState() => _DiscScreenState();
}

class _DiscScreenState extends State<DiscScreen> {
  String? Title, description;

  Note note = Note();

  DateTime selectedDate = DateTime.now();


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2021, 11));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Color currentColor = primarydarkcolor;

  void changeColor(Color color) => setState(() => currentColor = color);

  String changeColorToString(){
    String colorString = currentColor.toString();
    return colorString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add ToDo",
          style: TextStyle(
            color: textcolor,
            fontSize: fontLarge,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: textcolor,
            size: 25,
          ),
        ),
        backgroundColor: primarydarkcolor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(RadiusCircular),
          bottomRight: Radius.circular(RadiusCircular),
        )),
      ),
      backgroundColor: primarycolor,
      body: Padding(
        padding: const EdgeInsets.all(DPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Title",
                  labelStyle: TextStyle(color: green),
                  hintText: "Enter Title",
                  contentPadding: EdgeInsets.all(DPadding),
                  helperStyle: TextStyle(color: primarydarkcolor),
                  fillColor: primarydarkcolor,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(DPadding)),
                      borderSide:
                          BorderSide(color: primarydarkcolor, width: 0.5)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(DPadding)),
                      borderSide:
                          BorderSide(color: primarydarkcolor, width: 0.5)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(DPadding)),
                      borderSide:
                          BorderSide(color: primarydarkcolor, width: 0.5)),
                ),
                onChanged: (value) {
                  setState(() {
                    Title = value;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                maxLines: 8,
                decoration: const InputDecoration(
                  labelText: "Note",
                  labelStyle: TextStyle(color: green),
                  hintText: "Enter Note",
                  contentPadding: EdgeInsets.all(DPadding),
                  helperStyle: TextStyle(color: primarydarkcolor),
                  fillColor: primarydarkcolor,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(DPadding)),
                      borderSide:
                          BorderSide(color: primarydarkcolor, width: 0.5)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(DPadding)),
                      borderSide:
                          BorderSide(color: primarydarkcolor, width: 0.5)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(DPadding)),
                      borderSide:
                          BorderSide(color: primarydarkcolor, width: 0.5)),
                ),
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _selectDate(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: primarydarkcolor,
                  ),
                  icon: const Icon(
                    Icons.date_range,
                    size: 18,
                    color: textcolor,
                  ),
                  label: const Text(
                    "Set Date",
                    style: TextStyle(color: textcolor, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Select a color'),
                          content: SingleChildScrollView(
                            child: BlockPicker(
                              pickerColor: currentColor,
                              onColorChanged: changeColor,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const Text(
                    'Select color of your note',
                    style: TextStyle(
                      color: textcolor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: currentColor,
                    elevation: 3,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  note.insertdb({
                    "title": Title,
                    "description": description,
                    "date": "${selectedDate.toLocal()}".split(' ')[0],
                    "color": changeColorToString(),
                    "done": "not done"
                  });
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return const HomeScreen();
                  }));
                },
                style: ElevatedButton.styleFrom(
                  primary: primarydarkcolor,
                ),
                icon: const Icon(
                  Icons.add,
                  size: 18,
                  color: textcolor,
                ),
                label: const Text(
                  "ADD",
                  style: TextStyle(color: textcolor, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
