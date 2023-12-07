import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:labkesehatanehatan/Model/PDFBuilderKimiaDarah.dart';

import '../API/Server.dart';
import '../Constant/SizeData.dart';
import '../Constant/colors.dart';
import '../Home.dart';
import '../Model/Ascendant.dart';
import 'package:http/http.dart' as http;

import '../Model/PDFBuilderHematologi.dart';
List<String> Pilihan = <String>['Reaktif', 'Non Reaktif'];



List<String> Desa = <String>['Desa'];
const List<String> Hari = <String>['01', '02', '03', '04','05', '06', '07', '08','09', '10',
  '11','12','13', '14','15', '16','17', '18','19', '20',
  '21','22','23','24','25','26','27','28','29','30',
  '31'];
const List<String> Bulan = <String>['01', '02', '03', '04','05', '06', '07', '08','09', '10','11', '12'];
const List<String> Tahun = <String>[
  '2010',
  '2000','2001', '2002', '2003', '2004','2005', '2006', '2007', '2008','2009',
  '1990', '1991', '1992', '1993','1994', '1995', '1996', '1997','1998', '1999',
  '1980', '1981', '1982', '1983','1984', '1985', '1986', '1987','1988', '1989',
  '1970', '1971', '1972', '1973','1974', '1975', '1976', '1977','1978', '1979',
  '1960', '1961', '1962', '1963','1964', '1965', '1966', '1967','1968', '1969',
  '1950', '1951', '1952', '1953','1954', '1955', '1956', '1957','1958', '1959',
  '1940', '1941', '1942', '1943','1944', '1945', '1946', '1947','1948', '1949',
];
const List<String> Kelamin = <String>['L', 'P'];
const List<String> PosNeg = <String>['Negatif', 'Positif'];
const List<String> Warna = <String>['Kuning Jernih','Kuning Agak Keruh','Kuning Keruh','Kuning Pekat','Kuning Kecokelatan'];
const List<String> PositiveNegative = <String>['-(Negatif)','+(Positif 1)','++(Positif 2)','+++(Positif 3)','++++(Positif 4)'];
class InputKimiaDarah extends StatefulWidget {
  const InputKimiaDarah({Key? key}) : super(key: key);

  @override
  State<InputKimiaDarah> createState() => _InputKimiaDarahState();
}

class _InputKimiaDarahState extends State<InputKimiaDarah> {
  bool hooverPilih = false;
  bool hooverCari = false;
  bool visiblityInput = true;
  //Controller
  TextEditingController cNamaSearch = new TextEditingController();
  //Controller Data
  TextEditingController cIdPasien = new TextEditingController();


  var dropdownValueKelamin = Kelamin.first;
  var dropdownValueHari = Hari.first;
  var dropdownValueBulan = Bulan.first;
  var dropdownValueTahun = Tahun.first;

  //Kiri
  TextEditingController cNama = new TextEditingController();
  TextEditingController cNRP = new TextEditingController();
  TextEditingController cNIP = new TextEditingController();
  TextEditingController cKesatuan = new TextEditingController();
  TextEditingController cJenisKelamin = new TextEditingController();

  //Kanan
  TextEditingController cTTL = new TextEditingController();
  TextEditingController cNoLab = new TextEditingController();
  TextEditingController cPemeriksa = new TextEditingController();

  //Controller Kimia Darah
  TextEditingController cBilurubinTotal = new TextEditingController();
  TextEditingController cBilurubinDirect = new TextEditingController();
  TextEditingController cBILURUBININDERECT = new TextEditingController();
  TextEditingController cSGOT = new TextEditingController();
  TextEditingController cSGPT = new TextEditingController();
  TextEditingController cCHOLESTROLTOTAL = new TextEditingController();
  TextEditingController cCHOLESTROHDL = new TextEditingController();
  TextEditingController cCHOLESTROLDL = new TextEditingController();
  TextEditingController cTRIGLISERIDA = new TextEditingController();
  TextEditingController cUREUM = new TextEditingController();
  TextEditingController cCREATININ = new TextEditingController();
  TextEditingController cASAMURAT = new TextEditingController();
  TextEditingController cGULADARAHPUASA = new TextEditingController();
  TextEditingController cGULADARAH2JAMPP = new TextEditingController();
  TextEditingController cGULADARAHSEWAKTU = new TextEditingController();


  bool save = false;
  bool back = false;

