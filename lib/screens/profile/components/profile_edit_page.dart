import 'package:flutter/material.dart';
import 'package:membership/screens/profile/components/profileCompomentsEdit.dart';
import 'package:membership/screens/profile/components/profileShapeImage.dart';
import 'package:nb_utils/nb_utils.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text("Edit Profile"),
        ),
        backgroundColor: Colors.black,
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          physics: const BouncingScrollPhysics(),
          children: [
            profileImage(),
            20.height,
            profileItemViewEdit(
              "Name",
              "Vijay",
              Icons.edit,
            ),
            16.height,
            profileItemViewEdit(
              "Gender",
              "Male",
              Icons.transgender,
            ),
            16.height,
            profileItemViewEdit(
              "Moble",
              "9999777522",
              Icons.verified,
            ),
            16.height,
            profileItemViewEdit(
              "Email",
              "kumar.vijay.roy@gmail.com",
              Icons.email,
            ),
            16.height,
            profileItemViewEdit(
              "City Selection",
              "Others",
              Icons.location_on,
            ),
          ],
        ).paddingSymmetric(horizontal: 10, vertical: 50));
  }
}