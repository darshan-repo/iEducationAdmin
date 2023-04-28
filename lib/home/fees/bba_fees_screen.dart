import 'package:admin_app/common/searching_filter.dart';
import 'package:admin_app/home/fees/fees_widget.dart';
import 'package:admin_app/libs.dart';

class BBAFeesScreen extends StatefulWidget {
  final String args;
  const BBAFeesScreen({super.key, required this.args});

  @override
  State<BBAFeesScreen> createState() => _BBAFeesScreenState();
}

class _BBAFeesScreenState extends State<BBAFeesScreen> {
  TextEditingController bbaFeesSearchController = TextEditingController();

  bool isLoading = false;
  List<Student> bbaStudentFees = [];
  List<Student> searchBBAFeesList = [];

  @override
  void initState() {
    showBBAFees();
    super.initState();
  }

  Future<void> showBBAFees() async {
    StudentDataApi.keys = widget.args;
    isLoading = true;
    await StudentDataApi.fetchData();
    bbaStudentFees.clear();
    bbaStudentFees = StudentDataApi.studentDataList;
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
                controller: bbaFeesSearchController,
                textFieldOnChanged: (value) {
                  setState(() {
                    searchBBAFeesList = bbaStudentFees
                        .where((item) => item.fName
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
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
                  : bbaStudentFees.isEmpty
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
                              seconds: 200,
                              verticalOffset: 100,
                              child: searchBBAFeesList.isEmpty &&
                                      bbaFeesSearchController.text.isEmpty
                                  ? ListView.builder(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      itemCount: bbaStudentFees.length,
                                      itemBuilder: (context, index) {
                                        return animation(
                                          context,
                                          seconds: 500,
                                          verticalOffset: -100,
                                          child: Card(
                                            elevation: 3,
                                            color: kSecondaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Theme(
                                              data: ThemeData(
                                                splashColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                              ),
                                              child: ExpansionTile(
                                                leading: CachedNetworkImage(
                                                  imageUrl:
                                                      bbaStudentFees[index]
                                                          .image,
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
                                                  '${bbaStudentFees[index].fName} ${bbaStudentFees[index].mName} ${bbaStudentFees[index].lName}',
                                                  style: TextStyle(
                                                    color: kPrimaryColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        bbaStudentFees[index]
                                                                .isShowButton
                                                            ? FontWeight.w600
                                                            : FontWeight.w400,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  bbaStudentFees[index]
                                                      .semester,
                                                  style: TextStyle(
                                                    color: bbaStudentFees[index]
                                                            .isShowButton
                                                        ? kPrimaryColor
                                                        : Colors.black,
                                                  ),
                                                ),
                                                iconColor: kPrimaryColor,
                                                collapsedIconColor:
                                                    kPrimaryColor,
                                                onExpansionChanged:
                                                    (bool expanded) {
                                                  indexs.removeAt(0);
                                                  indexs.insert(1, index);
                                                  setState(
                                                    () {
                                                      bbaStudentFees[indexs[0]]
                                                          .isShowButton = false;
                                                      bbaStudentFees[index]
                                                              .isShowButton =
                                                          bbaStudentFees[index]
                                                                      .isShowButton ==
                                                                  false
                                                              ? true
                                                              : false;
                                                      bbaStudentFees[index]
                                                              .isShowButton =
                                                          expanded;
                                                    },
                                                  );
                                                },
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                children: [
                                                  feesContainer(),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : searchBBAFeesList.isEmpty &&
                                          bbaFeesSearchController
                                              .text.isNotEmpty
                                      ? SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1,
                                              ),
                                              Lottie.asset(
                                                  'assets/icons/Circle.json'),
                                            ],
                                          ),
                                        )
                                      : ListView.builder(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          itemCount: searchBBAFeesList.length,
                                          itemBuilder: (context, index) {
                                            return animation(
                                              context,
                                              seconds: 500,
                                              verticalOffset: -100,
                                              child: Card(
                                                elevation: 3,
                                                color: kSecondaryColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Theme(
                                                  data: ThemeData(
                                                    splashColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                  ),
                                                  child: ExpansionTile(
                                                    leading: CachedNetworkImage(
                                                      imageUrl:
                                                          searchBBAFeesList[
                                                                  index]
                                                              .image,
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        width: 50,
                                                        height: 100,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      placeholder: (context,
                                                              url) =>
                                                          CircularProgressIndicator(
                                                        color: kPrimaryColor,
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                    ),
                                                    title: Text(
                                                      '${searchBBAFeesList[index].fName} ${searchBBAFeesList[index].mName} ${searchBBAFeesList[index].lName}',
                                                      style: TextStyle(
                                                        color: kPrimaryColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            searchBBAFeesList[
                                                                        index]
                                                                    .isShowButton
                                                                ? FontWeight
                                                                    .w600
                                                                : FontWeight
                                                                    .w400,
                                                      ),
                                                    ),
                                                    subtitle: Text(
                                                      searchBBAFeesList[index]
                                                          .semester,
                                                      style: TextStyle(
                                                        color: searchBBAFeesList[
                                                                    index]
                                                                .isShowButton
                                                            ? kPrimaryColor
                                                            : Colors.black,
                                                      ),
                                                    ),
                                                    iconColor: kPrimaryColor,
                                                    collapsedIconColor:
                                                        kPrimaryColor,
                                                    onExpansionChanged:
                                                        (bool expanded) {
                                                      indexs.removeAt(0);
                                                      indexs.insert(1, index);
                                                      setState(
                                                        () {
                                                          searchBBAFeesList[
                                                                      indexs[0]]
                                                                  .isShowButton =
                                                              false;
                                                          searchBBAFeesList[
                                                                      index]
                                                                  .isShowButton =
                                                              searchBBAFeesList[
                                                                              index]
                                                                          .isShowButton ==
                                                                      false
                                                                  ? true
                                                                  : false;
                                                          searchBBAFeesList[
                                                                      index]
                                                                  .isShowButton =
                                                              expanded;
                                                        },
                                                      );
                                                    },
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      ),
                                                    ),
                                                    children: [
                                                      feesContainer(),
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
