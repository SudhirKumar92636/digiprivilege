import 'package:flutter/material.dart';
import 'package:membership/models/UserMembershipDetailsModel.dart';
import 'package:membership/models/membership/MembershipDetailsModel.dart';
import 'package:membership/screens/brand/HotelComponents.dart';
import 'package:membership/screens/brand/SelectHotel.dart';
import 'package:membership/screens/user_membership/services/UserMembershipService.dart';
import 'package:membership/utils/data/data_storage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/styles/ImageView.dart';
import 'UserMembershipComponent.dart';

class BuyNowMembersship extends StatefulWidget {
  const BuyNowMembersship({Key? key}) : super(key: key);

  @override
  State<BuyNowMembersship> createState() => _MembershipListState();
}

class _MembershipListState extends State<BuyNowMembersship> {
  String userId = "";
  String selectedStartDate = "";

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
        title: const Text("Membership"),
      ),
      body: StreamBuilder<List<MembershipDetailsModel>>(
        stream: UserMembershipService().getAllMembership(userId, "active"),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<MembershipDetailsModel> data = snapshot.data;
            return data.isNotEmpty
                ? ListView.separated(
                    padding: const EdgeInsets.only(bottom: 30, top: 20),
                    separatorBuilder: (BuildContext context, int index) {
                      return 10.height;
                    },
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return mainMembershipItem(data[index], orange, context);
                    },
                  )
                : emptyList("No Membership Available Yet!");
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget membershipItemView(UserMembershipDetailsModel data) {
    return InkWell(
      onTap: () {
        SelectHotel(
          membershipData: data,
        );
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child:
                showNetworkImageWithCached(data.imageUrl ?? "", 30.h, 98.w, 8),
          ).paddingSymmetric(horizontal: 5),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 10.h,
                color: Colors.black.withOpacity(.3),
                child: ListView(
                  children: [
                    Text(
                      data.title ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: boldTextStyle(size: 20, color: Colors.white),
                    ),
                    Text(
                      data.description ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: secondaryTextStyle(color: Colors.white),
                    )
                  ],
                ).paddingSymmetric(horizontal: 10, vertical: 10),
              )),
        ],
      ),
    );
  }
}