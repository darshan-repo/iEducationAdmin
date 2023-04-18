import 'package:admin_app/libs.dart';

class FeesScreen extends StatefulWidget {
  const FeesScreen({super.key});

  @override
  State<FeesScreen> createState() => _FeesScreenState();
}

class _FeesScreenState extends State<FeesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, title: 'Fees'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: kPrimaryColor),
                ),
                child: feesColumn(),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: floatingActionButton(
        context,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddFeesScreen(),
            ),
          );
        },
      ),
    );
  }
}

Widget feesColumn() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Fees',
            style: TextStyle(fontSize: 18.sp, color: kPrimaryColor),
          ),
          Text(
            'Paid Fees',
            style: TextStyle(fontSize: 16.sp),
          ),
          Text(
            'Remaining Fees',
            style: TextStyle(fontSize: 16.sp, color: Colors.red),
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '15000',
            style: TextStyle(fontSize: 16.sp, color: kPrimaryColor),
          ),
          Text(
            '15000',
            style: TextStyle(fontSize: 16.sp),
          ),
          Text(
            '00000',
            style: TextStyle(fontSize: 16.sp, color: Colors.red),
          ),
        ],
      )
    ],
  );
}
