
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:labkesehatanehatan/API/Server.dart';
import 'package:labkesehatanehatan/Hematologi/InputHematologi.dart';
import 'package:labkesehatanehatan/Hematologi/InputImmunoserologi.dart';
import 'package:labkesehatanehatan/Hematologi/InputKimiaDarah.dart';
import 'package:labkesehatanehatan/Hematologi/InputSedimen.dart';
import 'package:labkesehatanehatan/Hematologi/InputSemua.dart';
import 'package:labkesehatanehatan/Hematologi/InputUrinalisa.dart';
import 'package:labkesehatanehatan/Model/PDFBuilderKimiaDarah.dart';
import 'package:path_provider/path_provider.dart';

import '../Constant/SizeData.dart';
import '../Constant/colors.dart';
import '../Model/Ascendant.dart';
import '../Model/PDFBuilderHematologi.dart';
import 'package:http/http.dart' as http;

class AdapterButton extends StatefulWidget {
  String id;
  String img;
  String nama;
  String detail;
  String id_category;
  AdapterButton({Key? key,
    required this.id,
    required this.img,
    required this.nama,
    required this.detail,
    required this.id_category
  });
  @override
  State<AdapterButton> createState() => _AdapterButtonState();
}

class _AdapterButtonState extends State<AdapterButton> with SingleTickerProviderStateMixin{
  late AnimationController animationController;
  late Animation animation;
  late Animation padding;
  bool selected = false;



  Future<void> DaftarPasien() async{
    final url = Uri.parse(getServerName()+TambahPasien());
    final request = http.MultipartRequest('POST', url);
    request.fields['nama'] = cNama.text;
    request.fields['umur'] = cUmur.text;
    request.fields['nrp'] = cNRP.text;
    request.fields['nip'] = cNIP.text;
    request.fields['nik'] = cNIK.text;
    request.fields['pangkat'] = cPangkat.text;
    request.fields['kesatuan'] = cKesatuan.text;

    final response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(cNIP.text);
    if(jsonDecode(respStr)['code'].toString()=="0"){
      Message(context,jsonDecode(respStr)['Message']);
    }else{
      Message(context,jsonDecode(respStr)['Message']);
    }
  }

  //Controller Daftar Pasien
  TextEditingController cNama = new TextEditingController();
  TextEditingController cUmur = new TextEditingController();
  TextEditingController cNRP = new TextEditingController();
  TextEditingController cNIP = new TextEditingController();
  TextEditingController cNIK = new TextEditingController();
  TextEditingController cPangkat = new TextEditingController();
  TextEditingController cKesatuan = new TextEditingController();
  TextEditingController cPemeriksa = new TextEditingController();

  //Controller Hematologi
  TextEditingController cHematologiNama = new TextEditingController();
  TextEditingController cHematologiUmur = new TextEditingController();
  TextEditingController cHematologiNRP = new TextEditingController();
  TextEditingController cHematologiNIP = new TextEditingController();
  TextEditingController cHematologiNIK = new TextEditingController();
  TextEditingController cHematologiPangkat = new TextEditingController();
  TextEditingController cHematologiKesatuan = new TextEditingController();
  TextEditingController cHematologiPemeriksa = new TextEditingController();

  TextEditingController cHematologiHemogoblin = new TextEditingController();
  TextEditingController cHematologiLekosit = new TextEditingController();
  TextEditingController cHematologiEritrosit = new TextEditingController();
  TextEditingController cHematologiHematokrit = new TextEditingController();
  TextEditingController cHematologiTrombosit = new TextEditingController();
  TextEditingController cHematologiLED = new TextEditingController();

  //Controller Kimia Darah
  TextEditingController cKimiaDarahNama = new TextEditingController();
  TextEditingController cKimiaDarahUmur = new TextEditingController();
  TextEditingController cKimiaDarahNRP = new TextEditingController();
  TextEditingController cKimiaDarahNIP = new TextEditingController();
  TextEditingController cKimiaDarahNIK = new TextEditingController();
  TextEditingController cKimiaDarahPangkat = new TextEditingController();
  TextEditingController cKimiaDarahKesatuan = new TextEditingController();
  TextEditingController cKimiaDarahPemeriksa = new TextEditingController();


