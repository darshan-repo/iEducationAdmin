import 'package:admin_app/home/attendence/attendence_widget.dart';
import 'package:admin_app/libs.dart';

class BCOMAttendenceScreen extends StatefulWidget {
  final String args;
  const BCOMAttendenceScreen({super.key, required this.args});

  @override
  State<BCOMAttendenceScreen> createState() => _BCOMAttendenceScreenState();
}

class _BCOMAttendenceScreenState extends State<BCOMAttendenceScreen> {
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
  bool isLoading = false;
  List<Attendence> bcomAttendenceList = [];

  @override
  void initState() {
    showBCOMAttendence();
    super.initState();
  }

  Future<void> showBCOMAttendence() async {
    AttendenceApi.keys = widget.args;
    await AttendenceApi.fetchData();
    isLoading = true;
    bcomAttendenceList.clear();
    bcomAttendenceList = AttendenceApi.attendenceDataList;
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
                  : bcomAttendenceList.isEmpty
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
                                itemCount: bcomAttendenceList.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: kSecondaryColor,
                                    elevation: 3,
                                    child: ListTile(
                                      leading: CachedNetworkImage(
                                        imageUrl: bcomAttendenceList[index]
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
                                        bcomAttendenceList[index].name!,
                                      ),
                                      subtitle: Text(
                                        bcomAttendenceList[index].semester!,
                                      ),
                                      trailing: Text(
                                        bcomAttendenceList[index]
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
