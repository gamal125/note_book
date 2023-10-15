import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_drawing_board/view/drawing_page.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'components/components.dart';
import 'localdb.dart';
class SearchScreen extends StatefulWidget {
 final String type;
 final String subject;
 final String year;
 final String lang;
  SearchScreen( {required this.type,required this.subject,required this.year,required this.lang});


  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late DateTime _selectedDate;
  List<int> x = [];
  var dateController = TextEditingController();
  DatabaseHelper databaseHelper =DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  void dispose() {

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Screen'),
      ),
      body: SafeArea(
        top: true,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 25,),
                defaultTextFormField(
                  controller: dateController,
                  keyboardType: TextInputType.datetime,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.parse('2022-05-15'),
                      lastDate: DateTime.parse('2090-05-15'),
                    ).then((value) async{
                      dateController.text = DateFormat.yMd().format(value!);
                      print( dateController.text);

                   x= await  databaseHelper.search(widget.type, widget.subject, widget.year, dateController.text);
                   setState(() {
                     x=x;
                   });

                  print(x.length);
                    });
                  },
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'date must not be empty';
                    }
                    return null;
                  },
                  label: 'Task Date',
                  prefix: Icons.calendar_today,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                tasksBuilder(indexs: x, type: widget.type, subject: widget.subject, year: widget.year)

                // Add your search results widget here based on the selected date

               ],
            ),
          ),
        ),
      ),
    );
  }
  Widget buildTaskItem(int i,String type,String subject,String year, context) => InkWell(
    onTap:(){
      navigateTo(context,DrawingPage( year: year, type: type, subject: subject, i: i,lang: widget.lang, ));

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const SizedBox(
              width: 20.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                 "Page ${(i+1).toString()}",
                  style: const TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),
            const SizedBox(
              width: 20.0,
            ),

          ],
        ),
      ),
    ),
  );


  Widget tasksBuilder({required List<int> indexs,required String type,required String subject,required String year,}) => ConditionalBuilder(
    condition: indexs.isNotEmpty,
    builder: (context) => ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildTaskItem(indexs[index], type, subject, year, context),
      separatorBuilder: (context, index) => myDivider(),
      itemCount: indexs.length,
    ),
    fallback: (context) => Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: const [

        Text(
          'No pages Yet',
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