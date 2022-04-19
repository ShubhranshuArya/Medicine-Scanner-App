import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeveloperInformationPage extends StatelessWidget {
  const DeveloperInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        backgroundColor: Colors.indigoAccent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        centerTitle: true,
        title: Text(
          "About Us",
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 20,
        ),
        child: Column(
          children: [
            IntrinsicHeight(
              child: Container(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      'Developed by',
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: size.aspectRatio * 40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Adam Andrew Frank",
                      style: GoogleFonts.montserrat(
                        color: Colors.blueAccent,
                        fontSize: size.aspectRatio * 40,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Joel Jacob Tomson",
                      style: GoogleFonts.montserrat(
                        color: Colors.blueAccent,
                        fontSize: size.aspectRatio * 40,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            IntrinsicHeight(
              child: Container(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      'Under the guidance of',
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: size.aspectRatio * 40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Prof. Anuradha B. Mistry",
                      style: GoogleFonts.montserrat(
                        color: Colors.blueAccent,
                        fontSize: size.aspectRatio * 40,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            IntrinsicHeight(
              child: Container(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      'Special thanks to',
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: size.aspectRatio * 40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Shubhranshu Arya",
                      style: GoogleFonts.montserrat(
                        color: Colors.blueAccent,
                        fontSize: size.aspectRatio * 40,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
