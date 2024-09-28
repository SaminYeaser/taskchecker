import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:taskchecker/constants.dart';

import '../../data/database.dart';
import '../../models/work_listings.dart';


class Work3 extends StatefulWidget {
  String? categoryName;
  // List? taskList;
  Work3({super.key, this.categoryName});

  @override
  State<Work3> createState() => _Work3State();
}

class _Work3State extends State<Work3> {
  // int pressedAttentionIndex  = -1;
  // bool isDone.value = false;
  final _mybox = Hive.box('checklist');
  CheckListDatabase db = CheckListDatabase();


  @override
  void initState() {
    if(_mybox.get('work3') == null){
      db.work3 = cctvWorkListing;
    }else{
      db.loadDataWork3();
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
                  itemCount: db.work3.length,
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
                            db.work3[index]['checked'] = true;
                            db.updateDataBaseForWork3();
                            print('from database: ${_mybox.get('work3')}');

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
                                  height: db.work3[index]['checked'] == true ? 22.0 : 24.0,
                                  width: db.work3[index]['checked'] == true? 22.0 : 24.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.0),
                                    border: Border.all(
                                      color: db.work3[index]['checked'] == true ? Colors.black.withOpacity(.2) : Colors.black,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: AnimatedOpacity(
                                    curve: Curves.easeInOutCubic,
                                    opacity: db.work3[index]['checked'] == true? 1.0 : 0.0,
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
                                    padding: EdgeInsets.only(left: db.work3[index]['checked'] == true? 0.0 : 0.0),
                                    curve: Curves.easeInOutCubic,
                                    child: Text(
                                      db.work3[index]['task'],
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.2,
                                          color: db.work3[index]['checked'] == true ? Colors.black26 : Colors.black,
                                          decoration: db.work3[index]['checked'] == true ? TextDecoration.lineThrough : TextDecoration.none
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
                )
              ],
            ),
          ),),
      ),
    );
  }
}

