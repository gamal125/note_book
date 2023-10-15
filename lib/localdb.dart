import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_drawing_board/view/drawing_canvas/models/sketch.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }



  DatabaseHelper._internal();




  Database? database;

 void createDatabase() async {
    openDatabase(
      'tables.db',
      version: 1,
      onCreate: (database, version) async {
        print('Database Created ');
        await database
            .execute(
            'CREATE TABLE TASK (id INTEGER PRIMARY KEY , name TEXT, num INTEGER, type TEXT,subject TEXT,year TEXT,date TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error when to creating table ${error.toString()}');
        });
      },
      onOpen: (database) {


        print('Database Opened ');
      },
    ).then((value) {
      database = value;

    });
  }

  Future<void> insertSketches(ValueNotifier< List<Sketch>> sketches,int i,String type,String subject,String year,String date) async {
    final dbClient = await database;
    final batch = dbClient!.batch();
    String x=encodeValueNotifier(sketches);

    batch.rawInsert('INSERT INTO TASK(name, num, type, subject, year,date) VALUES(?, ?, ?, ?, ?, ?)', [x,i,type,subject,year,date]);

    print('done');

    await batch.commit(noResult: true);
  }
  Future<void> deleteLastItemFromDatabase(String type,int i,String subject,String year) async {
    // Get the path to the database


    // Query for the last item
    List<Map<String, dynamic>> items = await database!.query(
      'TASK',
      where: 'type = ? AND num = ? AND subject = ? AND year = ?',
      whereArgs: [type, i, subject,year],
      orderBy: 'id DESC',
      limit: 1,
    );

    if (items.isNotEmpty) {
      // Delete the last item
      await database!.delete(
        'TASK',
        where: 'id = ?',
        whereArgs: [items.first['id']],
      );
    }

    // Close the database
  }
  Future<void> deleteAllItemFromDatabase(String type,int i,String subject,String year) async {
    // Get the path to the database


    // Query for the last item
    await database!.delete(
      'TASK',
      where: 'type = ? AND num = ? AND subject = ? AND year = ?',
      whereArgs: [type, i, subject, year],
    );

    // Close the database
  }
  Future<List<int>> search(String type, String subject, String year, String date) async {
    List<int> index = [];
    List<Map<String, Object?>> results = await database!.rawQuery(
      'SELECT num FROM TASK WHERE type = ? AND subject = ? AND year = ? AND date = ?',
      [type, subject, year, date],
    );

    results.forEach((row) {
      int num = row['num'] as int;
      if (!index.contains(num)) {
        index.add(num);
      }
    });

    return index;
  }

  Future<ValueNotifier<List<Sketch>>> getSketches(int i,String type,String subject,String year) async {
    ValueNotifier< List<Sketch>> x=ValueNotifier([]);
    List<Map<String, Object?>> l=[];
   await database!.rawQuery('SELECT name FROM TASK WHERE num = ? AND type = ? AND subject = ? AND year = ?',[i,type,subject,year]).then((value) {
      l=value;
      l.forEach((element) {element.values.forEach((e) { x=decodeValueNotifier(e.toString());});});

    });

    return x;

  }
  String encodeValueNotifier(ValueNotifier<List<Sketch>> valueNotifier) {
    final jsonList = valueNotifier.value.map((sketch) => sketch.toJson()).toList();
    return jsonEncode(jsonList);
  }

  ValueNotifier<List<Sketch>> decodeValueNotifier(String jsonString) {
    final jsonList = jsonDecode(jsonString) as List<dynamic>;
    final sketches = jsonList.map((json) => Sketch.fromJson(json)).toList();
    ValueNotifier<List<Sketch>> c=ValueNotifier(sketches);
    return c;
  }
}