library globals;

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

String selectedStartDate = "";
String selectedEndDate = "";
bool isComplementary = false;
int selectedNum = 0;
bool selectedList = false;
bool isRejected = false;
DateTime currentDate = DateTime.now();
String todayDate = DateFormat("yyyy-MM-dd").format(currentDate);
String agentId = "";
var numberOfRoomsController = TextEditingController();
