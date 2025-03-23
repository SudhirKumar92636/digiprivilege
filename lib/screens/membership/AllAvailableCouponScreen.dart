import 'package:flutter/material.dart';
import 'package:membership/screens/membership/services/MembershipService.dart';

import '../../utils/data/data_storage.dart';
import 'components/OfferDetailsComponent.dart';

class AllAvailableCouponScreen extends StatefulWidget {
  final String membershipId;

  const AllAvailableCouponScreen({Key? key, required this.membershipId})
      : super(key: key);

  @override
  State<AllAvailableCouponScreen> createState() =>
      _AllAvailableCouponScreenState();
}

class _AllAvailableCouponScreenState extends State<AllAvailableCouponScreen> {
  String userId = "";

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  getUserDetails() async {
    await AppData.getString(userIdKey).then((value) {
      setState(() {
        userId = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Available Coupons"),
      ),
      body: RefreshIndicator(
        onRefresh: () => MembershipService()
            .getAllCouponsByMembershipAndId(widget.membershipId, userId),
        child: couponsItemListView(widget.membershipId, false, context, 100),
      ),
    );
  }
}