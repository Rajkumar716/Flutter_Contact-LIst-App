import 'package:contact_list/pages/add_new_contact.dart';
import 'package:contact_list/pages/edit_page.dart';
import 'package:contact_list/pages/homepage.dart';
import 'package:contact_list/pages/search_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp (MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/displaydata':(context)=>AppStore(),
      '/addnewcontact':(context)=>AddData(),
      '/editpage':(context)=>EditPage(),
      '/searchpage':(context)=>SearchPage()
    },
    home: AppStore(),
  ));
}

