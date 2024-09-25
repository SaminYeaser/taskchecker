import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:get/get.dart';


final taskCheck = false.obs;

Future<void> sendEmail() async {
  final smtpServer = SmtpServer('smtp.dreamhost.com',
      username: 'samin@dayadvtech.com', password: 'bJiAcdBw');

  final message = Message()
    ..from = const Address('samin@dayadvtech.com', 'DayLight Technology')
    ..recipients = ['saminyeaser1@gmail.com']
    ..subject = 'Camera installing Task Complete'
    ..text = 'This is the plain text body of the email.'
    ..html = '<h1>Your work is done!</h1>';

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ${sendReport.mail}');
  } catch (e) {
    print('Error occurred while sending email: $e');
  }
}