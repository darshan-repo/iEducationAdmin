import '../libs.dart';

PreferredSizeWidget appbar(
  BuildContext context, {
  String title = '',
  Function()? onPressed,
  IconData? actionIcon,
}) {
  return AppBar(
    centerTitle: true,
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
    ),
    elevation: 0,
    backgroundColor: kPrimaryColor,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back_ios,
      ),
    ),
    actions: [
      IconButton(
        onPressed: onPressed,
        color: Colors.white,
        icon: Icon(actionIcon),
      ),
    ],
  );
}
