import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ticketmaster/models/my_model.dart';
import 'package:ticketmaster/screens/widget_setting.dart';
import 'package:ticketmaster/shared_preferences.dart';
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  MyModel myModel = MyModel(
    seat: '1',
    row: '2',
    sec: '5',
    showName: 'Example Show',
    showTime: 'sat.jun24.6.30 PM',
    showDetails: 'Lorem ipsum dolor sit amet.',
  );
  TextEditingController seatController = TextEditingController();
  TextEditingController rowController = TextEditingController();
  TextEditingController secController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController showTimeController = TextEditingController();
  bool isEditing = false;
  File? selectedImage; // Declare the selectedImage variable

  @override
  void initState() {
    super.initState();
    loadDataFromPreferences();
  }

  void loadDataFromPreferences() async {
    await SharedPreferencesService.initSharedPreferences();
    SharedPreferencesService.loadDataFromPreferences(myModel);

    setState(() {
      seatController.text = myModel.seat ?? '';
      rowController.text = myModel.row ?? '';
      secController.text = myModel.sec ?? '';
      nameController.text = myModel.showName ?? '';
      detailsController.text = myModel.showDetails ?? '';
      showTimeController.text = myModel.showTime ?? '';
    });
  }
  Future<void> uploadImage() async {
    final pickedImage = await SharedPreferencesService.pickImage();
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
      SharedPreferencesService.saveDataToPreferences(myModel, selectedImage);
    }
  }
  Future<void> updateValues() async {
    myModel.seat = seatController.text;
    myModel.row = rowController.text;
    myModel.sec = secController.text;
    myModel.showName = nameController.text;
    myModel.showDetails = detailsController.text;
    myModel.showTime = showTimeController.text;
    SharedPreferencesService.saveDataToPreferences(myModel, selectedImage);
    setState(() {
      isEditing = false;
    });
  }

  void startEditing() {
    setState(() {
      isEditing = true;
    });
  }

  @override
  void dispose() {
    seatController.dispose();
    rowController.dispose();
    secController.dispose();
    nameController.dispose();
    detailsController.dispose();
    showTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Tickets',style: myFontStyle(16,FontWeight.w500,Colors.white),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text('Help',style: myFontStyle(16,FontWeight.w500,Colors.white),),
          ),
        ],

      ),
      body: ListView(
        children: [
          Column(
            children: [
              if (!isEditing)
                InkWell(
                  onTap: () {
                    startEditing();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    height: 170,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: hexToColor("#2A6AE0"),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(vertical: 30),
                            child: Text(
                              'Standard Admission',
                              style: myFontStyle(
                                  16, FontWeight.w300, Colors.white),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "SEC",
                                  style: myFontStyle(
                                      20, FontWeight.w300, Colors.white),
                                ),
                                Text(
                                  '${myModel.sec}',
                                  style: myFontStyle(
                                      20, FontWeight.w500, Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "ROW",
                                  style: myFontStyle(
                                      20, FontWeight.w300, Colors.white),
                                ),
                                Text(
                                  '${myModel.row}',
                                  style: myFontStyle(
                                      20, FontWeight.w500, Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "SEAT",
                                  style: myFontStyle(
                                      20, FontWeight.w300, Colors.white),
                                ),
                                Text(
                                  '${myModel.seat}',
                                  style: myFontStyle(
                                      20, FontWeight.w500, Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              else
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      TextField(
                        controller: secController,
                        decoration: InputDecoration(labelText: 'SEC'),
                      ),
                      TextField(
                        controller: rowController,
                        decoration: InputDecoration(labelText: 'Row'),
                      ),
                      TextField(
                        controller: seatController,
                        decoration: InputDecoration(labelText: 'SEAT'),
                      ),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(labelText: 'Show Name'),
                      ),
                      TextField(
                        controller: detailsController,
                        decoration: InputDecoration(labelText: 'Show Details'),
                      ),
                      TextField(
                        controller: showTimeController,
                        decoration: InputDecoration(labelText: 'Time'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          uploadImage();
                        },
                        child: Text('Upload Image'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          updateValues();
                        },
                        child: Text('Update'),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            height: 250,
            width: double.infinity,
            child: Stack(
              children: [
                if (selectedImage != null)
                  Positioned.fill(
                    child: Image.file(
                      selectedImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 5,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2,vertical: 2),
                        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                        color: Colors.white.withOpacity(0.2),
                        child: Text(
                          "${myModel.showName}",
                          style: myFontStyle(20, FontWeight.w600, Colors.white),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2,vertical: 2),
                        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                        color: Colors.white.withOpacity(0.2),
                        child: Text(
                          "${myModel.showTime}",
                          style: myFontStyle(16, FontWeight.w500, Colors.white),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2,vertical: 2),
                        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                        color: Colors.white.withOpacity(0.2),
                        child: Text(
                          "${myModel.showDetails}",
                          style: myFontStyle(20, FontWeight.w500, Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Premier Seating".toUpperCase(),
                style: myFontStyle(20, FontWeight.w500, Colors.black),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 70),
            height: 60,
            decoration: BoxDecoration(
              color: hexToColor("#171717"),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    child: Image.asset(
                  'assets/images/wallet.jpg',
                  fit: BoxFit.cover,
                )),
                Text(
                  "Add to Apple Wallet",
                  style: myFontStyle(20, FontWeight.w400, Colors.white),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                    onPressed: () {},
                    child: Text(
                      'View Barcode',
                      style: myFontStyle(16, FontWeight.w600, Colors.blue),
                    )),
                MaterialButton(
                    onPressed: () {},
                    child: Text(
                      'Ticket Details',
                      style: myFontStyle(16, FontWeight.w600, Colors.blue),
                    )),
              ],
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            decoration: BoxDecoration(
                color: hexToColor('#036CE1'),
              borderRadius: BorderRadius.circular(10)
            ),
            child: InkWell(
              onTap: (){},
              child: Align(
                alignment: Alignment.center,
                  child: Text('ticketMaster.verified',style: myFontStyle(20,FontWeight.w300,Colors.white),)),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 50,
                  decoration: BoxDecoration(
                      color: hexToColor('#036CE1'),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: InkWell(
                    onTap: (){
                      showModalBottomSheet(
                        context: context,
                        isDismissible: true,
                        isScrollControlled: false,
                        builder: (context) {
                        return Container(child: Column(
                          children: [
                            Expanded(flex: 7,
                                child: TransferTicket(myModel: myModel)),
                            Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                              height: 10,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.arrow_back_ios,size: 20,color: Colors.blue,),
                                          Text('Back',style: myFontStyle(20,FontWeight.w500,Colors.blue),),
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                                        decoration: BoxDecoration(
                                          color: hexToColor('#256DD3'),
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Text('Trensfer 1 Ticket',style: myFontStyle(20,FontWeight.w500,Colors.white),),
                                      )
                                    ],
                                  ),
                            ))
                          ],
                        ));
                      },);
                    },
                    child: Align(
                        alignment: Alignment.center,
                        child: Text('Transfer',style: myFontStyle(20,FontWeight.w500,Colors.white),)),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 50,
                  decoration: BoxDecoration(
                      color: hexToColor('#E0E4E7'),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: InkWell(
                    onTap: (){},
                    child: Align(
                        alignment: Alignment.center,
                        child: Text('Sell',style: myFontStyle(20,FontWeight.w500,Colors.white),)),
                  ),
                ),
              ),
            ],),
          )
        ],
      ),
    );
  }
}

class TransferTicket extends StatelessWidget {
  const TransferTicket({
    super.key,
    required this.myModel,
  });

  final MyModel myModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 700,
      child: ListView(

        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Align(
              alignment: Alignment.center,
              child: Text('Transfer Tickets'.toUpperCase(),style: myFontStyle(16,FontWeight.w600,Colors.black54),),
            ),
          ),
          Container(
            height: 2,
            color: Colors.grey,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
            child: Text('1 Ticket Selected',style: myFontStyle(25,FontWeight.w400),),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
            child: Row(
              children: [
                Text('Sec ',style: myFontStyle(25,FontWeight.w400,Colors.grey),),
                Text('${myModel.sec}, ',style: myFontStyle(25,FontWeight.w400),),
                Text('Row ',style: myFontStyle(25,FontWeight.w400,Colors.grey),),
                Text('${myModel.row}, ',style: myFontStyle(25,FontWeight.w400),),
                Text('Seat ',style: myFontStyle(25,FontWeight.w400,Colors.grey),),
                Text('${myModel.seat}',style: myFontStyle(25,FontWeight.w400),),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text('First Name',style: myFontStyle(20,FontWeight.w400),),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    hintText:
                    "First Name",
                    hintStyle:myFontStyle(16,FontWeight.w500),
                    fillColor: Colors.white,
                    // Set the fill color
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3,color: Colors.black),
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
              ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text('Last Name',style: myFontStyle(20,FontWeight.w400),),
                ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    hintText:
                    "Last Name",
                    hintStyle:myFontStyle(16,FontWeight.w500),
                    fillColor: Colors.white,
                    // Set the fill color
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3,color: Colors.black),
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
              ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text('Email or Mobile Number',style: myFontStyle(20,FontWeight.w400),),
                ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    hintText:
                    "Email or Mobile Number",
                    hintStyle:myFontStyle(16,FontWeight.w500),
                    fillColor: Colors.white,
                    // Set the fill color
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3,color: Colors.black),
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
              ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text('Note',style: myFontStyle(20,FontWeight.w400),),
                ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                height: 100,
                child: TextField(
                  decoration: InputDecoration(
                    hintText:
                    "",
                    hintStyle:myFontStyle(16,FontWeight.w500),
                    fillColor: Colors.white,
                    // Set the fill color
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3,color: Colors.black),
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
              ),
            ],),
          )
        ],
      ),
    );
  }
}
