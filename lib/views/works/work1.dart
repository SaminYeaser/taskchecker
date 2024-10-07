import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:taskchecker/constants.dart';

import '../../data/database.dart';
import '../../models/work_listings.dart';
import '../widgets/commentTxtField_and_send.dart';
import '../widgets/title_mail_textfield.dart';


class Work1 extends StatefulWidget {
  String? categoryName;
  // List? taskList;
  Work1({super.key, this.categoryName});

  @override
  State<Work1> createState() => _Work1State();
}

class _Work1State extends State<Work1> {
  // int pressedAttentionIndex  = -1;
  // bool isDone.value = false;
  final _mybox = Hive.box('checklist');
  CheckListDatabase db = CheckListDatabase();


  @override
  void initState() {
    print('calling : ${_mybox.get('WORK1')}');
    if(_mybox.get('WORK1') == null || _mybox.get('WORK1').isEmpty){
      // cctvWorkListing.clear();
      db.work1 = [
        {'task': 'Camera lens focused and adjusted properly','checked': false},
        {'task': 'Camera not been knocked off','checked': false},
        {'task':'Property perimeter clearly displayed','checked': false},
        {'task':'Camera lens free from dust and marks','checked': false},
        {'task':'Motion detection sensors working','checked': false},
        {'task':'Camera functions such as zoom and pan work correctly','checked': false},
        {'task':'App installed and tested','checked': false},
        {'task':'Cameras securely attached to the wall','checked': false},
        {'task':'There is enough free space on the hard disk','checked': false},
        {'task':'Unnecessary recordings been deleted from the camera','checked': false},
        {'task':'The cables free of any wear or exposed wires','checked': false},
        {'task':'Cables connected correctly','checked': false},
        {'task':'Sound and image transmission clear and distortion-free','checked': false},
        {
          'task':'Monitors showing clear picture, Brightness and contrast settings correctly adjusted','checked': false
        },
        {'task':'Switches and individual equipment fully functioning','checked': false},
        {'task':'All monitors and equipment free from dust and grime','checked': false},
        {'task':'Cables leading from the equipment in good condition, No weak connections','checked': false},
        {'task':'Time and date stamp correctly set','checked': false},
        {'task':'Power connections and AC plugs not loose and in good working condition','checked': false}
      ];
      print('calling from the if condi : ${db.work1}');
    }else{
      db.loadDataWork1();
      // print('length of data ${_mybox.length}');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios, color: textColor,)),
        backgroundColor: mainColor,
        title: Text('${widget.categoryName}',style: TextStyle(
            color: textColor
        ),),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                ListView.builder(
                  itemCount: db.work1.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    // var isDone =  widget.taskList![index]['checked'];
                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.red.withOpacity(0.3),
                        hoverColor: Colors.red.withOpacity(0.1),
                        highlightColor: Colors.red.withOpacity(0.2),
                        onTap: () {
                          setState(() {
                            db.work1[index]['checked'] = true;
                            db.updateDataBaseForWork1();
                            print('from database: ${_mybox.get('WORK1')}');

                            // print('check has data: ${_mybox.get('TODOLIST') == null}');
                          });

                        },
                        child: SizedBox(
                          height: 60,
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 375),
                                  curve: Curves.easeInOutCubic,
                                  margin: EdgeInsets.only(right: 20.0),
                                  height: db.work1[index]['checked'] == true ? 22.0 : 24.0,
                                  width: db.work1[index]['checked'] == true? 22.0 : 24.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.0),
                                    border: Border.all(
                                      color: db.work1[index]['checked'] == true ? Colors.black.withOpacity(.2) : Colors.black,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: AnimatedOpacity(
                                    curve: Curves.easeInOutCubic,
                                    opacity: db.work1[index]['checked'] == true? 1.0 : 0.0,
                                    duration: const Duration(milliseconds: 375),
                                    child: const Icon(
                                      Icons.check_rounded,
                                      size: 17.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Align(
                                  alignment: const Alignment(-1.0, 0.0),
                                  child: AnimatedPadding(
                                    duration: Duration(milliseconds: 375),
                                    padding: EdgeInsets.only(left: db.work1[index]['checked'] == true? 0.0 : 0.0),
                                    curve: Curves.easeInOutCubic,
                                    child: Text(
                                      db.work1[index]['task'],
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.2,
                                          color: db.work1[index]['checked'] == true ? Colors.black26 : Colors.black,
                                          decoration: db.work1[index]['checked'] == true ? TextDecoration.lineThrough : TextDecoration.none
                                      ),
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                TextFieldsAndComments(
                  'CCTV Work Checklist',
                'WORK1'
                )
              ],
            ),
          ),),
      ),
    );
  }
}

