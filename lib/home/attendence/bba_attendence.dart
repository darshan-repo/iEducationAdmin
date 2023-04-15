import 'package:admin_app/common/searching_filter.dart';
import 'package:admin_app/libs.dart';

class BBAAttendenceScreen extends StatefulWidget {
  final String args;
  const BBAAttendenceScreen({super.key, required this.args});

  @override
  State<BBAAttendenceScreen> createState() => _BBAAttendenceScreenState();
}

class _BBAAttendenceScreenState extends State<BBAAttendenceScreen> {
  TextEditingController bbaAttendenceSearch = TextEditingController();
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
  List<Attendence> bbaAttendenceList = [];
  List<Attendence> searchBBAAttendenceList = [];
  // List<Attendence> semWiseList = [];

  @override
  void initState() {
    showBBAAttendence();
    super.initState();
  }

  Future<void> showBBAAttendence() async {
    AttendenceApi.keys = widget.args;
    isLoading = true;
    await AttendenceApi.fetchData();
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
                controller: bbaAttendenceSearch,
                textFieldOnChanged: (value) {
                  setState(() {
                    searchBBAAttendenceList = bbaAttendenceList
                        .where((item) => item.name!
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  });
                },
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
                    // if (selectedSemSemester == 'All') {
                    //   semWiseList = bcaAttendenceList;
                    // } else if (selectedSemSemester == 'SEM - 6') {
                    //   semWiseList = bcaAttendenceList
                    //       .where((item) =>
                    //           item.semester!.contains(value.toLowerCase()))
                    //       .toList();
                    //   print(semWiseList[0].toJson());
                    // }
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
                  : bbaAttendenceList.isEmpty
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
                              child: searchBBAAttendenceList.isEmpty &&
                                      bbaAttendenceSearch.text.isEmpty
                                  ? ListView.builder(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
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
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                            title: Text(
                                              bbaAttendenceList[index].name!,
                                              style: TextStyle(
                                                  color: kPrimaryColor),
                                            ),
                                            subtitle: Text(
                                              bbaAttendenceList[index]
                                                  .semester!,
                                            ),
                                            trailing: Text(
                                              '${bbaAttendenceList[index].attendence.toString()} %',
                                              style: TextStyle(
                                                color: (bbaAttendenceList[index]
                                                            .attendence! <
                                                        70)
                                                    ? Colors.red
                                                    : (bbaAttendenceList[index]
                                                                    .attendence! >=
                                                                70 &&
                                                            bbaAttendenceList[
                                                                        index]
                                                                    .attendence! <
                                                                85)
                                                        ? Colors.orange
                                                        : Colors.green,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : searchBBAAttendenceList.isEmpty &&
                                          bbaAttendenceSearch.text.isNotEmpty
                                      ? const Text('Student Not Found')
                                      : ListView.builder(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          itemCount:
                                              searchBBAAttendenceList.length,
                                          itemBuilder: (context, index) {
                                            return Card(
                                              color: kSecondaryColor,
                                              elevation: 3,
                                              child: ListTile(
                                                leading: CachedNetworkImage(
                                                  imageUrl:
                                                      searchBBAAttendenceList[
                                                              index]
                                                          .image
                                                          .toString(),
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    width: 50,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
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
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                                title: Text(
                                                  searchBBAAttendenceList[index]
                                                      .name!,
                                                  style: TextStyle(
                                                      color: kPrimaryColor),
                                                ),
                                                subtitle: Text(
                                                  searchBBAAttendenceList[index]
                                                      .semester!,
                                                ),
                                                trailing: Text(
                                                  '${searchBBAAttendenceList[index].attendence.toString()} %',
                                                  style: TextStyle(
                                                    color: (searchBBAAttendenceList[
                                                                    index]
                                                                .attendence! <
                                                            70)
                                                        ? Colors.red
                                                        : (searchBBAAttendenceList[
                                                                            index]
                                                                        .attendence! >=
                                                                    70 &&
                                                                searchBBAAttendenceList[
                                                                            index]
                                                                        .attendence! <
                                                                    85)
                                                            ? Colors.orange
                                                            : Colors.green,
                                                  ),
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
