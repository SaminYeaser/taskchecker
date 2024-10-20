import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:taskchecker/constants.dart';

import '../../controllers/send_mail_controller.dart';
import '../../data/database.dart';


class TextFieldsAndComments extends StatefulWidget {

  String? workName;
  String? boxName;
  TextFieldsAndComments(this.workName,this.boxName, {super.key});

  @override
  State<TextFieldsAndComments> createState() => _TextFieldsAndCommentsState();
}

class _TextFieldsAndCommentsState extends State<TextFieldsAndComments> {
  final TextEditingController _comments = TextEditingController();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _title = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  CheckListDatabase db = CheckListDatabase();
  final _mybox = Hive.box('checklist');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _title,
            maxLines: 1,
            validator: (value){
              return value!.isEmpty
                  ? 'Put the title of the company you worked for'
                  : null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor
                  )
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[800]),
              hintText: "Company Name",
              fillColor: Colors.white70,
            ),
          ),
          const SizedBox(height: 10,),
          TextFormField(
            controller: _email,
            maxLines: 1,
            validator: (value){
              const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                  r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                  r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                  r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                  r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                  r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                  r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
              final regex = RegExp(pattern);

              return value!.isEmpty && !regex.hasMatch(value)
                  ? 'Enter a valid email address'
                  : null;
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor
                  )
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[800]),
              hintText: "Your Email",
              fillColor: Colors.white70,
            ),
          ),
          const SizedBox(height: 10,),
          TextFormField(
            controller: _comments,
            maxLines: 4,
            validator: (value){
              return value!.isEmpty
                  ? 'Put some comments in it'
                  : null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor
                )
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[800]),
              hintText: "Comments",
              fillColor: Colors.white70,
            ),
          ),
          const SizedBox(height: 10,),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(fullWidth, 60),
              backgroundColor: Colors.black
            ),
              onPressed: ()async{
            final isValidate = _formKey.currentState!.validate();
            if(isValidate){
              setState(() {
                _isLoading = true;
              });
              print('print the db work 1: ${_mybox.get('WORK1')}');
              await   sendEmail(
                  workName: widget.workName,
                email: _email.text,
                comments: _comments.text,
                checkLists: _mybox.get('WORK1'),
                companyName: _title.text
              ).then((value) async{
                _comments.clear();
                _email.clear();
                _title.clear();
                setState(() {
                  _isLoading = false;
                });

                Get.back();
                Get.snackbar(
                  "Mail Sent",
                  "Work Completed!",
                  snackPosition: SnackPosition.BOTTOM,
                  colorText: Colors.white,
                  borderRadius: 10,
                  backgroundColor:  Colors.black ,

                );
                // await Hive.deleteBoxFromDisk("checklist");

                if(widget.boxName == 'WORK1'){
                  await Hive.box('checklist').delete("WORK1");
                  db.updateDataBaseForWork1();
                }else if(widget.boxName == 'WORK2'){
                  await Hive.box('checklist').delete("WORK2");
                  db.updateDataBaseForWork2();
                }

              });
            }
          },
              icon: _isLoading
                  ? Container(
                width: 24,
                height: 24,
                padding: const EdgeInsets.all(2.0),
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
                  : const Icon(Icons.send,color: Colors.white,),
            label: const Text('Send',style: TextStyle(
                color: Colors.white
            ),),
          )
        ],
      ),
    );
  }
}
