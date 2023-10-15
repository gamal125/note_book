// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_drawing_board/view/drawing_canvas/models/sketch.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DatabaseHelper2 {
//   static final DatabaseHelper2 _instance = DatabaseHelper2._internal();
//
//   factory DatabaseHelper2() {
//     return _instance;
//   }
//
//
//
//   DatabaseHelper2._internal();
//
//
//
//
//   Database? database;
//
//   void createDatabase2(String title) async{
//     openDatabase(
//       'Subjects.db',
//       version: 1,
//       onCreate: (database, version) async {
//         print('Database3 Created ');
//         await database
//             .execute(
//             'CREATE TABLE TASKS3 (id INTEGER PRIMARY KEY , title TEXT,subject TEXT)')
//             .then((value) {
//           print('table created');
//         }).catchError((error) {
//           print('Error when to creating table ${error.toString()}');
//         });
//       },
//       onOpen: (database) {
//         getDataFromDatabase2(title);
//
//         print('Database Opened333333 ');
//       },
//     ).then((value) {
//       database=value;
//     });
//   }
//   Future<void>  insertToDatabaseSubject({
//     required String Subject,
//     required String title,
//
//
//
//   }) async {
//     final dbClient = await database;
//     final batch = dbClient!.batch();
//      batch.rawInsert('INSERT INTO TASKS3 (title,subject) Values (?,?)',[title,Subject]);
//     print(' inserted successfully');
//
//     getDataFromDatabase2(title);
//     await batch.commit(noResult: true);
//
//   }
//   Future<List<dynamic>> getDataFromDatabase2(String title) async{
//
//     List<dynamic> subjects = [];
//
//
//     database!.rawQuery('SELECT * FROM TASKS3 WHERE title = ? ',[title]).then((value) {
//       value.forEach((element) {
//
//         subjects.add(element);
//
//       }
//
//       );
//
//     });
//     return   subjects ;
//
//   }
//
//
//
//   Future<ValueNotifier<List<Sketch>>> getSketches(int i,String type,String subject) async {
//     ValueNotifier< List<Sketch>> x=ValueNotifier([]);
//     List<Map<String, Object?>> l=[];
//     await database!.rawQuery('SELECT name FROM TASK WHERE num = ? AND type = ? AND subject = ?',[i,type,subject]).then((value) {
//       l=value;
//       l.forEach((element) {element.values.forEach((e) { x=decodeValueNotifier(e.toString());});});
//
//     });
//
//     return x;
//
//   }
//   String encodeValueNotifier(ValueNotifier<List<Sketch>> valueNotifier) {
//     final jsonList = valueNotifier.value.map((sketch) => sketch.toJson()).toList();
//     return jsonEncode(jsonList);
//   }
//
//   ValueNotifier<List<Sketch>> decodeValueNotifier(String jsonString) {
//     final jsonList = jsonDecode(jsonString) as List<dynamic>;
//     final sketches = jsonList.map((json) => Sketch.fromJson(json)).toList();
//     ValueNotifier<List<Sketch>> c=ValueNotifier(sketches);
//     return c;
//   }
// }