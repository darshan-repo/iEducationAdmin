import 'package:admin_app/libs.dart';

SnackBar insertSnackBar({
  String messageText = '',
}) {
  return SnackBar(
    content: Align(
      alignment: Alignment.center,
      child: Text(
        messageText,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    duration: const Duration(seconds: 1),
    backgroundColor: Colors.green[200],
    margin: const EdgeInsets.all(20),
    behavior: SnackBarBehavior.floating,
  );
}

SnackBar warningSnackBar({
  String messageText = '',
}) {
  return SnackBar(
    content: Align(
      alignment: Alignment.center,
      child: Text(
        messageText,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
    backgroundColor: Colors.red[200],
    margin: const EdgeInsets.all(20),
    behavior: SnackBarBehavior.floating,
  );
}
