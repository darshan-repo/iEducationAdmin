import 'package:admin_app/common/searching_filter.dart';
import 'package:admin_app/libs.dart';

class BBAFeesScreen extends StatefulWidget {
  final String args;
  const BBAFeesScreen({super.key, required this.args});

  @override
  State<BBAFeesScreen> createState() => _BBAFeesScreenState();
}

class _BBAFeesScreenState extends State<BBAFeesScreen> {
  TextEditingController bbaFeesSearch = TextEditingController();
  String? selectedSemSemester = 'All';

  final List<String> semester = [
    'All',
    'SEM - 1',
    'SEM - 2',
    'SEM - 3',
    'SEM - 4',
    'SEM - 5',
    'SEM - 6',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              searching(
                context,
                controller: bbaFeesSearch ,
                items: semester
                    .map(
                      (semester) => DropdownMenuItem<String>(
                        value: semester,
                        child: Text(
                          semester,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                value: selectedSemSemester,
                onChanged: (value) {
                  setState(() {
                    selectedSemSemester = value as String;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
