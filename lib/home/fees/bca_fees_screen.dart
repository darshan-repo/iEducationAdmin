import 'package:admin_app/common/searching_filter.dart';
import 'package:admin_app/libs.dart';

class BCAFeesScreen extends StatefulWidget {
  final String args;
  const BCAFeesScreen({super.key, required this.args});

  @override
  State<BCAFeesScreen> createState() => _BCAFeesScreenState();
}

class _BCAFeesScreenState extends State<BCAFeesScreen> {
  TextEditingController bcaFeesSearch = TextEditingController();
  // bool _customTileExpandedEducationDetail = false;
  String? selectedSemSemester = 'All';
  bool isLoading = false;
  List<Student> bcaStudentFees = [];

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
  void initState() {
    showBCAFees();
    super.initState();
  }

  Future<void> showBCAFees() async {
    StudentDataApi.keys = widget.args;
    isLoading = true;
    await StudentDataApi.fetchData();
    bcaStudentFees.clear();
    bcaStudentFees = StudentDataApi.studentDataList;
    isLoading = false;
    setState(() {});
  }

  List indexs = [0, 0];

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
                controller: bcaFeesSearch,
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
              isLoading
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 0.30.sh),
                        CircularProgressIndicator(color: kPrimaryColor),
                      ],
                    )
                  : bcaStudentFees.isEmpty
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                            Lottie.asset('assets/icons/Circle.json'),
                          ],
                        )
                      : Expanded(
                          child: NotificationListener<
                              OverscrollIndicatorNotification>(
                            onNotification: (notification) {
                              notification.disallowIndicator();
                              return true;
                            },
                            child: animation(
                              context,
                              seconds: 500,
                              verticalOffset: 100,
                              child: ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                itemCount: bcaStudentFees.length,
                                itemBuilder: (context, index) {
                                  return animation(
                                    context,
                                    seconds: 1000,
                                    verticalOffset: -100,
                                    child: Card(
                                      elevation: 3,
                                      color: kSecondaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Theme(
                                        data: ThemeData(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                        ),
                                        child: ExpansionTile(
                                          leading: CachedNetworkImage(
                                            imageUrl:
                                                bcaStudentFees[index].image,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              width: 50,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(
                                              color: kPrimaryColor,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                          title: Text(
                                            '${bcaStudentFees[index].fName} ${bcaStudentFees[index].mName} ${bcaStudentFees[index].lName}',
                                            style: TextStyle(
                                              color: kPrimaryColor,
                                              fontSize: 16,
                                              fontWeight: bcaStudentFees[index]
                                                      .isShowButton
                                                  ? FontWeight.w600
                                                  : FontWeight.w400,
                                            ),
                                          ),
                                          subtitle: Text(
                                            bcaStudentFees[index].semester,
                                            style: TextStyle(
                                              color: bcaStudentFees[index]
                                                      .isShowButton
                                                  ? kPrimaryColor
                                                  : Colors.black,
                                            ),
                                          ),
                                          iconColor: kPrimaryColor,
                                          collapsedIconColor: kPrimaryColor,
                                          trailing: CircleAvatar(
                                            radius: 15,
                                            backgroundColor: kPrimaryColor,
                                            child: Icon(
                                              bcaStudentFees[index].isShowButton
                                                  ? Icons.done
                                                  : Icons.close,
                                              color: kSecondaryColor,
                                              size: 20,
                                              // bcaStudentFees[index].isShowButton
                                              //     ? Icons.arrow_drop_down_circle
                                              //     : Icons.arrow_right,
                                            ),
                                          ),
                                          onExpansionChanged: (bool expanded) {
                                            indexs.removeAt(0);
                                            indexs.insert(1, index);
                                            setState(
                                              () {
                                                bcaStudentFees[indexs[0]]
                                                    .isShowButton = false;
                                                bcaStudentFees[index]
                                                        .isShowButton =
                                                    bcaStudentFees[index]
                                                                .isShowButton ==
                                                            false
                                                        ? true
                                                        : false;
                                                bcaStudentFees[index]
                                                    .isShowButton = expanded;
                                              },
                                            );
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          children: [
                                            Container(
                                              height: 50,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
