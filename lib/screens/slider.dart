import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomSlider extends StatelessWidget {
  const CustomSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
        indicatorColor: Colors.transparent,
        indicatorBackgroundColor: Colors.transparent,
        onPageChanged: (value) {
          debugPrint('Page changed: $value');
        },
        autoPlayInterval:5000,
        isLoop: true,
        children: [
          Image.asset(
            'assets/images/sample_image_1.jpg',
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/sample_image_2.jpg',
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/sample_image_3.jpg',
            fit: BoxFit.cover,
          ),
        ],
      );
  }
}
class CustomSliderText extends StatelessWidget {
  const CustomSliderText({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
        indicatorColor: Colors.blue,
        onPageChanged: (value) {
          debugPrint('Page changed: $value');
        },
        autoPlayInterval:5000,
        isLoop: true,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text("2023 NFL Tickets",style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.blue)),
                Text("The 2023 NFL schedule is here. Shop a wide selection of seats at Ticketmaster",style: GoogleFonts.poppins(fontSize: 14,)),


              ],
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("2023 NFL Tickets",style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.blue)),
                Text("The 2023 NFL schedule is here. Shop a wide selection of seats at Ticketmaster",style: GoogleFonts.poppins(fontSize: 14,)),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("2023 NFL Tickets",style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.blue)),
                Text("The 2023 NFL schedule is here. Shop a wide selection of seats at Ticketmaster",style: GoogleFonts.poppins(fontSize: 14,)),
              ],
            ),
          ),

        ],
      );
  }
}
