import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReferPage extends StatefulWidget {
  const ReferPage({Key? key}) : super(key: key);

  @override
  State<ReferPage> createState() => _ReferPageState();
}

class _ReferPageState extends State<ReferPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Refer & Earn",
          style: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
                height: 0.6,
                width: 100,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.grey.withOpacity(.4),
                        Colors.purpleAccent.withOpacity(.1)
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.topRight,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    "Earninge रु0",
                    style: TextStyle(
                        color: Colors.grey.withOpacity(0.6),
                        fontWeight: FontWeight.normal,
                        fontSize: 11),
                  ),
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Text(
                  "Earn रु200 on every referral",
                  style: TextStyle(
                      color: Colors.orangeAccent.withOpacity(.5),
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Text(
                "and your friends get रु200 off",
                style: TextStyle(
                    color: Colors.white.withOpacity(.5),
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
              Image.asset("images/assets/refer.jpg"),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 3),
                child: Container(
                    height: 70,
                    width: 700,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.deepOrangeAccent.withOpacity(.2),
                          Colors.deepOrangeAccent.withOpacity(.2)
                        ]),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        const Expanded(
                            child: Padding(
                          padding: EdgeInsets.only(left: 18.0, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Your referral code",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "VIJA7522",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          ),
                        )),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              //height: 10,
                             // minWidth: 150,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: Colors.orangeAccent.withOpacity(0.3),
                            ),

                            onPressed: () {},
                            child: const Center(
                              child: Text(
                                "REFER NOW",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
              const SizedBox(
                height: 60,
              ),
              Text(
                "or share via",
                style: TextStyle(
                    color: Colors.white.withOpacity(.7),
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.white.withOpacity(.2),
                            Colors.white.withOpacity(.2)
                          ]),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset("images/assets/whatsapp.png"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.white.withOpacity(.2),
                            Colors.white.withOpacity(.2)
                          ]),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset("images/assets/Telegram.png"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Colors.white.withOpacity(.2),
                            Colors.white.withOpacity(.2)
                          ]),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          "images/assets/Instagram.webp",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ) //   Image.network("")
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                height: 280,
                width: 350,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepPurple.withOpacity(.2),
                        Colors.deepPurple.withOpacity(.2)
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 18.0),
                      child: Text(
                        "How referral works",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(.6),
                            child: const Icon(
                              CupertinoIcons.person_circle,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Invite your friends",
                                style: TextStyle(
                                    color: Colors.brown.withOpacity(.7),
                                    fontSize: 12),
                              ),
                              Text(
                                "Share your referral code with your",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.7),
                                    fontSize: 10),
                              ),
                              Text(
                                "friend",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.7),
                                    fontSize: 10),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(.6),
                            child: const Icon(
                              CupertinoIcons.person_circle,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "They will join",
                                style: TextStyle(
                                    color: Colors.brown.withOpacity(.7),
                                    fontSize: 12),
                              ),
                              Text(
                                "They will get रु200 off through your",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.7),
                                    fontSize: 10),
                              ),
                              Text(
                                "code",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.7),
                                    fontSize: 10),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(.6),
                            child: const Icon(
                              CupertinoIcons.person_circle,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "You will earn",
                                style: TextStyle(
                                    color: Colors.brown.withOpacity(.7),
                                    fontSize: 12),
                              ),
                              Text(
                                "रु200 Paytm cashbank on your",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.7),
                                    fontSize: 10),
                              ),
                              Text(
                                "registered mobile number!",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.7),
                                    fontSize: 10),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13.0, right: 13),
                child: TextButton(
                  style: TextButton.styleFrom(
                   // height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: Colors.deepPurple.withOpacity(0.2),
                  ),
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Expanded(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "FAQs",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        )),
                        Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13.0, right: 13),
                child: TextButton(
                style: TextButton.styleFrom(
                  //height: 40,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Colors.deepPurple.withOpacity(0.2),
                ),
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Expanded(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Terms & conditions",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        )),
                        Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}