  Future<void> Save() async {
    final url = Uri.parse(getServerName()+SaveKimiadarah());
    final request = http.MultipartRequest('POST', url);
    request.fields['id_pasien'] = cIdPasien.text;
    request.fields['bilurubintotal'] = cBilurubinTotal.text;
    request.fields['bilurubindirect'] =cBilurubinDirect.text;
    request.fields['bilurubinindirect'] = cBILURUBININDERECT.text;
    request.fields['sgot'] = cSGOT.text;
    request.fields['spgt'] = cSGPT.text;
    request.fields['cholesteroltotal'] = cCHOLESTROLTOTAL.text;
    request.fields['cholesterolldl'] = cCHOLESTROLDL.text;
    request.fields['cholesterolhdl'] = cCHOLESTROHDL.text;
    request.fields['trigiliserida'] = cTRIGLISERIDA.text;
    request.fields['ureum'] = cUREUM.text;
    request.fields['asamurat'] = cASAMURAT.text;
    request.fields['guladarahpuasa'] = cGULADARAHPUASA.text;
    request.fields['guladarah2jam'] = cGULADARAH2JAMPP.text;
    request.fields['guladarahsewaktu'] = cGULADARAHSEWAKTU.text;
    request.fields['no_lab'] = cNoLab.text;
    request.fields['pemeriksa'] = cPemeriksa.text;
    request.fields['tanggal_pemeriksaan'] = DateTime.now().toString();

    request.fields['pemeriksa'] = cPemeriksa.text;
    final response = await request.send();
    final respStr = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      print("Zyarga Debugger "+respStr.toString());
      generatePDFKimiaDarah(
          //Data Pribadi
          cNama.text,
          cNRP.text,
          cNIP.text,
          cKesatuan.text,
          dropdownValueKelamin.toString(),
          cTTL.text,
          dropdownValueTahun+"-"+dropdownValueBulan+"-"+dropdownValueHari,
          cPemeriksa.text,
          cNoLab.text,
          DateTime.now().toString(),
          cBilurubinTotal.text,
          cBilurubinDirect.text,
          cBILURUBININDERECT.text,
          cSGOT.text,
          cSGPT.text,
          cCHOLESTROLTOTAL.text,
          cCHOLESTROLDL.text,
          cCHOLESTROHDL.text,
          cTRIGLISERIDA.text,
          cUREUM.text,
          cCREATININ.text,
          cASAMURAT.text,
          cGULADARAHPUASA.text,
          cGULADARAH2JAMPP.text,
          cGULADARAHSEWAKTU.text,
      );
      Navigator.pushReplacement(
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
                  alignment: Alignment.centerLeft,
                );
              },
              pageBuilder: (
                  BuildContext context,
                  Animation<double> animation,
                  Animation<double> secAnimation
                  )
              {
                return Home();
              }
          )
      );
    } else {
      Message(context, respStr.toString());
    }
  }
  Future<List> getDataPasien() async{
    // getMarque();
    final response=await http.get(
        Uri.parse(
            getServerName()+ListPasien()+"?nama="+cNama.text
        ),
        headers: headers
    ).timeout(Duration(seconds: 5));
    // var url = Uri.http(getServerName(), "ReservationAll/",queryParameters);
    if(response.reasonPhrase == 'OK'){
      // return json.decode(response.body)['data'];
    }else{
      print(response.reasonPhrase);
    }
    // final response=await http.get(Uri.parse(getServerName()+'ReservationAll/',queryParameters));
    List list = json.decode(response.body)['data'];
    return list;
  }
  Future<void> DaftarPasien() async{
    final url = Uri.parse(getServerName()+TambahPasien());
    final request = http.MultipartRequest('POST', url);
    //Kiri
    request.fields['nama'] = cNama.text;
    request.fields['nrp'] = cNRP.text;
    request.fields['nip'] = cNIP.text;
    request.fields['kesatuan'] = cKesatuan.text;
    request.fields['jenis_kelamin'] = dropdownValueKelamin;


    //Kanan
    request.fields['tempat_lahir'] = cTTL.text;
    request.fields['tanggal_lahir'] = dropdownValueTahun+"-"+dropdownValueBulan+"-"+dropdownValueHari;

    final response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(cNIP.text);
    if(jsonDecode(respStr)['code'].toString()=="0"){
      Message(context,jsonDecode(respStr)['Message']);
      cIdPasien.text=jsonDecode(respStr)['data']['id_pasien'];
      setState(() {
        visiblityInput=false;
      });
    }else{
      Message(context,jsonDecode(respStr)['Message']);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Image.asset("assets/img/labolatorium.jpg",fit: BoxFit.fill)
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 20,bottom: 20),
              width: 500,
              decoration: BoxDecoration(
                  color: PrimaryColorsLayered(),
                  borderRadius: BorderRadius.circular(50)
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 40,bottom: 40),
              width: 500,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50)
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back_ios),
                            Text(
                                "Kembali ke Home"
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //Nama
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                              margin: EdgeInsets.only(top: 10,bottom: 10),
                              child: TextField(
                                controller: cNama,
                                decoration: InputDecoration(
                                  hintText: 'Nama Pasien',
                                  labelText: 'Nama',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                              )
                          ),
                        ),
                        AnimatedContainer(
                          margin: EdgeInsets.all(10),
                          duration: Duration(milliseconds: 500),
                          decoration: BoxDecoration(
                              color: hooverCari ? Colors.red  : PrimaryColors(),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: InkWell(
                            onTap: () {
                              AwesomeDialog(
                                  context: context,
                                  dismissOnTouchOutside: true,
                                  dismissOnBackKeyPress: true,
                                  dialogType: DialogType.question,
                                  animType: AnimType.topSlide,
                                  btnOkText: "Pilih Pasien",
                                  title: "Pilih Data Pasien",
                                  btnOkIcon: Icons.person,
                                  btnCancelIcon: Icons.close,
                                  desc: "Silahkan pilih Data User",
                                  width: 500,
                                  body: Column(
                                    children: [
                                      Text("Silahkan Pilih Data Pasien"),
                                      FutureBuilder<List>(
                                        future: getDataPasien(),
                                        builder: (context, snapshot) {
                                          if(snapshot.hasError){

                                          }
                                          if(snapshot.hasData){
                                            return ListView.builder(
                                              itemCount: snapshot.requireData.length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    cIdPasien.text=snapshot.requireData[index]['id_pasien'];
                                                    cNama.text=snapshot.requireData[index]['nama'];
                                                    cNIP.text=snapshot.requireData[index]['nip'];
                                                    cNRP.text=snapshot.requireData[index]['nrp'];
                                                    cKesatuan.text=snapshot.requireData[index]['kesatuan'];
                                                    cTTL.text=snapshot.requireData[index]['tempat_lahir'];
                                                    setState(() {
                                                      String Hari=snapshot.requireData[index]['tanggal_lahir'];
                                                      String Bulan=snapshot.requireData[index]['tanggal_lahir'];
                                                      String Tahun=snapshot.requireData[index]['tanggal_lahir'];
                                                      dropdownValueHari=Hari.substring(8,10);
                                                      dropdownValueBulan=Bulan.substring(5,7);
                                                      dropdownValueTahun=Tahun.substring(0,4);
                                                      dropdownValueKelamin=snapshot.requireData[index]['jenis_kelamin'];
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                        color: PrimaryColors(),
                                                        borderRadius: BorderRadius.circular(10)
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: Center(
                                                        child: Text(snapshot.requireData[index]['nama']),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          } else{
                                            return new Center(child: CircularProgressIndicator());
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  headerAnimationLoop: false
                              ).show();
                            },
                            onHover: (value) {
                              setState(() {
                                hooverCari = value;
                              });
                            },
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "Cari Pasien",
                                  style: TextStyle(
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //NRP
                    Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: TextField(
                          controller: cNRP,
                          decoration: InputDecoration(
                            hintText: 'NRP Pasien',
                            labelText: 'NRP',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        )
                    ),
                    //NIP
                    Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: TextField(
                          controller: cNIP,
                          decoration: InputDecoration(
                            hintText: 'NIP Pasien',
                            labelText: 'NIP',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        )
                    ),
                    //Tempat Lahir
                    Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: TextField(
                          controller: cTTL,
                          decoration: InputDecoration(
                            hintText: 'Tempat Lahir',
                            labelText: 'Tempat Lahir',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        )
                    ),
                    //Tanggal Lahir
                    Container(
                        width: double.maxFinite,
                        child: Center(
                          child: Text("Pilih Tanggal Lahir",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                        )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text("Hari",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold
                                      )
                                  )
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 5,right: 5),
                                decoration: BoxDecoration(
                                    border: Border.all(width: 0.4),
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Container(
                                    margin: EdgeInsets.only(left: 15,right: 15,top: 0,bottom: 0),
                                    child: DropdownButton<String>(
                                      value: dropdownValueHari,
                                      elevation: 16,
                                      isExpanded: true,
                                      hint: Text("Hari"),
                                      icon: Icon(Icons.arrow_drop_down),
                                      onChanged: (String? value) {
                                        // This is called when the user selects an item.
                                        setState(() {
                                          dropdownValueHari= value!;
                                        });
                                      },
                                      items: Hari.map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text("Bulan",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold
                                      )
                                  )
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 5,right: 5),
                                decoration: BoxDecoration(
                                    border: Border.all(width: 0.4),
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Container(
                                    margin: EdgeInsets.only(left: 15,right: 15,top: 0,bottom: 0),
                                    child: DropdownButton<String>(
                                      value: dropdownValueBulan,
                                      elevation: 16,
                                      isExpanded: true,
                                      hint: Text("Bulan"),
                                      icon: Icon(Icons.arrow_drop_down),
                                      onChanged: (String? value) {
                                        // This is called when the user selects an item.
                                        setState(() {
                                          dropdownValueBulan= value!;
                                        });
                                      },
                                      items: Bulan.map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text("Tahun",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold
                                      )
                                  )
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 5,right: 5),
                                decoration: BoxDecoration(
                                    border: Border.all(width: 0.4),
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Container(
                                    margin: EdgeInsets.only(left: 15,right: 15,top: 0,bottom: 0),
                                    child: DropdownButton<String>(
                                      value: dropdownValueTahun,
                                      elevation: 16,
                                      isExpanded: true,
                                      hint: Text("Tahun"),
                                      icon: Icon(Icons.arrow_drop_down),
                                      onChanged: (String? value) {
                                        // This is called when the user selects an item.
                                        setState(() {
                                          dropdownValueTahun= value!;
                                        });
                                      },
                                      items: Tahun.map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //Jenis Kelamin
                    Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Text("Jenis Kelamin"),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.4),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: DropdownButton<String>(
                              value: dropdownValueKelamin,
                              elevation: 16,
                              isExpanded: true,
                              hint: Text("L/P"),
                              icon: Icon(Icons.arrow_drop_down),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropdownValueKelamin= value!;
                                  print(dropdownValueKelamin);
                                });
                              },
                              items: Kelamin.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )
                        )
                    ),
                    //Kesatuan
                    Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: TextField(
                          controller: cKesatuan,
                          decoration: InputDecoration(
                            hintText: 'Kesatuan Pasien',
                            labelText: 'Kesatuan',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        )
                    ),
                    cIdPasien.text != null || cIdPasien.text == ""
                        ?
                    Visibility(
                      visible: visiblityInput,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        decoration: BoxDecoration(
                            color: hooverPilih ? Colors.red  : PrimaryColors(),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: InkWell(
                          onTap: () {
                            DaftarPasien();
                          },
                          onHover: (value) {
                            setState(() {
                              hooverPilih = value;
                            });
                          },
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Input Pasien",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ) : Container(),
                    //Pemeriksa
                    Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: TextField(
                          controller: cPemeriksa,
                          decoration: InputDecoration(
                            hintText: 'Pemeriksa Pasien',
                            labelText: 'Pemeriksa',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        )
                    ),
                    //No Lab
                    Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: TextField(
                          controller: cNoLab,
                          decoration: InputDecoration(
                            hintText: 'Nomor Lab',
                            labelText: 'Nomor Lab',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        )
                    ),
                    //Kimia Darah
                    Container(
                      child: Center(
                        child: Text(
                          "Kimia Darah",
                          style: TextStyle(
                              fontSize: 20,
                              color: PrimaryColors(),
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    //Bilurubin Total
                    Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: TextField(
                          controller: cBilurubinTotal,
                          decoration: InputDecoration(
                            hintText: 'Data Bilurubin Total',
                            labelText: 'Bilurubin Total',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        )
                    ),
                    //Bilurubin Direct
                    Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: TextField(
                          controller: cBilurubinDirect,
                          decoration: InputDecoration(
                            hintText: 'Data Bilurubin Direct',
                            labelText: 'Bilurubin Direct',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        )
                    ),
                    //Bilurubin Indirect
                    Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: TextField(
                          controller: cBILURUBININDERECT,
                          decoration: InputDecoration(
                            hintText: 'Data Bilurubin Indirect',
                            labelText: 'Bilurubin Indirect',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        )
                    ),
                    //SGOT
                    Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: TextField(
                          controller: cSGOT,
                          decoration: InputDecoration(
                            hintText: 'Data SGOT',
                            labelText: 'SGOT',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        )
                    ),
                    //SPGT
                    Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: TextField(
                          controller: cSGPT,
                          decoration: InputDecoration(
                            hintText: 'Data SPGT',
                            labelText: 'SPGT',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        )
                    ),
                    //Cholesterol Total
                    Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: TextField(
                          controller: cCHOLESTROLTOTAL,
                          decoration: InputDecoration(
                            hintText: 'Data Cholesterol Total',
                            labelText: 'Cholesterol Total',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        )
                    ),
                    //Cholesterol HDL
                    Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: TextField(
                          controller: cCHOLESTROHDL,
                          decoration: InputDecoration(
                            hintText: 'Data Cholesterol HDL',
                            labelText: 'Cholesterol HDL',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        )
                    ),
                    //Cholesterol LDL
                    Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: TextField(
                          controller: cCHOLESTROLDL,
                          decoration: InputDecoration(
                            hintText: 'Data Cholesterol LDL',
                            labelText: 'Cholesterol LDL',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        )
                    ),
                    //Trigliserida
                    Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: TextField(
                          controller: cTRIGLISERIDA,
                          decoration: InputDecoration(
                            hintText: 'Data Trigliserida',
                            labelText: 'Trigliserida',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        )
                    ),
                    //Ureum
                    Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: TextField(
                          controller: cUREUM,
                          decoration: InputDecoration(
                            hintText: 'Data Ureum',
                            labelText: 'Ureum',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        )
                    ),
                    //Creatnin
                    Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: TextField(
                          controller: cCREATININ,
                          decoration: InputDecoration(
                            hintText: 'Data Creatinin',
                            labelText: 'Creatinin',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        )
                    ),
                    //Asam Urat
                    Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: TextField(
                          controller: cASAMURAT,
                          decoration: InputDecoration(
                            hintText: 'Data Asam Urat',
                            labelText: 'Asam Urat',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        )
                    ),
                    //Gula Darah Puasa
                    Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: TextField(
                          controller: cGULADARAHPUASA,
                          decoration: InputDecoration(
                            hintText: 'Gula Darah Puasa',
                            labelText: 'Gula Darah Puasa',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        )
                    ),
                    //Gula Darah 2 Jam PP
                    Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: TextField(
                          controller: cGULADARAH2JAMPP,
                          decoration: InputDecoration(
                            hintText: 'Gula Darah 2 Jam PP',
                            labelText: 'Gula Darah 2 Jam PP',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        )
                    ),
                    //Gula Darah Sewaktu
                    Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: TextField(
                          controller: cGULADARAHSEWAKTU,
                          decoration: InputDecoration(
                            hintText: 'Gula Darah Sewaktu',
                            labelText: 'Gula Darah Sewaktu',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        )
                    ),
                    //Save and Print
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          save = value;
                        });
                      },
                      onTap: () {
                        if(cNoLab.text == "" || cNoLab.text.isEmpty){
                          Message(context, "Mohon Isi No Lab");
                        }else if(cPemeriksa.text == "" || cPemeriksa.text.isEmpty){
                          Message(context,"Mohon Isi Nama Dokter");
                        }else{
                          Save();
                        }
                        // Message(context,cIdPasien.text);
                      },

                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        margin: EdgeInsets.only(top: 20,bottom: 10,right: 20,left: 20),
                        decoration: BoxDecoration(
                          color: save ? Colors.white : PrimaryColors(),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              "Simpan dan Print",
                              style: TextStyle(
                                  color: save ? PrimaryColors() : Colors.white,
                                  fontSize: FontLarge()
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //Kembali
                    InkWell(
                      onHover: (value) {
                        setState(() {
                          back = value;
                        });
                      },
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        margin: EdgeInsets.only(top: 10,bottom: 10,right: 20,left: 20),
                        decoration: BoxDecoration(
                          color: back ? Colors.white : Colors.red,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              "Kembali",
                              style: TextStyle(
                                  color: back ? Colors.red : Colors.white,
                                  fontSize: FontLarge()
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
