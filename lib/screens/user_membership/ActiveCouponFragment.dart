import 'package:flutter/material.dart';
import 'package:membership/models/UserMembershipDetailsModel.dart';
import 'package:membership/screens/user_membership/UserCouponScreen.dart';
import 'package:membership/screens/user_membership/services/UserMembershipService.dart';
import 'package:membership/utils/data/data_storage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../utils/styles/ImageView.dart';
import 'components/UserMembershipComponent.dart';

class ActiveMembershiFragment extends StatefulWidget {
  const ActiveMembershiFragment({Key? key}) : super(key: key);

  @override
  State<ActiveMembershiFragment> createState() => _ActiveMembershiFragmentState();
}

class _ActiveMembershiFragmentState extends State<ActiveMembershiFragment> {
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
      body: StreamBuilder<List<UserMembershipDetailsModel>>(
        stream: UserMembershipService().getAllUserMembership(userId, "active"),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<UserMembershipDetailsModel> data = snapshot.data;
            return data.isNotEmpty
                ? ListView.separated(
                    padding: const EdgeInsets.only(bottom: 30, top: 20),
                    separatorBuilder: (BuildContext context, int index) {
                      return 10.height;
                    },
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return membershipSingleItemView(
                          data[index], orange, context);
                    },
                  )
                : emptyList("No Active Membership Available Yet!");
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
        if (data.isVerified == true) {
          UserCouponScreen(membershipData: data).launch(context);
        } else {
          Fluttertoast.showToast(msg: "Please wait for admin approval");
        }
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
