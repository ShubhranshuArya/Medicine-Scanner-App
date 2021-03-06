import 'dart:ffi';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicine_scanner/screens/developer_information_page.dart';
import 'package:medicine_scanner/screens/medicine_detail_page.dart';
import 'package:medicine_scanner/screens/scanned_medicine_list_page.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScannerPage extends StatefulWidget {
  QrScannerPage({Key? key}) : super(key: key);

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  final qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          qrViewWidget(),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScannedMedicineListPage(),
                  ),
                );
              },
              icon: Icon(
                Icons.document_scanner_outlined,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeveloperInformationPage(),
                  ),
                );
              },
              icon: Icon(
                CupertinoIcons.info_circle,
                color: Colors.white,
                size: 36,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MedicineDetailPage(
                    barcode: 109,
                  ),
                ),
              );
            },
            child: Text("Test Button"),
          ),
          Positioned(
            bottom: 60,
            child: Text(
              'Scan a QR code or\nSpot code to connect',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget qrViewWidget() => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          cutOutSize: MediaQuery.of(context).size.width * 0.72,
          borderWidth: 12,
          borderLength: 24,
          borderRadius: 10,
          borderColor: Colors.white,
          overlayColor: Colors.black.withOpacity(0.6),
        ),
      );

  void onQRViewCreated(QRViewController controller) async {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen(
      (barcode) {
        controller.pauseCamera();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MedicineDetailPage(
              barcode: int.parse(barcode.code ?? '-1'),
            ),
          ),
        ).then(
          (value) => controller.resumeCamera(),
        );
      },
    );
  }
}
