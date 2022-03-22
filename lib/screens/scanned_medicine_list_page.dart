import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medicine_scanner/database/medicine_database.dart';
import 'package:medicine_scanner/model/scanned_medicine_model.dart';

class ScannedMedicineListPage extends StatefulWidget {
  const ScannedMedicineListPage({Key? key}) : super(key: key);

  @override
  State<ScannedMedicineListPage> createState() =>
      _ScannedMedicineListPageState();
}

class _ScannedMedicineListPageState extends State<ScannedMedicineListPage> {
  late List<ScannedMedicineModel> scannedMedicine;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    refreshLocalMedData();
  }

  // @override
  // void dispose() {
  //   MedicineDatabase.instance.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
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
          "Scanned Medicine",
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.lightBlueAccent,
                ),
              )
            : scannedMedicine.isEmpty
                ? Center(
                    child: Text(
                      'No Medicine\nScanned',
                      style: GoogleFonts.montserrat(
                        color: Colors.blueAccent,
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: scannedMedicine.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 16,
                          right: 16,
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          selected: true,
                          selectedTileColor: Colors.indigoAccent.withOpacity(0.2),
                          title: Text(
                            scannedMedicine[index].name ?? "NA",
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          trailing: Text(
                            DateFormat('kk:mm \n EEE d MMM').format(
                                scannedMedicine[index].scannedTime ??
                                    DateTime.now()),
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }

  Future refreshLocalMedData() async {
    setState(() => isLoading = true);
    this.scannedMedicine =
        await MedicineDatabase.instance.readAllScannedMedicine();
    setState(() => isLoading = false);
  }
}
