import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:labkesehatanehatan/API/Server.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:shared_preferences/shared_preferences.dart';

import '../Dashboard.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;


Future<Uint8List> readImageData(String name) async {
  final data = await rootBundle.load('assets/img/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}
var headers = {
  'Content-type': 'application/json',
  "Accept": "application/json",
  "Access-Control-Allow-Origin": getServerName(),
  "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
  "Access-Control-Allow-Headers": " Origin, Content-Type, Accept, Authorization, X-Request-With",
};

String DateBuilder(String Date){
  String Year=Date.substring(0,4);
  String Month=Date.substring(5,7);
  String Day=Date.substring(8,10);

  return Day+" "+MonthChanger(Month)+" "+Year;

}
String MonthChanger(String Month){
  String month="Januari";
  if(Month=="01" || Month=="1"){
    month="Januari";
  }else if(Month=="02" || Month=="2"){
    month="Februari";
  }else if(Month=="03" || Month=="3"){
    month="Maret";
  }else if(Month=="04" || Month=="4"){
    month="April";
  }else if(Month=="05" || Month=="5"){
    month="Mei";
  }else if(Month=="06" || Month=="6"){
    month="Juni";
  }else if(Month=="07" || Month=="7"){
    month="Juli";
  }else if(Month=="08" || Month=="8"){
    month="Agustus";
  }else if(Month=="09" || Month=="9"){
    month="September";
  }else if(Month=="10" || Month=="10"){
    month="Oktober";
  }else if(Month=="11" || Month=="11"){
    month="November";
  }else if(Month=="12" || Month=="12"){
    month="Desember";
  }
  return month;
}
String CalculateAge(String BirthDate){ // Tanggal lahir Anda
  DateTime birthDate = DateFormat('yyyy-MM-dd').parse(BirthDate);
  DateTime now = DateTime.now();

  int age = now.year - birthDate.year;

  // Memeriksa apakah sudah merayakan ulang tahun pada tahun ini
  if (now.month < birthDate.month ||
      (now.month == birthDate.month && now.day < birthDate.day)) {
    age--;
  }

  return age.toString();
}
AwesomeDialog Message(BuildContext context,String dataString){
  return AwesomeDialog(
    context: context,
    dismissOnTouchOutside: true,
    dismissOnBackKeyPress: true,
    dialogType: DialogType.info,
    animType: AnimType.topSlide,
    width: 500,
    desc: dataString,
    btnOkOnPress: () {

    },
  )..show();
}
LogoutMessage (String title,String desc,BuildContext context){
  AwesomeDialog(
      context: context,
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      dialogType: DialogType.warning,
      animType: AnimType.scale,
      title: title,
      desc: desc,
      btnOkOnPress: () {
        Logout(context);
      },
      btnCancelOnPress: (){

      },
      headerAnimationLoop: false
  )..show();
}
void Logout(BuildContext context) async{
  SharedPreferences pref = await SharedPreferences.getInstance();

  await pref.clear();

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
            return Dashboard();
          }
      )
  );
}
FailedMessage (String title,String desc,BuildContext context){
  AwesomeDialog(
      context: context,
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      dialogType: DialogType.error,
      animType: AnimType.scale,
      title: title,
      desc: desc,
      btnOkOnPress: () {

      },
      headerAnimationLoop: false
  )..show();
}
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/Labkes/');
  return file.path;
}
// void ExcelData() {
//   //var file = "/Users/kawal/Desktop/excel/test/test_resources/example.xlsx";
//   //var bytes = File(file).readAsBytesSync();
//   // Create a new Excel workbook
//   final excel = Excel.createExcel();
//
//   // Create a sheet
//   final sheet = excel['Sheet1'];
//
//   // Write data to the sheet
//   sheet.appendRow(['Name', 'Age']);
//   sheet.appendRow(['John', '25']);
//   sheet.appendRow(['Jane', '30']);
//
//   String outputFile = "/Labkes/Hasil.xlsx";
//
//   //stopwatch.reset();
//   List<int>? fileBytes = excel.save();
//   //print('saving executed in ${stopwatch.elapsed}');
//   if (fileBytes != null) {
//     File(join(outputFile))
//       ..createSync(recursive: true)
//       ..writeAsBytesSync(fileBytes);
//   }
//
// }



