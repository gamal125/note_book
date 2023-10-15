import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart' hide Image;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_drawing_board/cubit/cubit.dart';
import 'package:flutter_drawing_board/main.dart';
import 'package:flutter_drawing_board/view/drawing_canvas/drawing_canvas.dart';
import 'package:flutter_drawing_board/view/drawing_canvas/models/drawing_mode.dart';
import 'package:flutter_drawing_board/view/drawing_canvas/models/sketch.dart';
import 'package:flutter_drawing_board/view/drawing_canvas/widgets/canvas_side_bar.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../components/components.dart';
import '../cubit/states.dart';
import '../localdb.dart';
import '../searchScreen.dart';

class DrawingPage extends HookWidget {
   DrawingPage({Key? key,required this.type,required this.subject,required this.year,required this.i,required this.lang}) : super(key: key);
   String type;
   String subject;
   String year;
   String lang;
   int i;
  DatabaseHelper databaseHelper =DatabaseHelper();

   @override
  Widget build(BuildContext context) {


     final selectedColor = useState(Colors.black);
    final strokeSize = useState<double>(1);
    final index=useState(i);
    final eraserSize = useState<double>(30);
    final drawingMode = useState(DrawingMode.pencil);
    final filled = useState<bool>(false);
    final polygonSides = useState<int>(3);
    final backgroundImage = useState<Image?>(null);
    final canvasGlobalKey = GlobalKey();
    ValueNotifier<Sketch?> currentSketch = useState(null);
    ValueNotifier<List<Sketch>> allSketches = useState([]);
    databaseHelper.getSketches(index.value,type,subject,year).then((value){allSketches.value=value.value;});

    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 150),
      initialValue: 1,
    );
    return  BlocConsumer<AppCubit, AppStates>(
        listener: ( context, AppStates state) {
          if (state is AppGetDatabaseState) {
            Navigator.pop(context);
          //  navigateTo(context,YearsScreen());

          //  Navigator.pop(context);
          }
        },
   builder:(context,state)=>   Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              DrawingCanvas(
                Subject:subject ,
                year:year ,
                type:type ,
                i: index.value,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                drawingMode: drawingMode,
                selectedColor: selectedColor,
                strokeSize: strokeSize,
                eraserSize: eraserSize,
                sideBarController: animationController,
                currentSketch: currentSketch,
                allSketches: allSketches,
                canvasGlobalKey: canvasGlobalKey,
                filled: filled,
                polygonSides: polygonSides,
                backgroundImage: backgroundImage,
                lang: lang,
              ),

              Positioned(
                top:  kToolbarHeight + 8,
                // left: -5,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1, 0),
                    end: Offset.zero,
                  ).animate(animationController),
                  child: CanvasSideBar(
                    type:type,
                    i:index.value,
                    drawingMode: drawingMode,
                    selectedColor: selectedColor,
                    strokeSize: strokeSize,
                    eraserSize: eraserSize,
                    currentSketch: currentSketch,
                    allSketches: allSketches,
                    canvasGlobalKey: canvasGlobalKey,
                    filled: filled,
                    polygonSides: polygonSides,
                    backgroundImage: backgroundImage,
                    year: year,
                    subject: subject,
                  ),
                ),
              ),
              _CustomAppBar( animationController,
                  allSketches.value.isEmpty?DateFormat.yMd().format(DateTime.now()): allSketches.value.first.currentTime,type,year,subject,databaseHelper,currentSketch,context, index: index, lang: lang ),
            ],
          ),
        ),
      ),)
    ;
  }
}
Widget _CustomAppBar(  final AnimationController animationController, final String date,final String type,final String year,final String subject,final databaseHelper ,ValueNotifier<Sketch?> currentSketch, BuildContext context,{required ValueNotifier<int>  index,required String lang} )=> SizedBox(
  height: kToolbarHeight,
  width: double.maxFinite,
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        IconButton(
          onPressed: () {
            if(index.value <1)
             {

               print(index.value);

                 Navigator.pop(context);

             }else{
              currentSketch.value=null;
              index=useState(index.value--);

              // databaseHelper.getSketches(index.value,type).then((value){allSketches.value=value.value;});



            }

          },
          icon: const Icon(Icons.arrow_back,color: Colors.blue,),
        ),
        IconButton(onPressed: (){navigateTo(context, SearchScreen(type:type,subject:subject,year:year, lang:lang ,));}, icon: Icon(Icons.search,color: Colors.blue,)),
        IconButton(
          onPressed: () {
            if (animationController.value == 0) {
              animationController.forward();
            } else {
              animationController.reverse();
            }
          },
          icon: const Icon(Icons.menu),
        ),

         Text(
          'page ${index.value+1}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),

        Text(date),
        IconButton(
          onPressed: () {

            currentSketch.value=null;
            index=useState(index.value++);

            // databaseHelper.getSketches(index.value,type).then((value){allSketches.value=value.value;});

          },
          icon: const Icon(Icons.arrow_forward,color: Colors.blue,),
        )
      ],
    ),
  ),
);
