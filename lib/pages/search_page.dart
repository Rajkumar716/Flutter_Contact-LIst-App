import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../data/Contact.dart';
import '../data/databasehelper.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String keyword="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),

          ),
          child: Center(
            child: TextField(
              decoration: InputDecoration(
                   prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),),
              onChanged: (value) {
                keyword = value;
                setState(() {

                });
              },
            ),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/displaydata');
          },
          child: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Center(

        child: FutureBuilder<List<Contact>>(
          future: DatabaseHelper.instance.getsearch(keyword),
          builder: (BuildContext context,AsyncSnapshot<List<Contact>> sanpshot){
            if(!sanpshot.hasData){
              return Center(
                child: SpinKitFadingCircle(
                  color: Colors.black,
                  size: 80.0,

                ),
              );
            }
            return sanpshot.data!.isEmpty?Center(
              child: Text("There are no Contact List.."),
            ) :ListView(
              children:sanpshot.data!.map((contact){
                return Center(
                  child: Card(
                    color: Colors.purple[500],
                    child: ListTile(
                      //this code for display all data from the database table
                      title: Text('Contact Name :${contact.name}\nContact Gmail :${contact.gmail}\nContact Phone Number :${contact.phonenumber}\nContact Address :${contact.address}',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 18
                        ),),
                      onTap: ()async{
                        await  Navigator.pushReplacementNamed(context, "/editpage",arguments: {
                          'id':contact.id,
                          'name':contact.name,
                          'gmail':contact.gmail,
                          'phonenumber':contact.phonenumber,
                          'address':contact.address
                        });

                      },

                      onLongPress: (){
                        Fluttertoast.showToast(
                            msg: "CONTACT DELETE SUCCESSFULLY......",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.purple[200],
                            textColor: Colors.black,
                            fontSize: 16.0
                        );
                        setState(() {
                          //this code for delete the specific data from the database table by id
                          DatabaseHelper.instance.remove(contact.id!);

                        });
                      },
                    ),
                  ),

                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
