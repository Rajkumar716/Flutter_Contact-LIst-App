import 'package:contact_list/data/Contact.dart';
import 'package:contact_list/data/databasehelper.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';


class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  Map data={};
  TextEditingController _nameController=TextEditingController();
  TextEditingController _gmailController=TextEditingController();
  TextEditingController _phonenumberController=TextEditingController();
  TextEditingController _addressController=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    data=ModalRoute.of(context)?.settings.arguments as Map;
    print(data);
    _nameController.text=data['name'];
    _gmailController.text=data['gmail'];
    _phonenumberController.text=data['phonenumber'].toString();
    _addressController.text=data['address'];

    return Scaffold(

      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: Text('EDIT DETAILS'),
        centerTitle: true,
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pushReplacementNamed('/displaydata');
          },
          child: Icon(
            Icons.arrow_back, // add custom icons also
          ),
        ),
      ),
      body: Stack(
        children:[
          Container(
            decoration:BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/editcover2.jpg"),
                fit: BoxFit.cover
              )
            ) ,
          ),

          SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 30,),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/edit4.png'),
                  radius: 60,
                ),
                SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.only(top: 5,right: 10,left: 10),
                  child: TextField(

                    controller: _nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Name'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5,right: 10,left: 10),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _gmailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Gmail'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5,right: 10,left: 10),
                  child: TextField(
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: _phonenumberController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Phone Number'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5,right: 10,left: 10),
                  child: TextField(
                    controller: _addressController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Address'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5,right: 10,left: 10),
                  child: SizedBox(
                    width: 100,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: ()async{
                        Fluttertoast.showToast(
                            msg: "CONTACT EDIT SUCCESSFULLY......",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.purple[200],
                            textColor: Colors.black,
                            fontSize: 16.0
                        );
                          await DatabaseHelper.instance.update(Contact(id:data['id'],name: _nameController.text,
                              gmail: _gmailController.text, phonenumber: int.parse(_phonenumberController.text),
                              address: _addressController.text));
                          await Navigator.of(context).pushReplacementNamed('/displaydata');
                      },
                      child: Text('EDIT'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.purple)
                      ),
                    ),
                  )
                ),
              ],
            ),
          ),
        )]
      ),

    );;
  }
}
