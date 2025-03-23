import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:membership/services/PushNofitication.dart';
import 'package:nb_utils/nb_utils.dart';


class TestRuls extends StatefulWidget {
  const TestRuls({Key? key}) : super(key: key);

  @override
  State<TestRuls> createState() => _TestRulsState();
}

class _TestRulsState extends State<TestRuls> {
  // final checkUserUrl = "https://us-central1-urlifemebership.cloudfunctions.net/app/isuser";
  final checkUserUrl = PushNotification().baseUrl + "isuser";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Test Rules"),),
      body: SafeArea(
          child: Container(
            child: TextButton(onPressed: ()async{
              try {

                // final request = await httpClient.postUrl(Uri.parse(checkUserUrl));
                // request.headers.set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
                // request.add(utf8.encode(json.encode(requestBody)));
                // final response = await request.close();
                // response.transform(utf8.decoder).listen((contents) async {
                //   var jsonRes = json.decode(contents);
                //   Fluttertoast.showToast(msg: ""+ jsonRes['id']);
                //   var docId = jsonRes['id'];
                // });

              }catch( e){
                Fluttertoast.showToast(msg: "$e");
              }

            }, child: Text("Test")),
          )
      ),
    );
  }
}
