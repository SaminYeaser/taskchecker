import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:taskchecker/constants.dart';
import 'package:get/get.dart';
import 'package:taskchecker/data/database.dart';
import 'package:taskchecker/views/category_list_details.dart';
import '../controllers/send_mail_controller.dart';
import '../models/work_listings.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _mybox = Hive.box('checklist');

  CheckListDatabase db = CheckListDatabase();

  final workList = [
    'CCTV Work Checklist',
    'On Site Technician CheckList'
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daylight Task Checker',style: TextStyle(
          color: Colors.white
        ),),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body:  SafeArea(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: workList.length,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context,index) {
            return InkWell(
              onTap: (){
                Get.to(
                    CategoryListDetailsPage(
                      categoryName:  workList[index],
                      taskList: workList[index] == 'CCTV Work Checklist' ? cctvWorkListing :  onSiteTechnicianCheckList,
                    ),
                );
              },
              child: SizedBox(
                width: fullWidth,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(workList[index],style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500
                    ),),
                  ),
                ),
              ),
            );
          }
        ),
      )),
    );
  }
}
