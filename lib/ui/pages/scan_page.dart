import 'dart:convert';
import 'dart:io';

import 'package:community_sos/app/trusted_list.dart';
import 'package:community_sos/ui/pages/add_contact_page.dart';
import 'package:community_sos/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanPage extends StatefulWidget {

  static const String route = "/scan_page";

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Barcode qrText;
  QRViewController controller;
  bool isFlashOn = false;
  bool isFrontCamera = false;
  bool _isLoading = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Scan a contact",
          style: TextStyle(color: Colors.white, fontFamily: "RobotoMedium"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: _buildQrView(context),
          ),
          Visibility(
            visible: _isLoading,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 200.0),
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
            child: Text(
              "Align the QR code within the frame to scan",
              style: TextStyle(color: Colors.white, fontSize: 24.0,fontFamily: "RobotoMedium"),
              textAlign: TextAlign.center,

            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: 300),
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      if (_isLoading) {
        return;
      }

      this.controller.pauseCamera();

      setState(() {
        qrText = scanData;
        _isLoading = true;
      });

      print(qrText.code);

      try {
        var contactJson = json.decode(qrText.code);
        if (contactJson['name'] !=null && contactJson['phone'] != null && contactJson['desc'] != null && contactJson['key'] != null) {
          print("hello");
          final Contact contact = Contact.fromJson(contactJson);
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AddContactPage(contact: contact)), ModalRoute.withName(HomePage.route));
        } else {
          invalidQrCode();
        }
      } catch (error) {
        invalidQrCode();
        print(error);
      }
    });
  }

  void invalidQrCode() async{
    showSnackBarMessage("invalid qrcode");
    setState(() {
      _isLoading = false;
    });
    await this.controller.resumeCamera();
  }

  void showSnackBarMessage(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(backgroundColor: Colors.redAccent, content: Text(message)));
  }
}