  TextEditingController cKimiaDarahBilurubinTotal = new TextEditingController();
  TextEditingController cKimiaDarahBilurubinDirect = new TextEditingController();
  TextEditingController cKimiaDarahBILURUBININDERECT = new TextEditingController();
  TextEditingController cKimiaDarahSGOT = new TextEditingController();
  TextEditingController cKimiaDarahSGPT = new TextEditingController();
  TextEditingController cKimiaDarahCHOLESTROLTOTAL = new TextEditingController();
  TextEditingController cKimiaDarahCHOLESTROHDL = new TextEditingController();
  TextEditingController cKimiaDarahCHOLESTROLDL = new TextEditingController();
  TextEditingController cKimiaDarahTRIGLISERIDA = new TextEditingController();
  TextEditingController cKimiaDarahUREUM = new TextEditingController();
  TextEditingController cKimiaDarahCREATININ = new TextEditingController();
  TextEditingController cKimiaDarahASAMURAT = new TextEditingController();
  TextEditingController cKimiaDarahGULADARAHPUASA = new TextEditingController();
  TextEditingController cKimiaDarahGULADARAH2JAMPP = new TextEditingController();
  TextEditingController cKimiaDarahGULADARAHSEWAKTU = new TextEditingController();
  void Clicker(){

    if(widget.nama.toString()=="Hematologi"){
      Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: Duration(seconds: 1),
              transitionsBuilder: (
                  BuildContext context,
                  Animation<double> animation,
                  Animation<double> secAnimation,
                  Widget child) {
                animation = CurvedAnimation(
                    parent: animation,
                    curve: Curves.elasticInOut
                );
                return ScaleTransition(
                  scale: animation,
                  child: child,
                  alignment: Alignment.center,
                );
              },
              pageBuilder: (
                  BuildContext context,
                  Animation<double> animation,
                  Animation<double> secAnimation
                  )
              {
                return InputHematologi();
              }
          )
      );

