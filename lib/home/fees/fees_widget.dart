
import '../../libs.dart';

Widget feesContainer() {
  return Container(
    margin: const EdgeInsets.all(10),
    height: 50,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      border: Border.all(
        color: kPrimaryColor,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Amount',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: kPrimaryColor,
              ),
            ),
            Text(
              "₹14500",
              style: TextStyle(
                fontSize: 12.sp,
                color: kPrimaryColor,
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: VerticalDivider(
            color: kPrimaryColor,
            thickness: 1,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Paid Amount',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            Text(
              "₹14500",
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.green,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: VerticalDivider(
            color: kPrimaryColor,
            thickness: 1,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Remaing Amount',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
            Text(
              "₹00000",
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
