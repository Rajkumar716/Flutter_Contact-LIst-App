import 'package:contact_list/pages/edit_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../data/Contact.dart';
import '../data/databasehelper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class AppStore extends StatefulWidget {

  const AppStore({Key? key}) : super(key: key);

  @override
  State<AppStore> createState() => _AppStoreState();
}

class _AppStoreState extends State<AppStore> {

  int? selectedid;
  final textcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[200],
      appBar: AppBar(
          backgroundColor: Colors.red[500],
          title: Text("DISPLAY ALL CONTACTS",
          style: TextStyle(
            color: Colors.white
          ),),
          centerTitle: true,
          actions: [
            IconButton(onPressed: (){
              Navigator.of(context).pushReplacementNamed('/searchpage');
            },icon:Icon(Icons.search,size: 30,))
          ],
      ),
      body: Container(
        decoration:BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/homepage.jpg"),
            fit: BoxFit.cover
          )
        ) ,
        child: Center(

          child: FutureBuilder<List<Contact>>(
            future: DatabaseHelper.instance.getDisplay(),
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
                      color: Colors.red[300],
                      child: ListTile(
                        //this code for display all data from the database table
                        title: Text('Contact Name :${contact.name}'
                            '\nContact Gmail :${contact.gmail}\nContact Phone Number :${contact.phonenumber}'
                            '\nContact Address :${contact.address}',
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
      ),
      floatingActionButton: FloatingActionButton(
      onPressed: (){
            Navigator.pushReplacementNamed(context, "/addnewcontact");
      },
        child: Icon(
          Icons.add
        ),
        backgroundColor: Colors.red[300],
    ),
    );
  }
}
