import 'package:hive/hive.dart';
import 'package:get/get.dart';


class CheckListDatabase{

  List work1 = [];
  List work2 = [];
  List work3 = [];
  List work4 = [];

  // List allWork = [];

  final _mybox = Hive.box('checklist');


  void createInitalData(){
    // taskList = workList;
  }

  void loadDataWork1(){
    work1 = _mybox.get('WORK1');
  }

  void loadDataWork2(){
    work2 = _mybox.get('WORK2');
  }
  void loadDataWork3(){
    work3 = _mybox.get('WORK3');
  }
  void loadDataWork4(){
    work4 = _mybox.get('WORK4');
  }




  void updateDataBaseForWork1(){
    print('database1 updated');
    _mybox.put('WORK1', work1);
  }

  void updateDataBaseForWork2(){
    print('database2 updated');
    _mybox.put('WORK2', work2);
  }

  void updateDataBaseForWork3(){
    print('database3 updated');
    _mybox.put('WORK3', work3);
  }

  void updateDataBaseForWork4(){
    print('database4 updated');
    _mybox.put('WORK4', work4);
  }
}