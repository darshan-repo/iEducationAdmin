import 'package:admin_app/home/attendence/bba_attendence.dart';
import 'package:admin_app/home/attendence/bca_attendence.dart';
import 'package:admin_app/home/attendence/bcom_attendence.dart';
import '../../libs.dart';

class AttendenceScreen extends StatefulWidget {
  const AttendenceScreen({Key? key}) : super(key: key);

  @override
  State<AttendenceScreen> createState() => _AttendenceScreenState();
}

class _AttendenceScreenState extends State<AttendenceScreen>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  TabController? tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Attendence',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await showDialog<bool>(
                barrierDismissible: false,
                context: context,
                builder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    QrImage(
                      data: '1234567',
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(10),
                      version: QrVersions.auto,
                      size: 250.0,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: const Text('Done'))
                  ],
                ),
              );
              if (result == true) {
                setState(() {});
              }
            },
            color: Colors.white,
            icon: const Icon(Icons.qr_code_2_outlined),
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 2.5,
          indicatorColor: Colors.white,
          tabs: const [
            Text(
              'BCA',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'BBA',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'BCOM',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return true;
        },
        child: TabBarView(
          controller: tabController,
          children: const [
            BCAAttendenceScreen(args: "BCA"),
            BBAAttendenceScreen(args: "BBA"),
            BCOMAttendenceScreen(args: "BCOM"),
          ],
        ),
      ),
    );
  }
}
