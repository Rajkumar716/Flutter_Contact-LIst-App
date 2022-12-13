import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/Contact.dart';
import '../data/databasehelper.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController _nameController=TextEditingController();
  TextEditingController _gmailController=TextEditingController();
  TextEditingController _phonenumberController=TextEditingController();
  TextEditingController _addressController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: Text("ADD NEW CONTACT",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/displaydata');
          },
          child: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body:Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/addcover.jpg"),
            fit: BoxFit.cover
          )
        ),
        child: Center(
          child: Column(

            children: <Widget>[
              SizedBox(height: 10,),
              Text("ADD DETAILS",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white
              ),),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 4, 10, 5),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 4, 10, 5),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _gmailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Gmail'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 4, 10, 5),
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
                padding: const EdgeInsets.fromLTRB(10, 2, 10, 5),
                child: TextField(

                  controller: _addressController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Addess'),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(10,2, 10, 0),
                  child: SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: ()async{
                          Fluttertoast.showToast(
                              msg: "CONTACT CREATE SUCCESSFULLY......",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.purple[200],
                              textColor: Colors.black,
                              fontSize: 16.0
                          );
                          await DatabaseHelper.instance.add(Contact(name: _nameController.text, gmail: _gmailController.text,
                              phonenumber: int.parse(_phonenumberController.text), address: _addressController.text));
                          setState(() {
                            _nameController.clear();
                            _gmailController.clear();
                            _phonenumberController.clear();
                            _addressController.clear();
                            Navigator.of(context).pushReplacementNamed('/displaydata');
                          });
                      },
                      child: Text('CREATE CONTACT'),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.purple)
                      ),
                    ),
                  )
              ),

            ],
          ),
        ),
      ),
    );
  }
}