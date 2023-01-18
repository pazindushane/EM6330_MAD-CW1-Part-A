import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

import 'Model.dart';
import 'db_help.dart';
class SaveContact extends StatefulWidget {
  const SaveContact({Key? key}) : super(key: key);

  @override
  State<SaveContact> createState() => _SaveContactState();
}

class _SaveContactState extends State<SaveContact> {
  final name = TextEditingController();
  final number = TextEditingController();
  final email = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _image;
  late String imagetemPath;

  get child => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text('Save Contact'),
          backgroundColor: Colors.green
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10),

            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      // Image radius
                      width: 100,
                      height: 100,
                      child: _image != null
                          ? Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      )
                          : Container(
                        color: Colors.grey[300],
                      ),
                    ),

                    TextButton(
                        onPressed: () {
                          _onImage();
                        },
                        child: const Text("Upload Photo"))
                  ],
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: name,
                  cursorColor: Colors.green,
                  decoration: const InputDecoration(
                    labelText: 'Contact Name',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.man,color: Colors.blue,),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: number,
                  cursorColor: Colors.green,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Contact Number',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.phone,color: Colors.blue,),
                  ),
                ),
                SizedBox(height: 20),
                  TextFormField(
                  controller: email,
                  cursorColor: Colors.green,
                  
                  decoration: const InputDecoration(
                    labelText: 'Contact Email',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.email,color: Colors.blue,),
                  ),
                ),
                SizedBox(height: 30),
                TextButton(
                  onPressed: () async {
                    await Db_help.instance.add(Model(
                      name: name.text,
                      number: number.text,
                      email: email.text,
                      imgPath: imagetemPath,
                    ));
                    setState(() {
                      name.clear();
                      number.clear();
                      email.clear();

                      Navigator.pop(context, true);
                    });
                    // ToastError01();
                  },
                  child: Text('Save User'),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    primary: Colors.white,
                    backgroundColor: Colors.green,
                    onSurface: Colors.grey,
                  ),

                )
              ],
            )));
  }

  Future _onImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image=File(image!.path);
      this.imagetemPath = image!.path;
    });
    print(imagetemPath);
  }

  ToastError01(){
    Fluttertoast.showToast(
        msg: "Inavlid email",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
