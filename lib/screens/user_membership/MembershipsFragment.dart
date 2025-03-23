import 'package:flutter/material.dart';
import 'package:membership/screens/book_stay/stays.dart';
import 'package:membership/screens/user_membership/ActiveCouponFragment.dart';
import 'package:membership/screens/user_membership/ExpiredDocument.dart';
import 'package:sizer/sizer.dart';

class MembershipsFragment extends StatefulWidget {
  const MembershipsFragment({Key? key}) : super(key: key);

  @override
  State<MembershipsFragment> createState() => _MembershipsFragmentState();
}

class _MembershipsFragmentState extends State<MembershipsFragment>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            // PopupMenuButton<int>(
            //   offset: Offset(0, 58),
            //   itemBuilder: (context) => [
            //     PopupMenuItem(
            //       value: 1,
            //       child: TextButton(
            //           onPressed: () {
            //             Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => const Stays()),
            //             );
            //           },
            //           child: const Text("Your Bookings",
            //               style: TextStyle(fontSize: 14, color: Colors.black))),
            //     ),
            //   ],
            // ),
          ],
          title: const Text(
            "Your Memberships",
          ),
        ),
        body: _tabSection());
  }

  Widget _tabSection() {
    return DefaultTabController(
      length: 2,
      child: ListView(
        //mainAxisSize: MainAxisSize.min,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 40,
            // color: fillColor,
            child: TabBar(
                unselectedLabelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.amber),
                tabs: [
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Text(
                          "Active",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 19),
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Center(
                        child: Text(
                          "Expired",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 19),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
          SizedBox(
            //Add this to give height
            height: 80.h,
            child: const TabBarView(children: [
              ActiveMembershiFragment(),
              ExpiredMembership(),
            ]),
          ),
        ],
      ),
    );
  }
}