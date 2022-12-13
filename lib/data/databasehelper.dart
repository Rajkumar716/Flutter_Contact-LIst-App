
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dart:ui';

import 'Contact.dart';



//this is the database created classs
class DatabaseHelper{
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance=DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async =>_database ??=await _initDatabase();

  //create the database
  Future<Database> _initDatabase() async{
    Directory documentdirectory=await getApplicationDocumentsDirectory();
    String path=join(documentdirectory.path,'usercontact.db');
    return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate
    );
  }

  //create the database table
  Future  _onCreate(Database db, int version) async{
    await db.execute('''CREATE TABLE users
           (
           id INTEGER PRIMARY KEY,name TEXT,gmail TEXT,phonenumber INTEGER,address TEXT
           
            )''');
  }


  //get data from the database and display into the screen
  Future<List<Contact>> getDisplay() async{
    Database db=await instance.database;
    var contacts=await db.query('users',orderBy: 'name' );
    List<Contact> contactlist=contacts.isNotEmpty?contacts.map((e) => Contact.fromMap(e)).toList():[];
    return contactlist;
  }


  //insert the new data from the database table
  Future<int>  add(Contact contact) async{
    Database db=await instance.database;
    return await db.insert("users", contact.tomap());
  }


  //remove the specific data from the database table by id
  Future<int> remove(int id) async{
    Database db=await instance.database;
    return await db.delete("users",where: "id=?",whereArgs:[id]);
  }



  //update the specific data from the database table by id
  Future<int> update(Contact contact) async{
    Database db=await instance.database;
    return await db.update("users",contact.tomap(),where: "id=?",whereArgs: [contact.id]);

  }

  Future<List<Contact>> getsearch(String keyword) async{
    Database db=await instance.database;
    List<Map<String,dynamic>> allrows=await db.query("users",where: 'name LIKE ?',whereArgs: ['%$keyword%']);
    List<Contact> contactlist=allrows.isNotEmpty?allrows.map((e) => Contact.fromMap(e)).toList():[];
    return contactlist;
  }
}