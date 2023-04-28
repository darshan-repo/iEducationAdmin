import 'package:admin_app/common/searching_filter.dart';
import 'package:admin_app/home/fees/fees_widget.dart';
import 'package:admin_app/libs.dart';

class BCOMFeesScreen extends StatefulWidget {
  final String args;
  const BCOMFeesScreen({super.key, required this.args});

  @override
  State<BCOMFeesScreen> createState() => _BCOMFeesScreenState();
}

class _BCOMFeesScreenState extends State<BCOMFeesScreen> {
  TextEditingController bcomFeesSearchController = TextEditingController();

  bool isLoading = false;
  List<Student> bcomStudentFees = [];
  List<Student> searchBCOMFeesList = [];

  @override
  void initState() {
    showBCOMFees();
    super.initState();
  }

  Future<void> showBCOMFees() async {
    StudentDataApi.keys = widget.args;
    isLoading = true;
    await StudentDataApi.fetchData();
    bcomStudentFees.clear();
    bcomStudentFees = StudentDataApi.studentDataList;
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
                controller: bcomFeesSearchController,
                textFieldOnChanged: (value) {
                  setState(() {
                    searchBCOMFeesList = bcomStudentFees
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
                  : bcomStudentFees.isEmpty
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
                              child: searchBCOMFeesList.isEmpty &&
                                      bcomFeesSearchController.text.isEmpty
                                  ? ListView.builder(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      itemCount: bcomStudentFees.length,
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
                                                      bcomStudentFees[index]
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
                                                  '${bcomStudentFees[index].fName} ${bcomStudentFees[index].mName} ${bcomStudentFees[index].lName}',
                                                  style: TextStyle(
                                                    color: kPrimaryColor,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        bcomStudentFees[index]
                                                                .isShowButton
                                                            ? FontWeight.w600
                                                            : FontWeight.w400,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  bcomStudentFees[index]
                                                      .semester,
                                                  style: TextStyle(
                                                    color:
                                                        bcomStudentFees[index]
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
                                                      bcomStudentFees[indexs[0]]
                                                          .isShowButton = false;
                                                      bcomStudentFees[index]
                                                              .isShowButton =
                                                          bcomStudentFees[index]
                                                                      .isShowButton ==
                                                                  false
                                                              ? true
                                                              : false;
                                                      bcomStudentFees[index]
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
                                  : searchBCOMFeesList.isEmpty &&
                                          bcomFeesSearchController
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
                                          itemCount: searchBCOMFeesList.length,
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
                                                          searchBCOMFeesList[
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
                                                      '${searchBCOMFeesList[index].fName} ${searchBCOMFeesList[index].mName} ${searchBCOMFeesList[index].lName}',
                                                      style: TextStyle(
                                                        color: kPrimaryColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            searchBCOMFeesList[
                                                                        index]
                                                                    .isShowButton
                                                                ? FontWeight
                                                                    .w600
                                                                : FontWeight
                                                                    .w400,
                                                      ),
                                                    ),
                                                    subtitle: Text(
                                                      searchBCOMFeesList[index]
                                                          .semester,
                                                      style: TextStyle(
                                                        color:
                                                            searchBCOMFeesList[
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
                                                          searchBCOMFeesList[
                                                                      indexs[0]]
                                                                  .isShowButton =
                                                              false;
                                                          searchBCOMFeesList[
                                                                      index]
                                                                  .isShowButton =
                                                              searchBCOMFeesList[
                                                                              index]
                                                                          .isShowButton ==
                                                                      false
                                                                  ? true
                                                                  : false;
                                                          searchBCOMFeesList[
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
