import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Model.dart';
import 'SaveContact.dart';
import 'UpdateContact.dart';
import 'db_help.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    routes: <String, WidgetBuilder>{
      '/save':(context) => const SaveContact(),
      // '/searchPage': (context) => SearchPage(),
    },
    home: App(),
  ));
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);


  @override
  State<App> createState() => _MyAppState();
}

class _MyAppState extends State<App> {
  // Db_help db_help = Db_help();
  late String keyword;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Contact'),
        backgroundColor: Colors.green
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child:

              FutureBuilder<List<Model>>(
                  future: Db_help.instance.getUsers(),
                  builder: (BuildContext context, AsyncSnapshot <List<Model>> snapshot){
                    if(!snapshot.hasData){
                      return const Center(child: Text('Loading...'));
                    }
                    return snapshot.data!.isEmpty
                        ?const Center(child: Text('No Data..'))
                        :ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.map((contacts) {
                        return Center(
                          child: ListTile(
                            leading:SizedBox(
                              child: Image.file(File(contacts.imgPath!), fit: BoxFit.cover,width: 50,height: 50,),
                            ),
                            subtitle: Text(contacts.number),
                            title: Text(contacts.name),
                            onLongPress: (){
                              Delete(contacts.id!);
                            },
                            onTap: (){
                              Update(context,contacts.id,contacts.name,contacts.number,contacts.email,contacts.imgPath);
                            },
                          ),
                        );

                      }).toList(),
                    );
                  }
              ),

            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton (


        onPressed: (){
          saveFunction(context);
        },
        // icon: Icon(Icons.save),
        // label: Text("Save"),
        backgroundColor: Colors.green,
        child: Text("Add"),
      ),
    );
  }

  saveFunction(BuildContext context) async {
    final reLoadPage = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          SaveContact()
      ),
    );

    if (reLoadPage) {
      setState(() {});
    }
    ToastSave();
  }

  // Delete(int id) async {
  //   await Db_help.instance.delete(id);
  //   setState(() {});
  //   ToastDelete();
  // }
  Update(BuildContext context,int ?id,String name,String number,String ?email,String ?imagePath) async {
    final reLoadPage = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateContact(id,name,number,email,imagePath!)),
    );

    if (reLoadPage) {
      setState(() {});
    }
    ToastUpdate();
  }

  ToastSave(){
    Fluttertoast.showToast(
        msg: "User Successfully Saved",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  ToastDelete(){
    Fluttertoast.showToast(
        msg: "User Successfully Deleted",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  ToastError01(){
    Fluttertoast.showToast(
        msg: "Inavlid Inputs",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  Delete(int id) {
    Widget cancelButton = TextButton(
      child: Text('Cancel'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget deleteButton = TextButton(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(color: Colors.red),
      ),
      child: Text('Delete'),
      onPressed: () async {
        await Db_help.instance.delete(id);
        setState(() {});
        ToastDelete();
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert= AlertDialog(
      title: Text('Delete contact?'),
      content: Text('Are you sure you want to delete this contact?'),
      actions: <Widget>[
        cancelButton,
        deleteButton
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        }
    );

  }

  ToastUpdate(){
    Fluttertoast.showToast(
        msg: "User Successfully Updated",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.orangeAccent,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
