import 'package:admin_app/common/searching_filter.dart';
import 'package:admin_app/libs.dart';

class BCOMAttendenceScreen extends StatefulWidget {
  final String args;
  const BCOMAttendenceScreen({super.key, required this.args});

  @override
  State<BCOMAttendenceScreen> createState() => _BCOMAttendenceScreenState();
}

class _BCOMAttendenceScreenState extends State<BCOMAttendenceScreen> {
  TextEditingController bcomAttendenceSearch = TextEditingController();
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
  List<Attendence> searchBCOMAttendenceList = [];
  // List<Attendence> semWiseList = [];

  @override
  void initState() {
    showBCOMAttendence();
    super.initState();
  }

  Future<void> showBCOMAttendence() async {
    AttendenceApi.keys = widget.args;
    isLoading = true;
    await AttendenceApi.fetchData();
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
                controller: bcomAttendenceSearch,
                textFieldOnChanged: (value) {
                  setState(() {
                    searchBCOMAttendenceList = bcomAttendenceList
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
                  : bcomAttendenceList.isEmpty
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
                              child: searchBCOMAttendenceList.isEmpty &&
                                      bcomAttendenceSearch.text.isEmpty
                                  ? ListView.builder(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      itemCount: bcomAttendenceList.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          color: kSecondaryColor,
                                          elevation: 3,
                                          child: ListTile(
                                            leading: CachedNetworkImage(
                                              imageUrl:
                                                  bcomAttendenceList[index]
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
                                              bcomAttendenceList[index].name!,
                                              style: TextStyle(
                                                  color: kPrimaryColor),
                                            ),
                                            subtitle: Text(
                                              bcomAttendenceList[index]
                                                  .semester!,
                                            ),
                                            trailing: Text(
                                              '${bcomAttendenceList[index].attendence.toString()} %',
                                              style: TextStyle(
                                                color: (bcomAttendenceList[
                                                                index]
                                                            .attendence! <
                                                        70)
                                                    ? Colors.red
                                                    : (bcomAttendenceList[index]
                                                                    .attendence! >=
                                                                70 &&
                                                            bcomAttendenceList[
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
                                  : searchBCOMAttendenceList.isEmpty &&
                                          bcomAttendenceSearch.text.isNotEmpty
                                      ? const Text('Student Not Found')
                                      : ListView.builder(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          itemCount:
                                              searchBCOMAttendenceList.length,
                                          itemBuilder: (context, index) {
                                            return Card(
                                              color: kSecondaryColor,
                                              elevation: 3,
                                              child: ListTile(
                                                leading: CachedNetworkImage(
                                                  imageUrl:
                                                      searchBCOMAttendenceList[
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
                                                  searchBCOMAttendenceList[
                                                          index]
                                                      .name!,
                                                  style: TextStyle(
                                                      color: kPrimaryColor),
                                                ),
                                                subtitle: Text(
                                                  searchBCOMAttendenceList[
                                                          index]
                                                      .semester!,
                                                ),
                                                trailing: Text(
                                                  '${searchBCOMAttendenceList[index].attendence.toString()} %',
                                                  style: TextStyle(
                                                    color: (searchBCOMAttendenceList[
                                                                    index]
                                                                .attendence! <
                                                            70)
                                                        ? Colors.red
                                                        : (searchBCOMAttendenceList[
                                                                            index]
                                                                        .attendence! >=
                                                                    70 &&
                                                                searchBCOMAttendenceList[
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
