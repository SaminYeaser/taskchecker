import 'package:flutter/cupertino.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:get/get.dart';


final taskCheck = false.obs;


Future<void> sendEmail({String? workName, String? email, String? comments, String? companyName, dynamic checkLists}) async {
  final smtpServer = SmtpServer('smtp.dreamhost.com',
      username: 'alerts@dayadvtech.com', password: 'Zenith1@@');

  String checklistHtml = '';
  if (checkLists != null && checkLists.isNotEmpty) {
    for (var item in checkLists) {
      var task = item['task'];
      var checked = item['checked'] ? '✔️' : '❌';
      checklistHtml += '<li>$task - $checked</li>';
      print('the works: $checklistHtml');
    }
  }
  final message = Message()
    ..from = const Address('alerts@dayadvtech.com', 'DayLight Technology')
    ..recipients = [email, ]
    ..subject = '$workName for $companyName'
    ..text = 'This is the plain text body of the email.'
    ..html = '''
    <h2>Company Name : $companyName</h2>
    <h2>Your work for $workName is done!</h2>
    <h2>Checklists of the completed work</h2>
    <p>$comments</p>
    $checklistHtml
    ''';

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ${sendReport.mail.text}');
  } catch (e) {
    print('Error occurred while sending email: $e');
  }
}