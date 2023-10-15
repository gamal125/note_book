
import 'package:bloc/bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_drawing_board/view/drawing_canvas/models/cache_helper.dart';
import 'package:flutter_drawing_board/view/drawing_page.dart';

import 'components/components.dart';
import 'cubit/bloc_observer.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'localdb.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer= MyBlocObserver();

  await CacheHelper.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Allow portrait orientation
    DeviceOrientation.landscapeLeft, // Allow landscape left orientation
    DeviceOrientation.landscapeRight, // Allow landscape right orientation
  ]);
    runApp(const MyApp());

}

const Color kCanvasColor = Color(0xfff2f3f7);
const String kGithubRepo = '';
class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {

          return  Scaffold(
            appBar: AppBar(title: Center(child: Text('اختار اللغه',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),)),elevation: 0,backgroundColor: Colors.white,),
            body: SafeArea(

              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap:(){
            CacheHelper.saveData(key: 'language', value: 'عبري');
            navigateTo(context, YearsScreen());},

                      child: Card(

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        clipBehavior: Clip.none,
                        elevation: 20.0,
                        color: Colors.yellow,
                        margin: const EdgeInsetsDirectional.all(20),
                        child: const SizedBox(
                          height: 80,
                          child: Row(
                            children: [

                              SizedBox(
                                width: 20.0,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'שפה עברית',
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap:(){
                        CacheHelper.saveData(key: 'language', value: 'عربي');

                        navigateTo(context, YearsScreen());
                        },

                      child: Card(

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        clipBehavior: Clip.none,
                        elevation: 20.0,
                        color: Colors.yellow,
                        margin: const EdgeInsetsDirectional.all(20),
                        child: const SizedBox(
                          height: 80,
                          child: Row(
                            children: [

                              SizedBox(
                                width: 20.0,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'اللغه العربيه',
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );

        },

    );
  }

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DatabaseHelper? database=DatabaseHelper();
    database.createDatabase();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AppCubit()
           ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {

          return   const MaterialApp(
            debugShowCheckedModeBanner: false,
            // theme: lightTheme,
            // darkTheme: darkTheme,
            // themeMode:
            //     AppCubit.get(context).isDark ? ThemeMode.light : ThemeMode.dark,
            home: MyApp2(),
          );
        },
      ),
    );
  }

}
class YearsScreen extends StatelessWidget {
   YearsScreen({super.key});
     String language=CacheHelper.getData(key: 'language');
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions:  [

          Padding(
            padding: EdgeInsets.only(right: 38.0,top: 8),
            child: language=='عربي'? Text(
              'الصفوف الدراسيه',
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ):Text(
              'שיעורים',
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
  body: SafeArea(
    child: Container(
      decoration: const BoxDecoration(

      ),
      width: double.maxFinite,
      height: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.only(right: 18.0,),
        child: SingleChildScrollView(
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap:(){ navigateTo(context,subjectsScreen(year:'1' ));},
                  child: Card(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    clipBehavior: Clip.none,
                    elevation: 20.0,
                    color: Colors.yellow,
                    margin: const EdgeInsetsDirectional.all(20),
                    child: const SizedBox(
                      height: 80,
                      child: Row(
                        children: [

                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '1',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap:(){ navigateTo(context,subjectsScreen(year:'2' ));},
                  child: Card(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    clipBehavior: Clip.none,
                    elevation: 20.0,
                    color: Colors.yellow,
                    margin: const EdgeInsetsDirectional.all(20),
                    child: const SizedBox(
                      height: 80,
                      child: Row(
                        children: [

                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '2',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap:(){ navigateTo(context,subjectsScreen(year:'3' ));},
                  child: Card(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    clipBehavior: Clip.none,
                    elevation: 20.0,
                    color: Colors.yellow,
                    margin: const EdgeInsetsDirectional.all(20),
                    child: const SizedBox(
                      height: 80,
                      child: Row(
                        children: [

                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '3',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap:(){ navigateTo(context,subjectsScreen(year:'4' ));},
                  child: Card(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    clipBehavior: Clip.none,
                    elevation: 20.0,
                    color: Colors.yellow,
                    margin: const EdgeInsetsDirectional.all(20),
                    child: const SizedBox(
                      height: 80,
                      child: Row(
                        children: [

                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '4',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap:(){ navigateTo(context,subjectsScreen(year:'5' ));},
                  child: Card(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    clipBehavior: Clip.none,
                    elevation: 20.0,
                    color: Colors.yellow,
                    margin: const EdgeInsetsDirectional.all(20),
                    child: const SizedBox(
                      height: 80,
                      child: Row(
                        children: [

                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '5',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap:(){ navigateTo(context,subjectsScreen(year:'4' ));},
                  child: Card(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    clipBehavior: Clip.none,
                    elevation: 20.0,
                    color: Colors.yellow,
                    margin: const EdgeInsetsDirectional.all(20),
                    child: const SizedBox(
                      height: 80,
                      child: Row(
                        children: [

                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '6',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap:(){ navigateTo(context,subjectsScreen(year:'7' ));},
                  child: Card(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    clipBehavior: Clip.none,
                    elevation: 20.0,
                    color: Colors.yellow,
                    margin: const EdgeInsetsDirectional.all(20),
                    child: const SizedBox(
                      height: 80,
                      child: Row(
                        children: [

                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '7',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap:(){ navigateTo(context,subjectsScreen(year:'8' ));},
                  child: Card(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    clipBehavior: Clip.none,
                    elevation: 20.0,
                    color: Colors.yellow,
                    margin: const EdgeInsetsDirectional.all(20),
                    child: const SizedBox(
                      height: 80,
                      child: Row(
                        children: [

                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '8',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap:(){ navigateTo(context,subjectsScreen(year:'9' ));},
                  child: Card(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    clipBehavior: Clip.none,
                    elevation: 20.0,
                    color: Colors.yellow,
                    margin: const EdgeInsetsDirectional.all(20),
                    child: const SizedBox(
                      height: 80,
                      child: Row(
                        children: [

                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '9',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap:(){ navigateTo(context,subjectsScreen(year:'10' ));},
                  child: Card(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    clipBehavior: Clip.none,
                    elevation: 20.0,
                    color: Colors.yellow,
                    margin: const EdgeInsetsDirectional.all(20),
                    child: const SizedBox(
                      height: 80,
                      child: Row(
                        children: [

                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '10',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap:(){ navigateTo(context,subjectsScreen(year:'11' ));},
                  child: Card(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    clipBehavior: Clip.none,
                    elevation: 20.0,
                    color: Colors.yellow,
                    margin: const EdgeInsetsDirectional.all(20),
                    child: const SizedBox(
                      height: 80,
                      child: Row(
                        children: [

                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '11',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap:(){ navigateTo(context,subjectsScreen(year:'12' ));},
                  child: Card(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    clipBehavior: Clip.none,
                    elevation: 20.0,
                    color: Colors.yellow,
                    margin: const EdgeInsetsDirectional.all(20),
                    child: const SizedBox(
                      height: 80,
                      child: Row(
                        children: [

                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '12',
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),

            ],),
          ),
        ),
      ),),
  ),
    );
  }

}
class sectionsScreen extends StatelessWidget {
  sectionsScreen({Key? key,required this.title,required this.year,required this.lang}) : super(key: key);
 final String title;
  final String year;
  final String lang;
  String language=CacheHelper.getData(key: 'language');

  List<dynamic> tasks=[];


  final  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

final  GlobalKey<FormState> formkey = GlobalKey<FormState>();

final  TextEditingController SubjectController = TextEditingController();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
print(lang);
    cubit.database2!=null?cubit.getDataFromDatabase2(cubit.database2, title,year):cubit.createDatabase2(title,year);
    // if(AppCubit.get(context).database2!=null){AppCubit.get(context).hint(widget.title);}
    // else{AppCubit.get(context).createDatabase2(widget.title);}
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context,  state) {

          if (state is AppGetDatabaseState2) {
                      tasks=state.subjects;



          }
          if (state is AppInsertDatabaseState2) {
            SubjectController.text='';
            Navigator.pop(context);
          }
        },
        builder: ( context, state) {




          return Scaffold(

            key: scaffoldkey,
            appBar: AppBar(
              backgroundColor: Colors.white,
              actions:   [

                Padding(
                  padding: EdgeInsets.only(right: 38.0,top: 8),
                  child: Row(
                    children: [

                      language=='عربي'? Text(
                        'التخصصات',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ):Text(
                        'התמחות בנושא',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState2,
              builder: (context) => tasksBuilder2(tasks: tasks,),
              fallback: (context)=>const Center(child: CircularProgressIndicator()),
            ),

            // Floating Bottom
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.yellow,

              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formkey.currentState!.validate()) {
                    cubit.insertToDatabaseSubject(
                      title: title, Subject: SubjectController.text,year: year

                    );
                  }
                } else {
                  scaffoldkey.currentState!
                      .showBottomSheet(
                        (context) =>
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(
                            20.0,
                          ),
                          child: Form(
                            key: formkey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultTextFormField(
                                  controller: SubjectController,
                                  keyboardType: TextInputType.text,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'subject must not be empty';
                                    }
                                    return null;
                                  },
                                  label: language=='عربي'?  ' التخصص':'ההתמחות',
                                  prefix: Icons.title,
                                ),


                              ],
                            ),
                          ),
                        ),
                    elevation: 20.0,
                  )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                      isShow: false,
                      icon: Icons.edit,
                    );
                  });
                  cubit.changeBottomSheetState(
                    isShow: true,
                    icon: Icons.add,
                  );
                }
              },
              child: Icon(
                cubit.fabIcon,color: Colors.black,
              ),
            ),

            // Bottom

          );
        },
      );

  }

Widget buildTaskItem2(Map model, context) => InkWell(
  onTap:(){
    navigateTo(context,DrawingPage(year: year, type:title, subject: model['subject'], i: 0, lang: lang,));





    },
  child: Card(

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    clipBehavior: Clip.none,
    elevation: 20.0,
    color: Colors.yellow,
    margin: const EdgeInsetsDirectional.all(20),
    child: SizedBox(
      height: 80,
      child: Row(
        children: [

          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${model['subject']}',
                  style: const TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),

        ],
      ),
    ),
  ),
);

Widget tasksBuilder2({required List<dynamic> tasks}) => ConditionalBuilder(
  condition: tasks.isNotEmpty,
  builder: (context) => ListView.separated(
    itemBuilder: (context, index) => buildTaskItem2(tasks[index], context),
    separatorBuilder: (context, index) => myDivider(),
    itemCount: tasks.length,
  ),
  fallback: (context) => Center(
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children:  [

    language=='عربي'?  Text(
        'اضف بعض التخصصات',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ): Text(
      'הוסף כמה התמחויות',
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      ),
    ),
    ]),
  ),
);
}

class subjectsScreen extends StatefulWidget {
  subjectsScreen({Key? key,required this.year}) : super(key: key);
  String year;

  @override
  State<subjectsScreen> createState() => _subjectsScreenState();
}

class _subjectsScreenState extends State<subjectsScreen> {
  var scaffoldkey = GlobalKey<ScaffoldState>();
  String language=CacheHelper.getData(key: 'language');

  var formkey = GlobalKey<FormState>();

  var titleController = TextEditingController();



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);

    cubit.database!=null?cubit.getDataFromDatabase(cubit.database, widget.year):cubit.createDatabase(widget.year);
    return  BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if (state is AppInsertDatabaseState) {
            titleController.text='';
            Navigator.pop(context);
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, state) {

          AppCubit cubit = AppCubit.get(context);

          var tasks = AppCubit.get(context).title;

          return Scaffold(

            key: scaffoldkey,
            appBar: AppBar(
backgroundColor: Colors.white,
              actions:  [

                Padding(
                  padding: EdgeInsets.only(right: 38.0,top: 8),
                  child: language==''? Text(
                    'المواد الدراسيه',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ): Text(
                    'נושאים',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) =>

             tasksBuilder(
            tasks: tasks,
          ),
              fallback: (context)=>const Center(child: CircularProgressIndicator()),
            ),

            // Floating Bottom
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.yellow,
              onPressed: () {
                setState(() {
                  if (cubit.isBottomSheetShown) {
                    if(language=='عربي'){
                    if (formkey.currentState!.validate()) {
                      AlertDialog alert = AlertDialog(
                        title: Text("اختار التنسيق"),
                        content: Text("ما تنسيق هذي الدفتر ؟"),
                        actions: [
                          TextButton(
                            child: Text("عربي"),
                            onPressed:  () {
                              cubit.insertToDatabase(
                                title: titleController.text,
                                year: widget.year,
                                lang: 'عربي',
                              );
                            },
                          ),
                          SizedBox(width: 2,),
                          TextButton(
                            child: Text("عبري"),
                            onPressed:  () {
                              cubit.insertToDatabase(
                                title: titleController.text,
                                year: widget.year,
                                lang: 'عبري',
                              );
                            },
                          ),
                          SizedBox(width: 2,),
                          TextButton(
                            child: Text("انجليزي"),
                            onPressed:  () {
                              cubit.insertToDatabase(
                                title: titleController.text,
                                year: widget.year,
                                lang: 'انجليزي',
                              );
                            },
                          ),
                        ],
                      );
                      // show the dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );

                    }
                    }
                    else{
                      if (formkey.currentState!.validate()) {
                        AlertDialog alert = AlertDialog(
                          title: Text("בחר את הפורמט"),
                          content: Text("מה הפורמט של המחברת הזו؟"),
                          actions: [
                            TextButton(
                              child: Text("ערבי"),
                              onPressed:  () {
                                cubit.insertToDatabase(
                                  title: titleController.text,
                                  year: widget.year,
                                  lang: 'عربي',
                                );
                              },
                            ),
                            SizedBox(width: 2,),
                            TextButton(
                              child: Text("עִברִית"),
                              onPressed:  () {
                                cubit.insertToDatabase(
                                  title: titleController.text,
                                  year: widget.year,
                                  lang: 'عبري',
                                );
                              },
                            ),
                            SizedBox(width: 2,),
                            TextButton(
                              child: Text("אנגלית"),
                              onPressed:  () {
                                cubit.insertToDatabase(
                                  title: titleController.text,
                                  year: widget.year,
                                  lang: 'انجليزي',
                                );
                              },
                            ),
                          ],
                        );
                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );

                      }
                    }
                  } else {
                    scaffoldkey.currentState!.showBottomSheet((context) => Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formkey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultTextFormField(
                              controller: titleController,
                              keyboardType: TextInputType.text,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return    language=='عربي'? 'يجب ألا يكون الموضوع فارغا':'הנושא לא חייב להיות ריק';
                                }
                                return null;
                              },
                              label: language=='عربي'? 'الماده الدراسيه':'נושא',
                              prefix: Icons.title,
                            ),

                          ],
                        ),
                      ),
                    ));
                  }
                  cubit.changeBottomSheetState(
                    isShow: !cubit.isBottomSheetShown,
                    icon: cubit.isBottomSheetShown ? Icons.edit : Icons.add,
                  );
                });
              },
              child: Icon(
                cubit.fabIcon,
                color: Colors.black,
              ),
            ),

            // Bottom

          );
        },
      );
  }

  Widget buildTaskItem(Map model, context) => InkWell(
    onTap:(){

      navigateTo(context,sectionsScreen(title:model['title'], year: widget.year,lang:model['lang'] ));},
    child: Card(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.none,
      elevation: 20.0,
      color: Colors.yellow,
      margin: const EdgeInsetsDirectional.all(20),
      child: SizedBox(
        height: 80,
        child: Row(
          children: [

            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${model['title']}',
                    style: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),

          ],
        ),
      ),
    ),
  );

  Widget tasksBuilder({required List<dynamic> tasks}) => ConditionalBuilder(
    condition: tasks.isNotEmpty,
    builder: (context) => ListView.separated(
      itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
      separatorBuilder: (context, index) => myDivider(),
      itemCount: tasks.length,
    ),
    fallback: (context) =>  Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

        language=='عربي'?
        Text(
          'لا توجد مواد دراسيه , من فضبك اضف بعضا منها',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ): Text(
          'אין חומרי לימוד, נא להוסיף כמה',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ]),
    ),
  );
}
