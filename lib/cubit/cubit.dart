// ignore_for_file: unnecessary_string_interpolations, non_constant_identifier_names, curly_braces_in_flow_control_structures, empty_statements, avoid_print, null_check_always_fails
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_drawing_board/cubit/states.dart';
import 'package:sqflite/sqflite.dart';




class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [

  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void ChangeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  Database? database;
  Database? database2;
  List<dynamic> title = [];
  List<dynamic> subjects = [];


  // Create Database ()
  void createDatabase(String year) {
    openDatabase(
      'Todo.db',
      version: 1,
      onCreate: (database, version) async {
        print('Database Created ');
        await database
            .execute(
                'CREATE TABLE TASKS (id INTEGER PRIMARY KEY , title TEXT,year TEXT,lang TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error when to creating table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database,year);

        print('Database Opened2 ');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }
  void createDatabase2(String title,String year)  {
    openDatabase(
      'Subjects.db',
      version: 1,
      onCreate: (database, version) async {
        print('Database3 Created ');
        await database
            .execute(
            'CREATE TABLE TASKS3 (id INTEGER PRIMARY KEY , title TEXT,subject TEXT,year TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error when to creating table ${error.toString()}');
        });
      },
      onOpen: (database) {
        database2 = database;
        getDataFromDatabase2(database,title,year);
        print(subjects);
        print('Database Opened333333 ');


      },
    ).then((value) {
      database2 = value;

      emit(AppCreateDatabaseState());
    });

  }

  // Insert Into Database ()
  insertToDatabase({
    required String title,
    required String year,
    required String lang,
  }) async {
    await database!.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO TASKS (title,year,lang) Values (?, ?,?)',[title,year,lang])
          .then((value) {
        print('$value inserted succesfully');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database,year);
      }).catchError((error) {
        print('Error when to inserting New Record  ${error.toString()}');
      });
    });
  }
  insertToDatabaseSubject({
    required String Subject,
    required String title,
    required String year,



  }) async {

      await database2!.transaction((txn) {
      return txn
          .rawInsert(
      'INSERT INTO TASKS3 (title,subject,year) Values (?,?,?)',[title,Subject,year])
          .then((value) {
      print('$value inserted succesfully');
      emit(AppInsertDatabaseState2());
      getDataFromDatabase2(database2,title, year);
      }).catchError((error) {
      print('Error when to inserting New Record  ${error.toString()}');
      });
      });



  }

  void getDataFromDatabase(database, String year) {
    title = [];


    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM TASKS WHERE year = ?',[year]).then((value) {
      value.forEach((element) {

          title.add(element);

      },

      );

      emit(AppGetDatabaseState());
    });

  }
 void getDataFromDatabase2(database,String title,String year) {
    subjects = [];

    emit(AppGetDatabaseLoadingState2());

       database.rawQuery('SELECT * FROM TASKS3 WHERE title = ? AND year = ? ', [title,year]).then((value) {
        value.forEach((element) {
          subjects.add(element);
        }
        );
        print(subjects);
        emit(AppGetDatabaseState2(subjects));

      });


  }
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  // void UpdateData({
  //   required String status,
  //   required int id,
  // }) {
  //   database!.rawUpdate(
  //     'UPDATE tasks SET status = ? WHERE id = ?',
  //     ['$status', id],
  //   ).then((value) {
  //     getDataFromDatabase(database);
  //     emit(AppUpdateDatabaseState());
  //   });
  // }

  void DeleteData({
    required int id,
    required String year,
  }) {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database,year);
      emit((AppDeleteDatabaseState()));
    });
  }
  void DeleteData2({
    required int id,
    required String title,
    required String year,

  }) {
    database2!.rawDelete('DELETE FROM TASKS3 WHERE id = ?', [id]).then((value) {
      getDataFromDatabase2(database2, title,year);
      print("done");
      emit((AppDeleteDatabaseState()));
    });
  }

}
