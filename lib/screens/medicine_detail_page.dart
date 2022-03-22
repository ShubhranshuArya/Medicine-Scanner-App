import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:medicine_scanner/model/medicine_model.dart';
import 'package:medicine_scanner/screens/qr_scanner_page.dart';
import 'package:medicine_scanner/services/google_sheet_services.dart';

class MedicineDetailPage extends StatefulWidget {
  int barcode;
  MedicineDetailPage({
    required this.barcode,
    Key? key,
  }) : super(key: key);

  @override
  State<MedicineDetailPage> createState() => _MedicineDetailPageState();
}

class _MedicineDetailPageState extends State<MedicineDetailPage> {
  MedicineModel? medicineData;
  bool isFetched = false;
  bool isValid = false;
  bool isConnected = false;

  @override
  void initState() {
    checkInternetConnectivity();
    super.initState();
  }

  fetchData() async {
    setState(() {
      isValid = true;
    });
    medicineData = await GoogleSheetServices().getMedDataById(widget.barcode);
    if (medicineData != null) {
      setState(() {
        isFetched = true;
      });
    }
  }

  String listToSentence(sideEffects) {
    return sideEffects.join(', ');
  }

  checkInternetConnectivity() async {
    bool result = await InternetConnectionChecker().hasConnection;
    setState(() {
      isConnected = result;
    });
    if (isConnected && widget.barcode != -1) {
      fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: !isConnected
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "NO INTERNET\nCONNECTION",
                      style: GoogleFonts.montserrat(
                        color: Colors.blueAccent,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        checkInternetConnectivity();
                      },
                      child: Container(
                        height: 50,
                        width: 140,
                        decoration: BoxDecoration(
                          color: Colors.indigoAccent.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                            child: Text(
                          'Refresh',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              )
            : !isValid
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.26,
                        bottom: height * 0.06,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.center_focus_weak_outlined,
                            color: Colors.black.withOpacity(0.6),
                            size: size.aspectRatio * 200,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Invalid QR Code\nDetected',
                            style: GoogleFonts.montserrat(
                              color: Colors.blueAccent,
                              fontSize: size.aspectRatio * 60,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Spacer(),
                          scanQrButton(size)
                        ],
                      ),
                    ),
                  )
                : !isFetched
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.lightBlueAccent,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 40,
                          horizontal: 20,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                medicineData!.name ?? 'NA',
                                style: GoogleFonts.montserrat(
                                  color: Colors.indigoAccent,
                                  fontSize: size.aspectRatio * 60,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
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
                                      'Usage',
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
                                      listToSentence(medicineData!.usage),
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
                                      'Side Effects',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: size.aspectRatio * 40,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      listToSentence(medicineData!.sideEffects),
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
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Composition',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: size.aspectRatio * 40,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      medicineData!.composition ?? 'NA',
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
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: IntrinsicHeight(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        top: 10,
                                        bottom: 20,
                                        left: 20,
                                        right: 20,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Manufacturer',
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
                                            medicineData!.manufacturer ?? 'NA',
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
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      20.0)), //this right here
                                          child: Container(
                                            padding: EdgeInsets.all(20),
                                            child: Image.network(
                                              medicineData!.qrLink ??
                                                  //TODO :  show a dummy qr code
                                                  "https://quickchart.io/qr?text=1",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: height * 0.1,
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.qr_code_rounded,
                                          size: 40,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            scanQrButton(size),
                          ],
                        ),
                      ),
      ),
    );
  }

  Widget scanQrButton(Size size) => InkWell(
        borderRadius: BorderRadius.circular(8),
        splashColor: Colors.blue,
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          height: size.height * 0.072,
          width: size.width * 0.42,
          decoration: BoxDecoration(
            color: Colors.indigoAccent.withOpacity(0.8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
              child: Text(
            'Scan QR',
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: size.aspectRatio * 48,
              fontWeight: FontWeight.w500,
            ),
          )),
        ),
      );
}
