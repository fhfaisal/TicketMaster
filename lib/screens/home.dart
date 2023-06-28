import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticketmaster/models/category.dart';
import 'package:ticketmaster/screens/event_page.dart';
import 'package:ticketmaster/screens/slider.dart';
import 'package:ticketmaster/screens/widget_setting.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.only(bottom: 30),
                width: double.infinity,
                color: hexToColor("#1B232E"),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "ticketmaster",
                          style: GoogleFonts.poppins(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                          color: hexToColor("#2b2f36"),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.place,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Text("City or Zip...",
                                          style: myFontStyle(
                                              16,
                                              FontWeight.normal,
                                              Colors.white))
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.calendar_today,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Text("All Dates",
                                          style: myFontStyle(
                                              16,
                                              FontWeight.normal,
                                              Colors.white))
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 45,
                              child: TextField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  hintText:
                                      "Search for aritists,venues,and...",
                                  hintStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                  fillColor: Colors.white,
                                  // Set the fill color
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                  child: ListView(
                children: [
                  Container(height: 200, child: CustomSlider()),
                  Container(height: 100, child: CustomSliderText()),
                ],
              )),
            ),
            Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ListView(
                  children: [
                    Text(
                      "Top Selling",
                      style: GoogleFonts.poppins(
                          fontSize: 25, fontWeight: FontWeight.w400),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Consert",
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "See All",
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: categoryList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      width: mq.width * .30,
                                      height: mq.height * .15,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50))),
                                      child: Image.asset(
                                        '${categoryList[index].image}',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${categoryList[index].aritistName}",
                                            style: myFontStyle(
                                                20, FontWeight.w500),
                                          ),
                                          Text(
                                            "${categoryList[index].categoryName}",
                                            style: myFontStyle(16,
                                                FontWeight.normal, Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 5,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            Expanded(child: Container(
              height: 50,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8,),
                    child: Column(
                      children: [
                        Icon(Icons.search,color: Colors.grey,),
                        Text('Discover',style: myFontStyle(10,FontWeight.normal,Colors.grey),)
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8,),
                    child: Column(
                      children: [
                        Icon(Icons.favorite,color: Colors.grey,),
                        Text('Favorite',style: myFontStyle(10,FontWeight.normal,Colors.grey),)
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8,),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyWidget()),
                            );
                          },
                          child: Icon(Icons.ev_station_rounded, color: Colors.grey),
                        ),
                        Text(
                          'My Events',
                          style: myFontStyle(10, FontWeight.normal, Colors.grey),
                        ),

                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8,),
                    child: Column(
                      children: [
                        Icon(Icons.money,color: Colors.grey,),
                        Text('Sell',style: myFontStyle(10,FontWeight.normal,Colors.grey),)
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8,),
                    child: Column(
                      children: [
                        Icon(Icons.person,color: Colors.grey,),
                        Text('My Account',style: myFontStyle(10,FontWeight.normal,Colors.grey),)
                      ],
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
