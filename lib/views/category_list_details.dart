// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hive/hive.dart';
// import 'package:taskchecker/constants.dart';
//
// import '../controllers/send_mail_controller.dart';
// import '../data/database.dart';
// import '../models/work_listings.dart';
// import 'custom_checklist.dart';
//
//
// class CategoryListDetailsPage extends StatefulWidget {
//   String? categoryName;
//   // List? taskList;
//   CategoryListDetailsPage({super.key, this.categoryName});
//
//   @override
//   State<CategoryListDetailsPage> createState() => _CategoryListDetailsPageState();
// }
//
// class _CategoryListDetailsPageState extends State<CategoryListDetailsPage> {
//   // int pressedAttentionIndex  = -1;
//   // bool isDone.value = false;
//   final _mybox = Hive.box('checklist');
//   CheckListDatabase db = CheckListDatabase();
//
//
//   @override
//   void initState() {
//     if(_mybox.get('WORK1') == null){
//       db.work1 = cctvWorkListing;
//       db.allWork = cctvWorkListing;
//     }else if(_mybox.get('WORK2') == null){
//       db.work2 = onSiteTechnicianCheckList;
//       db.allWork = onSiteTechnicianCheckList;
//     }else{
//       db.loadData();
//       // print('length of data ${_mybox.length}');
//     }
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         leading: IconButton(onPressed: (){
//           Get.back();
//         }, icon: Icon(Icons.arrow_back_ios, color: textColor,)),
//         backgroundColor: mainColor,
//         title: Text('${widget.categoryName}',style: TextStyle(
//           color: textColor
//         ),),
//       ),
//       body: SingleChildScrollView(
//         child: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 children: [
//                   ListView.builder(
//                     itemCount: db.allWork.length,
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemBuilder: (context, index){
//                       // var isDone =  widget.taskList![index]['checked'];
//                       return Material(
//                         color: Colors.transparent,
//                         child: InkWell(
//                           splashColor: Colors.red.withOpacity(0.3),
//                           hoverColor: Colors.red.withOpacity(0.1),
//                           highlightColor: Colors.red.withOpacity(0.2),
//                           onTap: () {
//                             setState(() {
//                               db.allWork[index]['checked'] = true;
//                               db.work1 = db.allWork;
//
//                               db.updateDataBaseForWork1();
//                               print('from database: ${_mybox.get('WORK1')}');
//
//                               // print('check has data: ${_mybox.get('TODOLIST') == null}');
//                             });
//
//                           },
//                           child: SizedBox(
//                             height: 60,
//                             child: Row(
//                               children: [
//                                 Container(
//                                   padding: EdgeInsets.symmetric(vertical: 10),
//                                   child: AnimatedContainer(
//                                     duration: Duration(milliseconds: 375),
//                                     curve: Curves.easeInOutCubic,
//                                     margin: EdgeInsets.only(right: 20.0),
//                                     height: db.allWork[index]['checked'] == true ? 22.0 : 24.0,
//                                     width: db.allWork[index]['checked'] == true? 22.0 : 24.0,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(3.0),
//                                       border: Border.all(
//                                         color: db.allWork[index]['checked'] == true ? Colors.black.withOpacity(.2) : Colors.black,
//                                         width: 1.5,
//                                       ),
//                                     ),
//                                     child: AnimatedOpacity(
//                                       curve: Curves.easeInOutCubic,
//                                       opacity: db.allWork[index]['checked'] == true? 1.0 : 0.0,
//                                       duration: const Duration(milliseconds: 375),
//                                       child: const Icon(
//                                         Icons.check_rounded,
//                                         size: 17.0,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Flexible(
//                                   child: Align(
//                                     alignment: const Alignment(-1.0, 0.0),
//                                     child: AnimatedPadding(
//                                       duration: Duration(milliseconds: 375),
//                                       padding: EdgeInsets.only(left: db.allWork[index]['checked'] == true? 0.0 : 0.0),
//                                       curve: Curves.easeInOutCubic,
//                                       child: Text(
//                                         db.allWork[index]['task'],
//                                         style: TextStyle(
//                                             fontSize: 14.0,
//                                             fontWeight: FontWeight.w500,
//                                             letterSpacing: 0.2,
//                                             color: db.allWork[index]['checked'] == true ? Colors.black26 : Colors.black,
//                                             decoration: db.allWork[index]['checked'] == true ? TextDecoration.lineThrough : TextDecoration.none
//                                         ),
//                                         textAlign: TextAlign.start,
//                                         maxLines: 2,
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   )
//                 ],
//               ),
//             ),),
//       ),
//     );
//   }
// }
//
