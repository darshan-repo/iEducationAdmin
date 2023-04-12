import 'package:admin_app/home/attendence/attendence_widget.dart';
import 'package:admin_app/libs.dart';

class BBAAttendenceScreen extends StatefulWidget {
  final String args;
  const BBAAttendenceScreen({super.key, required this.args});

  @override
  State<BBAAttendenceScreen> createState() => _BBAAttendenceScreenState();
}

class _BBAAttendenceScreenState extends State<BBAAttendenceScreen> {
  TextEditingController searchController = TextEditingController();
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
  List<Attendence> bbaAttendenceList = [];

  bool isLoading = false;
  @override
  void initState() {
    showBBAAttendence();
    super.initState();
  }

  Future<void> showBBAAttendence() async {
    AttendenceApi.keys = widget.args;
    await AttendenceApi.fetchData();
    isLoading = true;
    bbaAttendenceList.clear();
    bbaAttendenceList = AttendenceApi.attendenceDataList;
    isLoading = false;
    setState(() {});
  }

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
                controller: searchController,
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
                  ? Center(
                      child: CircularProgressIndicator(color: kPrimaryColor))
                  : bbaAttendenceList.isEmpty
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.15,
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
                                itemCount: bbaAttendenceList.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: kSecondaryColor,
                                    elevation: 3,
                                    child: ListTile(
                                      leading: CachedNetworkImage(
                                        imageUrl: bbaAttendenceList[index]
                                            .image
                                            .toString(),
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
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                      title: Text(
                                        bbaAttendenceList[index].name!,
                                      ),
                                      subtitle: Text(
                                        bbaAttendenceList[index].semester!,
                                      ),
                                      trailing: Text(
                                        bbaAttendenceList[index]
                                            .attendence
                                            .toString(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        )
            ],
          ),
        ),
      ),
    );
  }
}
