import 'package:hive/hive.dart';
import 'package:get/get.dart';


class CheckListDatabase{

  List workList = [
    'CCTV Work Checklist',
    'On Site Technician CheckList'
  ];

  final cctvWorkListing = [
    'Camera lens focused and adjusted properly',
    'Camera not been knocked off',
    'Property perimeter clearly displayed',
    'Camera lens free from dust and marks',
    'Motion detection sensors working',
    'Camera functions such as zoom and pan work correctly',
    'App installed and tested',
    'Cameras securely attached to the wall',
    'There is enough free space on the hard disk',
    'Unnecessary recordings been deleted from the camera',
    'The cables free of any wear or exposed wires',
    'Cables connected correctly',
    'Sound and image transmission clear and distortion-free',
    'Monitors showing clear picture, Brightness and contrast settings correctly adjusted',
    'Switches and individual equipment fully functioning',
    'All monitors and equipment free from dust and grime',
    'Cables leading from the equipment in good condition, No weak connections',
    'Time and date stamp correctly set',
    'Power connections and AC plugs not loose and in good working condition'
  ].obs;

  final onSiteTechnicianCheckList = [
    'Internet type and speed',
    'Router type and model',
    'Switch type and model',
    'Cabling for Voice and Data',
    'Wi-Fi with Guest network or extend Wi-Fi network',
    'Backup Strategy and Restoration (NAS)',
    'SSDs for computers',
    'RAM for computers',
    'Anti-virus',
    'Remote access to network',
    'VOIP in office or at home',
    'Set up employees to work from home',
    'Need UPS for all networking equipment',
    'Need emails for domain',
    'Need a website or website updated',
    'Server administration',
    'Network administration',
    'Ongoing maintenance (contract)'
  ].obs;


  final _mybox = Hive.box('checklist');


  void createInitalData(){
    workList = workList;
  }

  void loadData(){
    workList = _mybox.get('TODOLIST');
  }

  void updateDataBase(){
    _mybox.put('TODOLIST', workList);
  }
}