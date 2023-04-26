import 'package:admin_app/common/snackbars.dart';
import 'package:intl/intl.dart';
import '../../libs.dart';

class AddTimeTable extends StatefulWidget {
  const AddTimeTable({Key? key}) : super(key: key);
  static const route = 'addTimeTable';
  @override
  State<AddTimeTable> createState() => _AddTimeTableState();
}

class _AddTimeTableState extends State<AddTimeTable> {
  GlobalKey<FormState> addTimeTable = GlobalKey<FormState>();
  String? selectedSemester;
  String? selectedStream;
  List<String> semester = [
    'SEM - 1',
    'SEM - 2',
    'SEM - 3',
    'SEM - 4',
    'SEM - 5',
    'SEM - 6',
  ];
  List<String> stream = [
    'BCA',
    'BBA',
    'BCOM',
  ];

  String? dayOfWeek;
  bool loading = false;

  void clearData() {
    txtLectureName.clear();
    txtLectureDate.clear();
    txtLectureStartTime.clear();
    txtLectureEndTime.clear();
  }

  @override
  void dispose() {
    txtLectureName.clear();
    txtLectureDate.clear();
    txtLectureStartTime.clear();
    txtLectureEndTime.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, title: 'Add Time Table'),
      body: Stack(
        children: [
          Form(
            key: addTimeTable,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  labelText(text: "Select Stream"),
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
                  labelText(text: "Select Semester"),
                  dropDownButton(
                    context,
                    hintText: 'Select Semester',
                    item: semester
                        .map((semester) => DropdownMenuItem<String>(
                              value: semester,
                              child: Text(
                                semester,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedSemester,
                    onChanged: (value) {
                      setState(
                        () {
                          selectedSemester = value as String;
                        },
                      );
                    },
                  ),
                  labelText(text: "Lecture Name"),
                  textFormField(
                    txtController: txtLectureName,
                    validator: (value) =>
                        value!.isEmpty ? "Please Enter Lecture Name" : null,
                    hintText: "Lecture Name",
                    prefixIcon: Icons.library_books,
                  ),
                  labelText(text: "Lecture Date"),
                  textFormField(
                      readOnly: true,
                      txtController: txtLectureDate,
                      validator: (value) {
                        if (value!.isEmpty || value.isEmpty) {
                          return 'Please Select Date';
                        }
                        return null;
                      },
                      prefixIcon: Icons.calendar_today_outlined,
                      suffixIcon: Icons.calendar_month,
                      hintText: "Lecture Date",
                      onPressed: () async {
                        DateTime? newDate = await showDatePicker(
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: kPrimaryColor,
                                  onPrimary: kSecondaryColor,
                                  onSurface: kPrimaryColor,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: kPrimaryColor,
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2030),
                        );
                        if (newDate == null) return;
                        String date1 =
                            "${newDate.day}-${newDate.month}-${newDate.year}";
                        txtLectureDate.text = date1;
                        dayOfWeek = DateFormat('EEEE').format(newDate);
                        setState(() {});
                      }),
                  labelText(text: "Lecture  Start Time"),
                  textFormField(
                    readOnly: true,
                    txtController: txtLectureStartTime,
                    validator: (value) {
                      if (value!.isEmpty || value.isEmpty) {
                        return 'Plase Select Time';
                      }
                      return null;
                    },
                    prefixIcon: Icons.schedule,
                    suffixIcon: Icons.av_timer,
                    hintText: "Lecture Start Time",
                    onPressed: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: kPrimaryColor,
                                onPrimary: kSecondaryColor,
                                onSurface: kPrimaryColor,
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  foregroundColor: kPrimaryColor,
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (pickedTime != null) {
                        if (!mounted) return;

                        DateTime parsedTime = DateFormat.jm()
                            .parse(pickedTime.format(context).toString());
                        String formattedTime =
                            DateFormat('hh:mm aa').format(parsedTime);
                        setState(() {
                          txtLectureStartTime.text = formattedTime;
                        });
                      }
                    },
                  ),
                  labelText(text: "Lecture End Time"),
                  textFormField(
                    readOnly: true,
                    txtController: txtLectureEndTime,
                    validator: (value) {
                      if (value!.isEmpty || value.isEmpty) {
                        return 'Please Select Time';
                      }
                      return null;
                    },
                    hintText: 'Lecture End Time',
                    prefixIcon: Icons.schedule,
                    suffixIcon: Icons.av_timer,
                    onPressed: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: kPrimaryColor,
                                onPrimary: kSecondaryColor,
                                onSurface: kPrimaryColor,
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  foregroundColor: kPrimaryColor,
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (pickedTime != null) {
                        if (!mounted) return;

                        DateTime parsedTime = DateFormat.jm()
                            .parse(pickedTime.format(context).toString());
                        String formattedTime =
                            DateFormat('hh:mm aa').format(parsedTime);
                        setState(() {
                          txtLectureEndTime.text = formattedTime;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              child: loading ? processIndicator(context) : const SizedBox())
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
        child: materialButton(
          context,
          buttonText: 'Submit',
          onPressed: () async {
            if (addTimeTable.currentState!.validate()) {
              if (selectedStream != null) {
                if (selectedSemester != null) {
                  loading = true;
                  setState(() {});
                  TimeTable obj = TimeTable(
                    key: int.parse(
                        DateTime.now().millisecondsSinceEpoch.toString()),
                    stream: selectedStream.toString(),
                    semester: selectedSemester.toString(),
                    lectureName: txtLectureName.text,
                    lectureDate: txtLectureDate.text,
                    lectureStartTime: txtLectureStartTime.text,
                    lectureEndTime: txtLectureEndTime.text,
                  );
                  await TimeTableApi.timeTableAddData(
                    obj: obj,
                  );
                  if (!mounted) return;
                  Navigator.pop(context);
                  loading = false;
                  ScaffoldMessenger.of(context).showSnackBar(
                    insertSnackBar(
                        messageText: 'Successfully Add TimeTable Data'),
                  );
                  clearData();
                  setState(() {});
                } else {
                  loading = false;
                  ScaffoldMessenger.of(context).showSnackBar(
                    warningSnackBar(messageText: 'Please Select Semester'),
                  );
                }
              } else {
                loading = false;
                ScaffoldMessenger.of(context).showSnackBar(
                  warningSnackBar(messageText: 'Please Select Stream'),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
