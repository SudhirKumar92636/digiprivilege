import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:membership/utils/data/data_storage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../services/FirebaseServices.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool _isValid = false;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  String firstname = "";
  String lastName = "";
  String email = "";
  bool status = false;
  String gender = "gender";
  var controller = TextEditingController();
  String? dropdownValue;
  final formKey1 = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController lastController;
  late TextEditingController emailController;
  var service = FirebaseServices();
  List<String> spinnerItems = [
    'Male',
    'Female',
    'Other',
  ];

  Future getDocId() async {
    var docId = await AppData.getString(docIdKey);
    print("docID $docId");
    var details =
        await FirebaseFirestore.instance.collection('users').doc(docId).get();
    setState(
      () {
        firstname = details.data()!['first_name'];
        lastName = details.data()!['last_name'];
        email = details.data()!['email'];
        gender = details.data()!['gender'];
        status = details.data()!['status'];

        AppData.setString(firstNameKey, firstname);
        AppData.setString(lastNameKey, lastName);
        AppData.setString(genderKey, gender);
        AppData.setString(emailKey, email);
      },
    );
  }

  _saveDetails() async {
    var docId = await AppData.getString(docIdKey);

    service.updateDetails({
      "status": true,
      "new_user": true,
      'gender': gender,
      'first_name': nameController.text,
      'last_name': lastController.text,
      'email': emailController.text,
    }, docId).then((value) {
      Navigator.pop(context, "refreshed");
    });
  }

  @override
  void initState() {
    getDocId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            const CircleAvatar(
              backgroundColor: Colors.red,
              radius: 60,
              child: CircleAvatar(
                radius: 110,
                backgroundImage: NetworkImage(
                  'https://cdn.pixabay.com/photo/2014/07/09/10/04/man-388104_960_720.jpg',
                ),
              ),
            ).paddingSymmetric(vertical: 10),
            SizedBox(
              height: 50,
            ),
            EditDetails(
              edithint: "Enter your first name",
              validity: "",
              firstnameController: nameController =
                  TextEditingController(text: firstname),
            ),
            EditDetails(
              edithint: "Enter your last name",
              validity: "",
              firstnameController: lastController =
                  TextEditingController(text: lastName),
            ),
            EditDetails(
              edithint: "Enter your email",
              validity: "",
              firstnameController: emailController =
                  TextEditingController(text: email),
            ),
            Container(
              width: 100.h,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: DropdownButton(
                  isExpanded: true,
                  value: dropdownValue,
                  underline: Container(),
                  style: const TextStyle(color: Colors.orange),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                  items: spinnerItems.map((spinnerItems) {
                    return DropdownMenuItem(
                        value: spinnerItems, child: Text(spinnerItems));
                  }).toList(),
                  hint: Text(
                    gender,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      gender = dropdownValue!;
                    });
                  },
                ).paddingSymmetric(horizontal: 15),
              ),
            ).paddingSymmetric(horizontal: 20, vertical: 10),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                _isValid = EmailValidator.validate(emailController.text);
                if (_isValid) {
                  _saveDetails();
                } else if (emailController.text.isEmpty) {
                  Fluttertoast.showToast(
                      msg: 'Enter Email',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      fontSize: 16.0);
                } else {
                  Fluttertoast.showToast(
                      msg: 'Enter a Valid Email $status',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      fontSize: 16.0);
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                height: 7.h,
                width: 200,
                decoration: boxDecorationRoundedWithShadow(30,
                    backgroundColor: Colors.orange, shadowColor: Colors.black),
                child: Center(
                  child: Text(
                    "Save",
                    style: boldTextStyle(color: white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ));
  }

  EditDetails({
    required String edithint,
    required String validity,
    required TextEditingController firstnameController,
  }) {
    return Container(
      child: TextFormField(
        textInputAction: TextInputAction.next,
        controller: firstnameController,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            fillColor: grey.withOpacity(.3),
            filled: true,
            hintText: edithint,
            hintStyle: TextStyle(color: Colors.white),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 1, color: Colors.orange)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 1, color: white))),
      ).paddingSymmetric(horizontal: 20, vertical: 10),
    );
  }
}
