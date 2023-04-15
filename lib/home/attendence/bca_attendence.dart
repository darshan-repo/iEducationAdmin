import 'package:admin_app/common/searching_filter.dart';
import 'package:admin_app/libs.dart';

class BCAAttendenceScreen extends StatefulWidget {
  final String args;
  const BCAAttendenceScreen({
    super.key,
    required this.args,
  });

  @override
  State<BCAAttendenceScreen> createState() => _BCAAttendenceScreenState();
}

class _BCAAttendenceScreenState extends State<BCAAttendenceScreen> {
  TextEditingController bcaAttendenceSearch = TextEditingController();
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
  List<Attendence> bcaAttendenceList = [];
  List<Attendence> searchBCAAttendenceList = [];
  List<Attendence> semWiseList = [];

  @override
  void initState() {
    showBCAAttendence();
    super.initState();
  }

  Future<void> showBCAAttendence() async {
    AttendenceApi.keys = widget.args;
    isLoading = true;
    await AttendenceApi.fetchData();
    bcaAttendenceList.clear();
    bcaAttendenceList = AttendenceApi.attendenceDataList;
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
                controller: bcaAttendenceSearch,
                textFieldOnChanged: (value) {
                  setState(() {
                    searchBCAAttendenceList = bcaAttendenceList
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
                  : bcaAttendenceList.isEmpty
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
                              child: searchBCAAttendenceList.isEmpty &&
                                      bcaAttendenceSearch.text.isEmpty
                                  ? ListView.builder(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      itemCount: bcaAttendenceList.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          color: kSecondaryColor,
                                          elevation: 3,
                                          child: ListTile(
                                            leading: CachedNetworkImage(
                                              imageUrl: bcaAttendenceList[index]
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
                                              bcaAttendenceList[index].name!,
                                              style: TextStyle(
                                                  color: kPrimaryColor),
                                            ),
                                            subtitle: Text(
                                              bcaAttendenceList[index]
                                                  .semester!,
                                            ),
                                            trailing: Text(
                                              '${bcaAttendenceList[index].attendence.toString()} %',
                                              style: TextStyle(
                                                color: (bcaAttendenceList[index]
                                                            .attendence! <
                                                        70)
                                                    ? Colors.red
                                                    : (bcaAttendenceList[index]
                                                                    .attendence! >=
                                                                70 &&
                                                            bcaAttendenceList[
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
                                  : searchBCAAttendenceList.isEmpty &&
                                          bcaAttendenceSearch.text.isNotEmpty
                                      ? const Text('Student Not Found')
                                      : ListView.builder(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          itemCount:
                                              searchBCAAttendenceList.length,
                                          itemBuilder: (context, index) {
                                            return Card(
                                              color: kSecondaryColor,
                                              elevation: 3,
                                              child: ListTile(
                                                leading: CachedNetworkImage(
                                                  imageUrl:
                                                      searchBCAAttendenceList[
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
                                                  searchBCAAttendenceList[index]
                                                      .name!,
                                                  style: TextStyle(
                                                      color: kPrimaryColor),
                                                ),
                                                subtitle: Text(
                                                  searchBCAAttendenceList[index]
                                                      .semester!,
                                                ),
                                                trailing: Text(
                                                  '${searchBCAAttendenceList[index].attendence.toString()} %',
                                                  style: TextStyle(
                                                    color: (searchBCAAttendenceList[
                                                                    index]
                                                                .attendence! <
                                                            70)
                                                        ? Colors.red
                                                        : (searchBCAAttendenceList[
                                                                            index]
                                                                        .attendence! >=
                                                                    70 &&
                                                                searchBCAAttendenceList[
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
