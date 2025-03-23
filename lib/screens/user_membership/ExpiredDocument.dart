import 'package:flutter/material.dart';
import 'package:membership/screens/user_membership/services/UserMembershipService.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../models/UserMembershipDetailsModel.dart';
import '../../utils/data/data_storage.dart';
import 'components/UserMembershipComponent.dart';

class ExpiredMembership extends StatefulWidget {
  const ExpiredMembership({Key? key}) : super(key: key);

  @override
  State<ExpiredMembership> createState() => _ExpiredMembershipState();
}

class _ExpiredMembershipState extends State<ExpiredMembership> {
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
        stream: UserMembershipService().getAllUserMembership(userId, "expired"),
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
                          data[index], redColor, context);
                    },
                  )
                : emptyList("No Expired Membership Available Yet!");
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}