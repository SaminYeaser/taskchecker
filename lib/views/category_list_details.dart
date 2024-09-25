import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:taskchecker/constants.dart';

import '../controllers/send_mail_controller.dart';
import '../data/database.dart';
import 'custom_checklist.dart';


class CategoryListDetailsPage extends StatefulWidget {
  String? categoryName;
  List? taskList;
  CategoryListDetailsPage({super.key, this.categoryName, this.taskList});

  @override
  State<CategoryListDetailsPage> createState() => _CategoryListDetailsPageState();
}

class _CategoryListDetailsPageState extends State<CategoryListDetailsPage> {
  // int pressedAttentionIndex  = -1;
  // bool isDone.value = false;
  final _mybox = Hive.box('checklist');
  CheckListDatabase db = CheckListDatabase();
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
                    itemCount: widget.taskList!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      // var isDone =  widget.taskList![index]['checked'];
                      return Material(
                        color: Colors.transparent,
                        child: Obx(()=>InkWell(
                          splashColor: Colors.red.withOpacity(0.3),
                          hoverColor: Colors.red.withOpacity(0.1),
                          highlightColor: Colors.red.withOpacity(0.2),
                          onTap: () {
                            setState(() {
                              widget.taskList![index]['checked'] = true;
                            });
                            db.updateDataBase();
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
                                    height: widget.taskList![index]['checked'] == true ? 22.0 : 24.0,
                                    width: widget.taskList![index]['checked'] == true? 22.0 : 24.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3.0),
                                      border: Border.all(
                                        color: widget.taskList![index]['checked'] == true ? Colors.black.withOpacity(.2) : Colors.black,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: AnimatedOpacity(
                                      curve: Curves.easeInOutCubic,
                                      opacity: widget.taskList![index]['checked'] == true? 1.0 : 0.0,
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
                                      padding: EdgeInsets.only(left: widget.taskList![index]['checked'] == true? 0.0 : 0.0),
                                      curve: Curves.easeInOutCubic,
                                      child: Text(
                                        widget.taskList![index]['task'],
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.2,
                                            color: widget.taskList![index]['checked'] == true ? Colors.black26 : Colors.black,
                                            decoration: widget.taskList![index]['checked'] == true ? TextDecoration.lineThrough : TextDecoration.none
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
                        )),
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

