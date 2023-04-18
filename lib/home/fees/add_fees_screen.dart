import '../../libs.dart';

class AddFeesScreen extends StatefulWidget {
  const AddFeesScreen({Key? key}) : super(key: key);

  @override
  State<AddFeesScreen> createState() => _AddFeesScreenState();
}

class _AddFeesScreenState extends State<AddFeesScreen> {
  GlobalKey<FormState> addFees = GlobalKey<FormState>();
  bool loading = false;
  String? selectedStream;
  String? selectedSemester;

  List<String> stream = ['BCOM', 'BBA', 'BCA'];

  List<String> semester = [
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
      appBar: appbar(context, title: 'Add Fees'),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: addFees,
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (notification) {
                  notification.disallowIndicator();
                  return true;
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      labelText(text: 'Name'),
                      textFormField(
                        txtController: txtFeesStudentController,
                        prefixIcon: Icons.person,
                        hintText: 'First Name',
                        validator: (value) =>
                            value!.isEmpty ? " Please Enter First Name" : null,
                      ),
                      labelText(text: 'Select Stream'),
                      dropDownButton(
                        context,
                        hintText: 'Select Stream',
                        item: stream
                            .map(
                              (stream) => DropdownMenuItem<String>(
                                value: stream,
                                child: Text(
                                  stream,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                            .toList(),
                        value: selectedStream,
                        onChanged: (value) {
                          setState(() {
                            selectedStream = value as String;
                          });
                        },
                      ),
                      labelText(text: 'Select Semester'),
                      dropDownButton(
                        context,
                        hintText: 'Select Semester',
                        item: semester
                            .map(
                              (semester) => DropdownMenuItem<String>(
                                value: semester,
                                child: Text(
                                  semester,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                            .toList(),
                        value: selectedSemester,
                        onChanged: (value) {
                          setState(() {
                            selectedSemester = value as String;
                          });
                        },
                      ),
                      labelText(text: 'Total Fees'),
                      textFormField(
                        txtController: txtTotalFeesController,
                        prefixIcon: Icons.currency_rupee,
                        hintText: 'Enter Total Fees',
                        validator: (value) =>
                            value!.isEmpty ? "Please enter total fees" : null,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      labelText(text: 'Paid Fees'),
                      textFormField(
                        txtController: txtPaidFeesController,
                        prefixIcon: Icons.currency_rupee,
                        keyboardType: TextInputType.number,
                        hintText: 'Enter Paid',
                        validator: (value) =>
                            value!.isEmpty ? "Please enter paid fees" : null,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      labelText(text: 'Remaining Fees'),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: kSecondaryColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: kPrimaryColor),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Icon(
                              Icons.currency_rupee,
                              color: kPrimaryColor,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            // Text('')
                          ],
                        ),
                      ),
                      // textFormField(
                      //   txtController: txtRemainingFeesController,
                      //   prefixIcon: Icons.format_list_numbered_rounded,
                      //   keyboardType: TextInputType.number,
                      //   hintText: 'Enter SPID No.',
                      //   validator: (value) => value!.isEmpty
                      //       ? "Please Enter valid SPID no"
                      //       : null,
                      //   inputFormatters: [
                      //     FilteringTextInputFormatter.digitsOnly,
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              child: loading ? processIndicator(context) : const SizedBox())
        ],
      ),
    );
  }
}
