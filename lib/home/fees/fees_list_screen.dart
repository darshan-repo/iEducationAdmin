import 'package:admin_app/home/fees/bba_fees_screen.dart';
import 'package:admin_app/home/fees/bca_fees_screen.dart';
import 'package:admin_app/home/fees/bcom_fees_screen.dart';

import '../../libs.dart';

class FeesListScreen extends StatefulWidget {
  const FeesListScreen({Key? key}) : super(key: key);

  @override
  State<FeesListScreen> createState() => _FeesListScreenState();
}

class _FeesListScreenState extends State<FeesListScreen>
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
          'Fees',
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
      body: TabBarView(
        controller: tabController,
        children: const [
          BCAFeesScreen(args: "BCA"),
          BBAFeesScreen(args: "BBA"),
          BCOMFeesScreen(args: "BCOM"),
        ],
      ),
    );
  }
}
