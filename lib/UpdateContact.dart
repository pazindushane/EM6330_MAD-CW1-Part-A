import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Model.dart';
import 'db_help.dart';

class UpdateContact extends StatelessWidget {
  const UpdateContact(this.id,this.name,this.number,this.email,this.imagePath,{Key? key}) : super(key: key);
  final int ?id;
  final String name;
  final String number;
  final String ?email;
  final String imagePath;

  @override
  Widget build(BuildContext context) {

    final name1 = TextEditingController(text:name);
    final number1 = TextEditingController(text: number);
    final email1 = TextEditingController(text: email);

    return Scaffold(
        appBar: AppBar(
          title: Text('Update Screen'),
            backgroundColor: Colors.orange
        ),
        body: Container(
            padding: const EdgeInsets.only(top: 10.0,left: 20.0,right: 30.0,bottom: 10.0),
            child: Column(
              children: [
                Container(
                  child: SizedBox(
                      child:Image.file(File(imagePath),fit: BoxFit.cover,width: 90,height: 90,)
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: name1,
                  //initialValue: widget.name,
                  cursorColor: Colors.green,
                  decoration: const InputDecoration(
                    labelText: 'Contact Name',
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.person,color: Colors.green,),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  //initialValue: widget.number,
                  controller: number1,
                  cursorColor: Colors.green,

                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.phone,color: Colors.green,),
                    labelText: 'Contact Number',
                    border: OutlineInputBorder(),

                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  //initialValue: widget.email,
                  controller: email1,
                  cursorColor: Colors.green,

                  decoration:  const InputDecoration(
                    icon: Icon(Icons.email,color: Colors.green,),
                    labelText: 'Contact Email',
                    border: OutlineInputBorder(),

                  ),
                ),
                SizedBox(height: 30),
                TextButton(
                  onPressed: () async {
                    await Db_help.instance.update(
                        Model(
                            id: id,
                            name: name1.text,
                            number: number1.text,
                            email: email1.text,
                            imgPath:imagePath
                        )
                    );

                    name1.clear();
                    number1.clear();
                    email1.clear();
                    Navigator.pop(context, true);
                    // ToastError01();

                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    primary: Colors.white,
                    backgroundColor: Colors.orange,
                    onSurface: Colors.grey,
                    elevation: 5,
                  ),
                  child:  const Text('Update'),
                )
              ],
            )
        )
    );
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
