import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_scanner/model/medicine_model.dart';
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

  @override
  void initState() {
    if (widget.barcode != -1) {
      testData();
    }
    super.initState();
  }

  testData() async {
    // TODO: take id from the qr scanner screen
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: !isValid
            ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'No QR Code\nDetected',
                      style: GoogleFonts.montserrat(
                        color: Colors.blueAccent,
                        fontSize: size.aspectRatio * 60,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    scanQrButton(size)
                  ],
                ),
            )
            : !isFetched
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
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
                              color: Colors.blueAccent,
                              fontSize: size.aspectRatio * 60,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          height: height * 0.1,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Usage',
                                style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: size.aspectRatio * 40,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: medicineData!.usage!.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  return Text(
                                    (index == medicineData!.usage!.length - 1)
                                        ? medicineData!.usage![index] ?? 'NA'
                                        : '${medicineData!.usage![index]},',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: size.aspectRatio * 36,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // TODO: Make this intrinsic
                          height: height * 0.24,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Side Effects',
                                style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: size.aspectRatio * 40,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: medicineData!.sideEffects!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Text(
                                    (index ==
                                            medicineData!.sideEffects!.length -
                                                1)
                                        ? medicineData!.sideEffects![index] ??
                                            'NA'
                                        : '${medicineData!.sideEffects![index]},',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: size.aspectRatio * 36,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        IntrinsicHeight(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Composition',
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
                                  medicineData!.composition ?? 'NA',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: size.aspectRatio * 36,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 16,
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
                                  padding: EdgeInsets.all(12),
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
                                        height: 12,
                                      ),
                                      Text(
                                        medicineData!.manufacturer ?? 'NA',
                                        style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontSize: size.aspectRatio * 36,
                                          fontWeight: FontWeight.w500,
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
                                    builder: (BuildContext context) => Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
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
            color: Colors.blue.withOpacity(0.8),
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