      // AwesomeDialog(
      //     context: context,
      //     dismissOnTouchOutside: true,
      //     dismissOnBackKeyPress: true,
      //     dialogType: DialogType.question,
      //     animType: AnimType.topSlide,
      //     btnOkText: "Buat PDF",
      //     title: "Hematologi",
      //     btnOkIcon: Icons.print,
      //     btnCancelIcon: Icons.close,
      //     desc: "Silahkan isi Data untuk Hematologi",
      //     width: 1000,
      //     body: Column(
      //       children: [
      //         Container(
      //           height: 50,
      //           width: double.maxFinite,
      //           margin: EdgeInsets.all(5),
      //           decoration: BoxDecoration(
      //               color: PrimaryColors(),
      //               borderRadius: BorderRadius.circular(10)
      //           ),
      //           child: Center(
      //             child: Text(
      //               "Data Pasien",
      //               style: TextStyle(
      //                   fontSize: 20,
      //                   color: Colors.white
      //               ),
      //             ),
      //           ),
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cHematologiNama,
      //                     enabled: false,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Nama Pasien',
      //                         labelText: 'Nama Pasien',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cHematologiNama.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cHematologiNama.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cHematologiUmur,
      //                     enabled: false,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Umur Pasien',
      //                         labelText: 'Umur Pasien',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cHematologiUmur.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cHematologiUmur.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     enabled: false,
      //                     controller: cHematologiNRP,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan NRP Pasien',
      //                         labelText: 'NRP',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cHematologiNRP.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cHematologiNRP.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     enabled: false,
      //                     controller: cHematologiNIP,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan NIP',
      //                         labelText: 'NIP',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cHematologiNIP.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cHematologiNIP.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cHematologiNIK,
      //                     enabled: false,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan NIK Pasien',
      //                         labelText: 'NIK',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cHematologiNIK.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cHematologiNIK.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     enabled: false,
      //                     controller: cHematologiPangkat,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Pangkat Pasien',
      //                         labelText: 'Pangkat',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cHematologiPangkat.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cHematologiPangkat.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     enabled: false,
      //                     controller: cHematologiKesatuan,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Kesatuan Pasien',
      //                         labelText: 'Kesatuan',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cHematologiKesatuan.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cHematologiKesatuan.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cHematologiPemeriksa,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Pemeriksa Pasien',
      //                         labelText: 'Pemeriksa',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cHematologiPemeriksa.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cHematologiKesatuan.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //           ],
      //         ),
      //         Container(
      //           height: 50,
      //           width: double.maxFinite,
      //           margin: EdgeInsets.all(5),
      //           decoration: BoxDecoration(
      //               color: PrimaryColors(),
      //               borderRadius: BorderRadius.circular(10)
      //           ),
      //           child: Center(
      //             child: Text(
      //               "Hematologi",
      //               style: TextStyle(
      //                 fontSize: 20,
      //                 color: Colors.white
      //               ),
      //             ),
      //           ),
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cHematologiHemogoblin,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data Hemogoblin',
      //                         labelText: 'Hemogoblin',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cHematologiHemogoblin.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cHematologiHemogoblin.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cHematologiHematokrit,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data Hematokrit',
      //                         labelText: 'Hematokrit',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cHematologiHematokrit.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cHematologiHematokrit.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cHematologiLekosit,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data Lekosit',
      //                         labelText: 'Lekosit',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cHematologiLekosit.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cHematologiLekosit.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cHematologiTrombosit,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data Trombosit',
      //                         labelText: 'Trombosit',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cHematologiTrombosit.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cHematologiTrombosit.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cHematologiEritrosit,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data Eritrosit',
      //                         labelText: 'Eritrosit',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cHematologiEritrosit.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cHematologiEritrosit.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cHematologiLED,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data Led',
      //                         labelText: 'Led',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cHematologiLED.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                               onPressed: ()=> cHematologiLED.clear(),
      //                         )
      //                   ),
      //                 keyboardType: TextInputType.emailAddress,
      //                 textInputAction: TextInputAction.done,
      //                )
      //               ),
      //             ),
      //           ],
      //         ),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         InkWell(
      //           onTap: () {
      //             // PDFBuilder();
      //             // createPDF();
      //             generatePDFHematologi(
      //                 cHematologiNama.text,
      //                 cHematologiNRP.text,
      //                 cHematologiNIK.text,
      //                 cHematologiKesatuan.text,
      //                 cHematologiUmur.text,
      //                 cHematologiNIP.text,
      //                 cHematologiPangkat.text,
      //                 cHematologiPemeriksa.text,
      //                 cHematologiHemogoblin.text,
      //                 cHematologiLekosit.text,
      //                 cHematologiEritrosit.text,
      //                 cHematologiHematokrit.text,
      //                 cHematologiTrombosit.text,
      //                 cHematologiLED.text
      //             );
      //           },
      //           child: Container(
      //             height: 50,
      //             width: 250,
      //             decoration: BoxDecoration(
      //                 color: Colors.green,
      //                 borderRadius: BorderRadius.circular(10)
      //             ),
      //             child: Center(
      //                 child: Text(
      //                     "Cetak",
      //                   style: TextStyle(
      //                     color: Colors.white,
      //                     fontWeight: FontWeight.bold,
      //                     fontSize: 20
      //                   ),
      //                 )
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         Container(
      //           height: 50,
      //           width: 250,
      //           decoration: BoxDecoration(
      //               color: Colors.red,
      //               borderRadius: BorderRadius.circular(10)
      //           ),
      //           child: Center(
      //               child: Text(
      //                 "Kembali",
      //                 style: TextStyle(
      //                     color: Colors.white,
      //                     fontWeight: FontWeight.bold,
      //                     fontSize: 20
      //                 ),
      //               )
      //           ),
      //         )
      //       ],
      //     ),
      //     headerAnimationLoop: false
      // ).show();
    }else if(widget.nama.toString()=="Kimia Darah"){
      // AwesomeDialog(
      //     context: context,
      //     dismissOnTouchOutside: true,
      //     dismissOnBackKeyPress: true,
      //     dialogType: DialogType.question,
      //     animType: AnimType.topSlide,
      //     btnOkText: "Buat PDF",
      //     title: "Kimia Darah",
      //     btnOkIcon: Icons.print,
      //     btnCancelIcon: Icons.close,
      //     desc: "Silahkan isi Data untuk Kimia Darah",
      //     width: 1000,
      //     body: Column(
      //       children: [
      //         Container(
      //           height: 50,
      //           width: double.maxFinite,
      //           margin: EdgeInsets.all(5),
      //           decoration: BoxDecoration(
      //               color: PrimaryColors(),
      //               borderRadius: BorderRadius.circular(10)
      //           ),
      //           child: Center(
      //             child: Text(
      //               "Data Pasien",
      //               style: TextStyle(
      //                   fontSize: 20,
      //                   color: Colors.white
      //               ),
      //             ),
      //           ),
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahNama,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Nama Pasien',
      //                         labelText: 'Nama Pasien',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cHematologiNama.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahNama.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahUmur,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Umur Pasien',
      //                         labelText: 'Umur Pasien',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahUmur.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahUmur.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahNRP,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan NRP Pasien',
      //                         labelText: 'NRP',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahNRP.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahNRP.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahNIP,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan NIP',
      //                         labelText: 'NIP',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahNIP.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahNIP.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahNIK,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan NIK Pasien',
      //                         labelText: 'NIK',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahNIK.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahNIK.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahPangkat,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Pangkat Pasien',
      //                         labelText: 'Pangkat',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahPangkat.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahPangkat.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahKesatuan,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Kesatuan Pasien',
      //                         labelText: 'Kesatuan',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahKesatuan.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahKesatuan.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahPemeriksa,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Pemeriksa Pasien',
      //                         labelText: 'Pemeriksa',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahPemeriksa.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahKesatuan.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //           ],
      //         ),
      //         Container(
      //           height: 50,
      //           width: double.maxFinite,
      //           margin: EdgeInsets.all(5),
      //           decoration: BoxDecoration(
      //               color: PrimaryColors(),
      //               borderRadius: BorderRadius.circular(10)
      //           ),
      //           child: Center(
      //             child: Text(
      //               "Kimia Darah",
      //               style: TextStyle(
      //                   fontSize: 20,
      //                   color: Colors.white
      //               ),
      //             ),
      //           ),
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahBilurubinTotal,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data Bilurubin Total',
      //                         labelText: 'Bilurubin Total',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahBilurubinTotal.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahBilurubinTotal.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahBilurubinDirect,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data Bilurubin Direct',
      //                         labelText: 'Bilurubin Direct',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahBilurubinDirect.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahBilurubinDirect.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahBILURUBININDERECT,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data BILURUBIN INDERECT',
      //                         labelText: 'BILURUBIN INDERECT',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahBILURUBININDERECT.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahBILURUBININDERECT.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahSGOT,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data SGOT',
      //                         labelText: 'SGOT',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahSGOT.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahSGOT.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahSGPT,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data SPGT',
      //                         labelText: 'SGPT',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahSGPT.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahSGPT.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahCHOLESTROLTOTAL,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data CHOLESTROL TOTAL',
      //                         labelText: 'CHOLESTROL TOTAL',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahCHOLESTROLTOTAL.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahCHOLESTROLTOTAL.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahCHOLESTROLDL,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data CHOLESTEROL -LDL',
      //                         labelText: 'CHOLESTEROL -LDL',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahCHOLESTROLDL.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahCHOLESTROLDL.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahCHOLESTROHDL,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data CHOLESTROL-HDL',
      //                         labelText: 'CHOLESTROL-HDL'
      //                             '',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahCHOLESTROHDL.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahCHOLESTROHDL.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahTRIGLISERIDA,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data TRIGLISERIDA',
      //                         labelText: 'TRIGLISERIDA',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahTRIGLISERIDA.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahTRIGLISERIDA.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahUREUM,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data UREUM',
      //                         labelText: 'UREUM'
      //                             '',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahUREUM.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahUREUM.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahCREATININ,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data CREATININ',
      //                         labelText: 'CREATININ',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahCREATININ.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahCREATININ.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahASAMURAT,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data ASAM URAT',
      //                         labelText: 'ASAM URAT'
      //                             '',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahASAMURAT.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahASAMURAT.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahGULADARAHPUASA,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data GULA DARAH PUASA',
      //                         labelText: 'GULA DARAH PUASA',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahGULADARAHPUASA.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahGULADARAHPUASA.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahGULADARAH2JAMPP,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data GULA DARAH 2 JAM PP',
      //                         labelText: 'GULA DARAH 2 JAM PP'
      //                             '',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahGULADARAH2JAMPP.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahGULADARAH2JAMPP.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahGULADARAHSEWAKTU,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data GULA DARAH SEWAKTU',
      //                         labelText: 'GULA DARA SEWAKTU',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahGULADARAHSEWAKTU.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahGULADARAHSEWAKTU.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //               ),
      //             ),
      //           ],
      //         ),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         InkWell(
      //           onTap: () {
      //             // PDFBuilder();
      //             // print(_localPathKimiaDarah);
      //             generatePDFKimiaDarah(
      //                 cKimiaDarahNama.text,
      //                 cKimiaDarahNRP.text,
      //                 cKimiaDarahNIK.text,
      //                 cKimiaDarahKesatuan.text,
      //                 cKimiaDarahUmur.text,
      //                 cKimiaDarahNIP.text,
      //                 cKimiaDarahPangkat.text,
      //                 cKimiaDarahPemeriksa.text,
      //                 cKimiaDarahBilurubinTotal.text,
      //                 cKimiaDarahBilurubinDirect.text,
      //                 cKimiaDarahBILURUBININDERECT.text,
      //                 cKimiaDarahSGOT.text,
      //                 cKimiaDarahSGPT.text,
      //                 cKimiaDarahCHOLESTROLTOTAL.text,
      //                 cKimiaDarahCHOLESTROLDL.text,
      //                 cKimiaDarahCHOLESTROHDL.text,
      //                 cKimiaDarahTRIGLISERIDA.text,
      //                 cKimiaDarahUREUM.text,
      //                 cKimiaDarahCREATININ.text,
      //                 cKimiaDarahCREATININ.text,
      //                 cKimiaDarahGULADARAHPUASA.text,
      //                 cKimiaDarahGULADARAH2JAMPP.text,
      //                 cKimiaDarahGULADARAHSEWAKTU.text
      //             );
      //           },
      //           child: Container(
      //             height: 50,
      //             width: 250,
      //             decoration: BoxDecoration(
      //                 color: Colors.green,
      //                 borderRadius: BorderRadius.circular(10)
      //             ),
      //             child: Center(
      //                 child: Text(
      //                   "Cetak",
      //                   style: TextStyle(
      //                       color: Colors.white,
      //                       fontWeight: FontWeight.bold,
      //                       fontSize: 20
      //                   ),
      //                 )
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         Container(
      //           height: 50,
      //           width: 250,
      //           decoration: BoxDecoration(
      //               color: Colors.red,
      //               borderRadius: BorderRadius.circular(10)
      //           ),
      //           child: Center(
      //               child: Text(
      //                 "Kembali",
      //                 style: TextStyle(
      //                     color: Colors.white,
      //                     fontWeight: FontWeight.bold,
      //                     fontSize: 20
      //                 ),
      //               )
      //           ),
      //         )
      //       ],
      //     ),
      //     headerAnimationLoop: false
      // ).show();
      Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: Duration(seconds: 1),
              transitionsBuilder: (
                  BuildContext context,
                  Animation<double> animation,
                  Animation<double> secAnimation,
                  Widget child) {
                animation = CurvedAnimation(
                    parent: animation,
                    curve: Curves.elasticInOut
                );
                return ScaleTransition(
                  scale: animation,
                  child: child,
                  alignment: Alignment.center,
                );
              },
              pageBuilder: (
                  BuildContext context,
                  Animation<double> animation,
                  Animation<double> secAnimation
                  )
              {
                return InputKimiaDarah();
              }
          )
      );
    }else if(widget.nama=="Urinalisa"){
      // AwesomeDialog(
      //     context: context,
      //     dismissOnTouchOutside: true,
      //     dismissOnBackKeyPress: true,
      //     dialogType: DialogType.question,
      //     animType: AnimType.topSlide,
      //     btnOkText: "Buat PDF",
      //     title: "Urinalisa",
      //     btnOkIcon: Icons.print,
      //     btnCancelIcon: Icons.close,
      //     desc: "Silahkan isi Data untuk Urinalisa",
      //     width: 1000,
      //     body: Column(
      //       children: [
      //         Container(
      //           height: 50,
      //           width: double.maxFinite,
      //           margin: EdgeInsets.all(5),
      //           decoration: BoxDecoration(
      //               color: PrimaryColors(),
      //               borderRadius: BorderRadius.circular(10)
      //           ),
      //           child: Center(
      //             child: Text(
      //               "Data Pasien",
      //               style: TextStyle(
      //                   fontSize: 20,
      //                   color: Colors.white
      //               ),
      //             ),
      //           ),
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahNama,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Nama Pasien',
      //                         labelText: 'Nama Pasien',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cHematologiNama.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahNama.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahUmur,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Umur Pasien',
      //                         labelText: 'Umur Pasien',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahUmur.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahUmur.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahNRP,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan NRP Pasien',
      //                         labelText: 'NRP',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahNRP.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahNRP.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahNIP,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan NIP',
      //                         labelText: 'NIP',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahNIP.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahNIP.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahNIK,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan NIK Pasien',
      //                         labelText: 'NIK',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahNIK.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahNIK.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahPangkat,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Pangkat Pasien',
      //                         labelText: 'Pangkat',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahPangkat.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahPangkat.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahKesatuan,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Kesatuan Pasien',
      //                         labelText: 'Kesatuan',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahKesatuan.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahKesatuan.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahPemeriksa,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Pemeriksa Pasien',
      //                         labelText: 'Pemeriksa',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahPemeriksa.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahKesatuan.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //           ],
      //         ),
      //         Container(
      //           height: 50,
      //           width: double.maxFinite,
      //           margin: EdgeInsets.all(5),
      //           decoration: BoxDecoration(
      //               color: PrimaryColors(),
      //               borderRadius: BorderRadius.circular(10)
      //           ),
      //           child: Center(
      //             child: Text(
      //               "Kimia Darah",
      //               style: TextStyle(
      //                   fontSize: 20,
      //                   color: Colors.white
      //               ),
      //             ),
      //           ),
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahBilurubinTotal,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data Bilurubin Total',
      //                         labelText: 'Bilurubin Total',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahBilurubinTotal.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahBilurubinTotal.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahBilurubinDirect,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data Bilurubin Direct',
      //                         labelText: 'Bilurubin Direct',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahBilurubinDirect.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahBilurubinDirect.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahBILURUBININDERECT,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data BILURUBIN INDERECT',
      //                         labelText: 'BILURUBIN INDERECT',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahBILURUBININDERECT.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahBILURUBININDERECT.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahSGOT,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data SGOT',
      //                         labelText: 'SGOT',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahSGOT.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahSGOT.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahSGPT,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data SPGT',
      //                         labelText: 'SGPT',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahSGPT.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahSGPT.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahCHOLESTROLTOTAL,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data CHOLESTROL TOTAL',
      //                         labelText: 'CHOLESTROL TOTAL',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahCHOLESTROLTOTAL.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahCHOLESTROLTOTAL.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahCHOLESTROLDL,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data CHOLESTEROL -LDL',
      //                         labelText: 'CHOLESTEROL -LDL',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahCHOLESTROLDL.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahCHOLESTROLDL.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahCHOLESTROHDL,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data CHOLESTROL-HDL',
      //                         labelText: 'CHOLESTROL-HDL'
      //                             '',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahCHOLESTROHDL.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahCHOLESTROHDL.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahTRIGLISERIDA,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data TRIGLISERIDA',
      //                         labelText: 'TRIGLISERIDA',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahTRIGLISERIDA.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahTRIGLISERIDA.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahUREUM,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data UREUM',
      //                         labelText: 'UREUM'
      //                             '',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahUREUM.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahUREUM.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahCREATININ,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data CREATININ',
      //                         labelText: 'CREATININ',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahCREATININ.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahCREATININ.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahASAMURAT,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data ASAM URAT',
      //                         labelText: 'ASAM URAT'
      //                             '',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahASAMURAT.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahASAMURAT.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahGULADARAHPUASA,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data GULA DARAH PUASA',
      //                         labelText: 'GULA DARAH PUASA',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahGULADARAHPUASA.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahGULADARAHPUASA.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahGULADARAH2JAMPP,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data GULA DARAH 2 JAM PP',
      //                         labelText: 'GULA DARAH 2 JAM PP'
      //                             '',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahGULADARAH2JAMPP.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahGULADARAH2JAMPP.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKimiaDarahGULADARAHSEWAKTU,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Data GULA DARAH SEWAKTU',
      //                         labelText: 'GULA DARA SEWAKTU',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKimiaDarahGULADARAHSEWAKTU.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKimiaDarahGULADARAHSEWAKTU.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //               ),
      //             ),
      //           ],
      //         ),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         InkWell(
      //           onTap: () {
      //             // PDFBuilder();
      //             // print(_localPathKimiaDarah);
      //             generatePDFKimiaDarah(
      //                 cKimiaDarahNama.text,
      //                 cKimiaDarahNRP.text,
      //                 cKimiaDarahNIK.text,
      //                 cKimiaDarahKesatuan.text,
      //                 cKimiaDarahUmur.text,
      //                 cKimiaDarahNIP.text,
      //                 cKimiaDarahPangkat.text,
      //                 cKimiaDarahPemeriksa.text,
      //                 cKimiaDarahBilurubinTotal.text,
      //                 cKimiaDarahBilurubinDirect.text,
      //                 cKimiaDarahBILURUBININDERECT.text,
      //                 cKimiaDarahSGOT.text,
      //                 cKimiaDarahSGPT.text,
      //                 cKimiaDarahCHOLESTROLTOTAL.text,
      //                 cKimiaDarahCHOLESTROLDL.text,
      //                 cKimiaDarahCHOLESTROHDL.text,
      //                 cKimiaDarahTRIGLISERIDA.text,
      //                 cKimiaDarahUREUM.text,
      //                 cKimiaDarahCREATININ.text,
      //                 cKimiaDarahCREATININ.text,
      //                 cKimiaDarahGULADARAHPUASA.text,
      //                 cKimiaDarahGULADARAH2JAMPP.text,
      //                 cKimiaDarahGULADARAHSEWAKTU.text
      //             );
      //           },
      //           child: Container(
      //             height: 50,
      //             width: 250,
      //             decoration: BoxDecoration(
      //                 color: Colors.green,
      //                 borderRadius: BorderRadius.circular(10)
      //             ),
      //             child: Center(
      //                 child: Text(
      //                   "Cetak",
      //                   style: TextStyle(
      //                       color: Colors.white,
      //                       fontWeight: FontWeight.bold,
      //                       fontSize: 20
      //                   ),
      //                 )
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         Container(
      //           height: 50,
      //           width: 250,
      //           decoration: BoxDecoration(
      //               color: Colors.red,
      //               borderRadius: BorderRadius.circular(10)
      //           ),
      //           child: Center(
      //               child: Text(
      //                 "Kembali",
      //                 style: TextStyle(
      //                     color: Colors.white,
      //                     fontWeight: FontWeight.bold,
      //                     fontSize: 20
      //                 ),
      //               )
      //           ),
      //         )
      //       ],
      //     ),
      //     headerAnimationLoop: false
      // ).show();
      Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: Duration(seconds: 1),
              transitionsBuilder: (
                  BuildContext context,
                  Animation<double> animation,
                  Animation<double> secAnimation,
                  Widget child) {
                animation = CurvedAnimation(
                    parent: animation,
                    curve: Curves.elasticInOut
                );
                return ScaleTransition(
                  scale: animation,
                  child: child,
                  alignment: Alignment.center,
                );
              },
              pageBuilder: (
                  BuildContext context,
                  Animation<double> animation,
                  Animation<double> secAnimation
                  )
              {
                return InputUrinalisa();
              }
          )
      );
    }else if(widget.nama=="Immunoserologi"){
      Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: Duration(seconds: 1),
              transitionsBuilder: (
                  BuildContext context,
                  Animation<double> animation,
                  Animation<double> secAnimation,
                  Widget child) {
                animation = CurvedAnimation(
                    parent: animation,
                    curve: Curves.elasticInOut
                );
                return ScaleTransition(
                  scale: animation,
                  child: child,
                  alignment: Alignment.center,
                );
              },
              pageBuilder: (
                  BuildContext context,
                  Animation<double> animation,
                  Animation<double> secAnimation
                  )
              {
                return InputImmunoserologi();
              }
          )
      );
    }else if(widget.nama=="Sedimen"){
      Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: Duration(seconds: 1),
              transitionsBuilder: (
                  BuildContext context,
                  Animation<double> animation,
                  Animation<double> secAnimation,
                  Widget child) {
                animation = CurvedAnimation(
                    parent: animation,
                    curve: Curves.elasticInOut
                );
                return ScaleTransition(
                  scale: animation,
                  child: child,
                  alignment: Alignment.center,
                );
              },
              pageBuilder: (
                  BuildContext context,
                  Animation<double> animation,
                  Animation<double> secAnimation
                  )
              {
                return InputSedimen();
              }
          )
      );
    }else if(widget.nama=="Daftarkan Pasien"){
      // AwesomeDialog(
      //     context: context,
      //     dismissOnTouchOutside: true,
      //     dismissOnBackKeyPress: true,
      //     dialogType: DialogType.question,
      //     animType: AnimType.topSlide,
      //     btnOkText: "Daftarkan",
      //     title: "Daftarkan Pasien",
      //     btnOkIcon: Icons.verified_user,
      //     btnCancelIcon: Icons.close,
      //     desc: "Silahkan isi Data Pasien",
      //     width: 1000,
      //     body: Column(
      //       children: [
      //         Container(
      //           height: 50,
      //           width: double.maxFinite,
      //           margin: EdgeInsets.all(5),
      //           decoration: BoxDecoration(
      //               color: PrimaryColors(),
      //               borderRadius: BorderRadius.circular(10)
      //           ),
      //           child: Center(
      //             child: Text(
      //               "Data Pasien",
      //               style: TextStyle(
      //                   fontSize: 20,
      //                   color: Colors.white
      //               ),
      //             ),
      //           ),
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cNama,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Nama Pasien',
      //                         labelText: 'Nama Pasien',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cNama.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cNama.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cUmur,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Umur Pasien',
      //                         labelText: 'Umur Pasien',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cUmur.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cUmur.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cNRP,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan NRP Pasien',
      //                         labelText: 'NRP',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cNRP.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cNRP.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cNIP,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan NIP',
      //                         labelText: 'NIP',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cNIP.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cNIP.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cNIK,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan NIK Pasien',
      //                         labelText: 'NIK',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cNIK.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cNIK.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cPangkat,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Pangkat Pasien',
      //                         labelText: 'Pangkat',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cPangkat.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cPangkat.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                   margin: EdgeInsets.all(5),
      //                   child: TextField(
      //                     controller: cKesatuan,
      //                     decoration: InputDecoration(
      //                         hintText: 'Masukan Kesatuan Pasien',
      //                         labelText: 'Kesatuan',
      //                         border: OutlineInputBorder(),
      //                         suffixIcon: cKesatuan.text.isEmpty ? Container(width: 0,): IconButton(
      //                           icon: Icon(
      //                               Icons.close,
      //                               color: Colors.red),
      //                           onPressed: ()=> cKesatuan.clear(),
      //                         )
      //                     ),
      //                     keyboardType: TextInputType.emailAddress,
      //                     textInputAction: TextInputAction.done,
      //                   )
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //
      //               ),
      //             ),
      //           ],
      //         ),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         InkWell(
      //           onTap: () {
      //             DaftarPasien();
      //           },
      //           child: Container(
      //             height: 50,
      //             width: 250,
      //             decoration: BoxDecoration(
      //                 color: Colors.green,
      //                 borderRadius: BorderRadius.circular(10)
      //             ),
      //             child: Center(
      //                 child: Text(
      //                   "Daftarkan",
      //                   style: TextStyle(
      //                       color: Colors.white,
      //                       fontWeight: FontWeight.bold,
      //                       fontSize: 20
      //                   ),
      //                 )
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         InkWell(
      //           onTap: () {
      //             Navigator.pop(context);
      //           },
      //           child: Container(
      //             height: 50,
      //             width: 250,
      //             decoration: BoxDecoration(
      //                 color: Colors.red,
      //                 borderRadius: BorderRadius.circular(10)
      //             ),
      //             child: Center(
      //                 child: Text(
      //                   "Kembali",
      //                   style: TextStyle(
      //                       color: Colors.white,
      //                       fontWeight: FontWeight.bold,
      //                       fontSize: 20
      //                   ),
      //                 )
      //             ),
      //           ),
      //         )
      //       ],
      //     ),
      //     headerAnimationLoop: false
      // ).show();
      Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: Duration(seconds: 1),
              transitionsBuilder: (
                  BuildContext context,
                  Animation<double> animation,
                  Animation<double> secAnimation,
                  Widget child) {
                animation = CurvedAnimation(
                    parent: animation,
                    curve: Curves.elasticInOut
                );
                return ScaleTransition(
                  scale: animation,
                  child: child,
                  alignment: Alignment.center,
                );
              },
              pageBuilder: (
                  BuildContext context,
                  Animation<double> animation,
                  Animation<double> secAnimation
                  )
              {
                return  InputSemua();
              }
          )
      );

    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 275),
      vsync: this,
    );
    animation = Tween(begin: 1.0, end: 1.2)
        .animate(CurvedAnimation(parent: animationController, curve: Curves.ease, reverseCurve: Curves.easeIn));
    padding = Tween(begin: 0.0, end: -25.0)
        .animate(CurvedAnimation(parent: animationController, curve: Curves.ease,reverseCurve: Curves.easeIn));
    animationController.addListener(() {
      setState(() {});
    });
  }
  int CheckerSizeContainerHeight(){
    int Height = 200;
    if(MediaQuery.of(context).size.width >0 && MediaQuery.of(context).size.width <=500){
      Height = 100;
    }else if(MediaQuery.of(context).size.width >500 && MediaQuery.of(context).size.width <=650){
      Height = 130;
    }else if(MediaQuery.of(context).size.width >650 && MediaQuery.of(context).size.width <=720){
      Height = 180;
    }else if(MediaQuery.of(context).size.width >720 && MediaQuery.of(context).size.width <=900){
      Height = 80;
    }else if(MediaQuery.of(context).size.width >900 && MediaQuery.of(context).size.width <=1000){
      Height = 120;
    }else if(MediaQuery.of(context).size.width >1000 && MediaQuery.of(context).size.width <=1200){
      Height = 130;
    }else if(MediaQuery.of(context).size.width >1200 && MediaQuery.of(context).size.width <=1400){
      Height = 170;
    }
    return Height;
  }
  int CheckerSizeContainerWidth(){
    int Width = 400;
    if(MediaQuery.of(context).size.width >0 && MediaQuery.of(context).size.width <=500){
      Width = 250;
    }else if(MediaQuery.of(context).size.width >500 && MediaQuery.of(context).size.width <=650){
      Width = 300;
    }else if(MediaQuery.of(context).size.width >650 && MediaQuery.of(context).size.width <=720){
      Width = 300;
    }else if(MediaQuery.of(context).size.width >720 && MediaQuery.of(context).size.width <=900){
      Width = 200;
    }else if(MediaQuery.of(context).size.width >900 && MediaQuery.of(context).size.width <=1000){
      Width = 300;
    }else if(MediaQuery.of(context).size.width >1000 && MediaQuery.of(context).size.width <=1200){
      Width = 300;
    }else if(MediaQuery.of(context).size.width >1200 && MediaQuery.of(context).size.width <=1400){
      Width = 300;
    }
    return Width;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        child: Column(
          children: [
            InkWell(
              onTap: () {
                Clicker();
              },
              child: Hero(
                tag: widget.nama,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0)
                  ),

                  clipBehavior: Clip.hardEdge,
                  child: MouseRegion(
                      onEnter: (value) {
                        setState(() {
                          animationController.forward();
                        });
                      },
                      onExit: (value) {
                        setState(() {
                          animationController.reverse();
                        });
                      },
                      child: Container(
                          width: 150,
                          height: 100,

                          transform: Matrix4(animation.value, 0, 0, 0, 0, animation.value, 0,
                              0, 0, 0, 1, 0, padding.value, padding.value, 0, 1),
                          child: Image.asset(
                              widget.img,
                              fit: BoxFit.fill,
                          )
                      )
                  ),
                ),
              ),
            ),
            Container(height: 10,),
            Text(widget.nama,style: TextStyle(color: PrimaryColors(),fontWeight: FontWeight.bold,fontSize: FontMedium() ),)
          ],
        ),
      ),
    );
  }
}
