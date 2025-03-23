import 'package:flutter/material.dart';
import 'package:membership/models/UserMembershipDetailsModel.dart';
import 'package:membership/models/brand/HotelModel.dart';
import 'package:membership/screens/membership/services/MembershipService.dart';
import 'package:membership/utils/data/data_storage.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/colors.dart';
import '../user_membership/components/UserMembershipComponent.dart';
import 'HotelComponents.dart';

class SelectHotel extends StatefulWidget {
  final UserMembershipDetailsModel membershipData;

  const SelectHotel({Key? key, required this.membershipData}) : super(key: key);

  @override
  State<SelectHotel> createState() => _SelectHotelState();
}

class _SelectHotelState extends State<SelectHotel> {
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
        title: Text("Hotels"),
      ),
      body: StreamBuilder<List<HotelModal>>(
        stream: MembershipService()
            .getAllHotels(userId, widget.membershipData.id ?? ""),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<HotelModal> data = snapshot.data;
            return data.isNotEmpty
                ? ListView.separated(
                    padding: const EdgeInsets.only(bottom: 30, top: 20),
                    separatorBuilder: (BuildContext context, int index) {
                      return 10.height;
                    },
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return membershipItemView(data[index]);
                    },
                  )
                : emptyList("No Hotels Available Yet For Booking");
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget membershipItemView(HotelModal data) {
    return InkWell(
      onTap: () {
        calenderSheet(context, data, widget.membershipData);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 13),
        decoration:
            boxDecorationRoundedWithShadow(12, backgroundColor: fillColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Image.network(
                    data.image ??
                        "http://yesofcorsa.com/wp-content/uploads/2017/04/Hotels-High-Quality-Wallpaper.jpg",
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.fill,
                  )),
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text("${data.name}, ${widget.membershipData.membershipNumber}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: boldTextStyle(color: white, size: 18),
                      ).paddingTop(4),
                    ),
                    2.height,
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 1.22,
                        child: Text(
                          data.description ?? "",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: secondaryTextStyle(
                              color: white, size: 10, weight: FontWeight.bold),
                        ).paddingTop(8)),
                    2.height,
                  ],
                )
              ],
            ).paddingSymmetric(vertical: 5, horizontal: 1),
          ],
        ).paddingSymmetric(horizontal: 10, vertical: 10),
      ),
    );
  }
}
