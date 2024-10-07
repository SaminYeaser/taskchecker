import 'package:flutter/cupertino.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:get/get.dart';


final taskCheck = false.obs;


Future<void> sendEmail({String? workName, String? email, String? comments, List? checkLists}) async {
  final smtpServer = SmtpServer('smtp.dreamhost.com',
      username: 'alerts@dayadvtech.com', password: 'Zenith1@@');

  final message = Message()
    ..from = const Address('alerts@dayadvtech.com', 'DayLight Technology')
    ..recipients = [email, ]
    ..subject = workName
    ..text = 'This is the plain text body of the email.'
    ..html = '''
    
    <h2>Your work for $workName is done!</h2>
    <h2>Checklists of the completed work</h2>
    <p>$comments</p>
    <p>$checkLists</p>
    ''';

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ${sendReport.mail}');
  } catch (e) {
    print('Error occurred while sending email: $e');
  }
}