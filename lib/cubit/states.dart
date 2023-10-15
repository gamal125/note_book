abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBottomNavBarState extends AppStates {}

class AppCreateDatabaseState extends AppStates{}

class AppInsertDatabaseState extends AppStates{}
class AppInsertDatabaseState2 extends AppStates{}
class AppGetDatabaseLoadingState2 extends AppStates{}


class AppGetDatabaseState extends AppStates{

}
class AppGetDatabaseState2 extends AppStates{
  final List<dynamic> subjects;
  AppGetDatabaseState2(this.subjects);
}

class AppGetDatabaseLoadingState extends AppStates{}

class AppUpdateDatabaseState extends AppStates{}

class AppDeleteDatabaseState extends AppStates{}

class AppChangeBottomSheetState extends AppStates {}

class AppChangeModeState extends AppStates {}