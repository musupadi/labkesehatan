import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:labkesehatanehatan/API/Server.dart';
import 'package:labkesehatanehatan/Constant/SizeData.dart';
import 'package:labkesehatanehatan/Home.dart';
import 'package:labkesehatanehatan/Model/PDFBuilderSemua.dart';
import '../Constant/ListConstant.dart';
import '../Constant/colors.dart';
import '../Model/Ascendant.dart';
import '../Model/PDFBuilderHematologi.dart';
List<String> Pilihan = <String>['-','Reaktif', 'Non Reaktif'];



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
const List<String> PosNeg = <String>['-','Negatif', 'Positif'];
const List<String> Warna = <String>['Kuning Jernih','Kuning Agak Keruh','Kuning Keruh','Kuning Pekat','Kuning Kecokelatan'];
const List<String> PositiveNegative = <String>['-(Negatif)','+(Positif 1)','++(Positif 2)','+++(Positif 3)','++++(Positif 4)'];



class InputSemua extends StatefulWidget {
  const InputSemua({Key? key}) : super(key: key);

  @override
  State<InputSemua> createState() => _InputSemuaState();
}

class _InputSemuaState extends State<InputSemua> {
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
  DateTime now = DateTime.now();

  var PemeriksaanTahun = CTahun.first;
  var PemeriksaanBulan = CBulan.first;
  var PemeriksaanHari = CHari.first;

  var PemeriksaanJam = CJam.first;
  var PemeriksaanMenit = CMenitDetik.first;
  var PemeriksaanDetik = CMenitDetik.first;




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
  TextEditingController cDokter = new TextEditingController();



  //Urinalisa
  var dropdownValueWarna = Warna.first;
  var dropdownValueLekosit = PositiveNegative.first;
  var dropdownValueNitrit = PositiveNegative.first;
  var dropdownValueProtein = PositiveNegative.first;
  var dropdownValueGlukose = PositiveNegative.first;
  var dropdownValueKeton = PositiveNegative.first;
  var dropdownValueUroblinogen = PositiveNegative.first;
  var dropdownValueBilurubin = PositiveNegative.first;
  var dropdownValueEryl = PositiveNegative.first;



  // TextEditingController cTanggalPemeriksaan = new TextEditingController();


  //Controller Hematologi
  TextEditingController cHemogoblin = new TextEditingController();
  TextEditingController cLekosit = new TextEditingController();
  TextEditingController cEritrosit = new TextEditingController();
  TextEditingController cHematokrit = new TextEditingController();
  TextEditingController cTrombosit = new TextEditingController();
  TextEditingController cLED = new TextEditingController();

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

  //Controller Urinalisa
  // TextEditingController cWarna = new TextEditingController();
  TextEditingController cBeratJenis = new TextEditingController();
  TextEditingController cPH = new TextEditingController();
  // TextEditingController cLekositUrinalisa = new TextEditingController();
  // TextEditingController cNitrit = new TextEditingController();
  // TextEditingController cProtein = new TextEditingController();
  // TextEditingController cGlukosa = new TextEditingController();
  // TextEditingController cKleton = new TextEditingController();
  // TextEditingController cUrobilnogen = new TextEditingController();
  // TextEditingController cBilurubin = new TextEditingController();
  // TextEditingController cEryl = new TextEditingController();

  //Controller Immunoserologi
  var dropdownValueHBsAG = Pilihan.first;
  var dropdownValueHIV = Pilihan.first;
  var dropdownValueVDRL = Pilihan.first;

  //Controller Sedimen
  TextEditingController cEpitel = new TextEditingController();
  TextEditingController cLekositSedimen = new TextEditingController();
  TextEditingController cEntrosit = new TextEditingController();
  TextEditingController cBakteri = new TextEditingController();
  TextEditingController cKristal = new TextEditingController();

  //Controller Utility
  var dropdownValueNarkoba = PosNeg.first;
  var dropdownValueKehamilan = PosNeg.first;
  bool save = false;
  bool back = false;
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
    print("Zyarga Debugger : "+respStr.toString());
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
  void PrintAndSave(){
    generatePDFSemua(
        //Data Pribadi
        cNama.text,
        cNRP.text,
        cNIP.text,
        cKesatuan.text,
        dropdownValueKelamin.toString(),
        cTTL.text,
        dropdownValueTahun+"-"+dropdownValueBulan+"-"+dropdownValueHari,
        cPemeriksa.text,
        cDokter.text,
        cNoLab.text,
        DateTime.now().toString(),
        //Hematologi
        cHemogoblin.text,
        cLekosit.text,
        cEritrosit.text,
        cHematokrit.text,
        cTrombosit.text,
        cLED.text,
        //Hematologi
        //Kimia Darah
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
        //Kimia Darah
        //Urinalisa
        dropdownValueWarna,
        cBeratJenis.text,
        cPH.text,
        cLekosit.text,
        dropdownValueNitrit,
        dropdownValueGlukose,
        dropdownValueProtein,
        dropdownValueKeton,
        dropdownValueUroblinogen,
        dropdownValueBilurubin,
        dropdownValueEryl,
        //Urinalisa
        //Sedimen
        cEpitel.text,
        cLekositSedimen.text,
        cEritrosit.text,
        cBakteri.text,
        cKristal.text,
        //Sedimen
        //Immunoserologi
        dropdownValueHBsAG,
        dropdownValueHIV,
        dropdownValueVDRL,
        dropdownValueNarkoba,
        dropdownValueKehamilan,
        DateTime.now().toString().substring(0,19),
        PemeriksaanTahun+"-"+CheckerZero(int.parse(PemeriksaanBulan))+"-"+CheckerZero(int.parse(PemeriksaanHari))+" "+CheckerZero(int.parse(PemeriksaanJam))+":"+CheckerZero(int.parse(PemeriksaanMenit))+":"+CheckerZero(int.parse(PemeriksaanDetik))
    );
    Save();
  }
  Future<void> Save() async {

    final url = Uri.parse(getServerName()+SaveHematologi());
    final request = http.MultipartRequest('POST', url);
    request.fields['id_pasien'] = cIdPasien.text;
    request.fields['hematokrit'] = cHematokrit.text;
    request.fields['hemogoblin'] =cHemogoblin.text;
    request.fields['eritrosit'] = cEritrosit.text;
    request.fields['led'] = cLED.text;
    request.fields['lekosit'] = cLekosit.text;
    request.fields['trombosit'] = cTrombosit.text;
    request.fields['no_lab'] = cNoLab.text;
    request.fields['pemeriksa'] = cPemeriksa.text;
    request.fields['dokter'] = cDokter.text;
    request.fields['tanggal_pemeriksaan'] = DateTime.now().toString();
    request.fields['tanggal_spesimen'] = PemeriksaanTahun+"-"+PemeriksaanBulan+"-"+PemeriksaanHari+" "+PemeriksaanJam+":"+PemeriksaanMenit+":"+PemeriksaanDetik;

    final response = await request.send();
    final respStr = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      Save2();
    } else {
      Message(context, respStr.toString());
    }
  }
  Future<void> Save2() async {
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
    request.fields['dokter'] = cDokter.text;
    request.fields['tanggal_pemeriksaan'] = DateTime.now().toString();
    request.fields['tanggal_spesimen'] = PemeriksaanTahun+"-"+PemeriksaanBulan+"-"+PemeriksaanHari+" "+PemeriksaanJam+":"+PemeriksaanMenit+":"+PemeriksaanDetik;
    final response = await request.send();
    final respStr = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      Save3();
    } else {
      Message(context, respStr.toString());
    }
  }
  Future<void> Save3() async {
    final url = Uri.parse(getServerName()+SaveUrinalisa());
    final request = http.MultipartRequest('POST', url);
    request.fields['id_pasien'] = cIdPasien.text;
    request.fields['warna'] = dropdownValueWarna;
    request.fields['beratjenis'] =cBeratJenis.text;
    request.fields['ph'] =cPH.text;
    request.fields['lekosit'] = dropdownValueLekosit;
    request.fields['nitrit'] = dropdownValueNitrit;
    request.fields['glukosa'] = dropdownValueGlukose;
    request.fields['protein'] = dropdownValueProtein;
    request.fields['keton'] = dropdownValueKeton;
    request.fields['urablinogen'] = dropdownValueUroblinogen;
    request.fields['bilurubin'] = dropdownValueBilurubin;
    request.fields['eryl'] = dropdownValueEryl;
    request.fields['no_lab'] = cNoLab.text;
    request.fields['pemeriksa'] = cPemeriksa.text;
    request.fields['dokter'] = cDokter.text;
    request.fields['tanggal_pemeriksaan'] = DateTime.now().toString();
    request.fields['tanggal_spesimen'] = PemeriksaanTahun+"-"+PemeriksaanBulan+"-"+PemeriksaanHari+" "+PemeriksaanJam+":"+PemeriksaanMenit+":"+PemeriksaanDetik;
    final response = await request.send();
    final respStr = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      Save4();
    } else {
      Message(context, respStr.toString());
    }
  }
  Future<void> Save4() async {
    final url = Uri.parse(getServerName()+SaveImmunoserologi());
    final request = http.MultipartRequest('POST', url);
    request.fields['id_pasien'] = cIdPasien.text;
    request.fields['hbsag'] = dropdownValueHBsAG.toString();
    request.fields['hiv'] = dropdownValueHIV.toString();
    request.fields['vdrl'] = dropdownValueVDRL.toString();
    request.fields['no_lab'] = cNoLab.text;
    request.fields['pemeriksa'] = cPemeriksa.text;
    request.fields['dokter'] = cDokter.text;
    request.fields['tanggal_pemeriksaan'] = DateTime.now().toString();
    request.fields['tanggal_spesimen'] = PemeriksaanTahun+"-"+PemeriksaanBulan+"-"+PemeriksaanHari+" "+PemeriksaanJam+":"+PemeriksaanMenit+":"+PemeriksaanDetik;
    final response = await request.send();
    final respStr = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      Save5();
    } else {
      Message(context, respStr.toString());
    }
  }
  Future<void> Save5() async {
    final url = Uri.parse(getServerName()+SaveSedimen());
    final request = http.MultipartRequest('POST', url);
    request.fields['id_pasien'] = cIdPasien.text;
    request.fields['epitel'] = cEpitel.text;
    request.fields['lekosit'] =cLekositSedimen.text;
    request.fields['entrosit'] = cEntrosit.text;
    request.fields['bakteri'] = cBakteri.text;
    request.fields['kristal'] = cKristal.text;
    request.fields['no_lab'] = cNoLab.text;
    request.fields['pemeriksa'] = cPemeriksa.text;
    request.fields['dokter'] = cDokter.text;
    request.fields['tanggal_pemeriksaan'] = DateTime.now().toString();
    request.fields['tanggal_spesimen'] = PemeriksaanTahun+"-"+PemeriksaanBulan+"-"+PemeriksaanHari+" "+PemeriksaanJam+":"+PemeriksaanMenit+":"+PemeriksaanDetik;
    final response = await request.send();
    final respStr = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      Save6();
    } else {
      Message(context, respStr.toString());
    }
  }
  Future<void> Save6() async {
    final url = Uri.parse(getServerName()+SaveAddon());
    final request = http.MultipartRequest('POST', url);
    request.fields['id_pasien'] = cIdPasien.text;
    request.fields['kehamilan'] = dropdownValueKehamilan;
    request.fields['narkoba'] = dropdownValueNarkoba;
    request.fields['no_lab'] = cNoLab.text;
    request.fields['pemeriksa'] = cPemeriksa.text;
    request.fields['dokter'] = cDokter.text;
    request.fields['tanggal_pemeriksaan'] = DateTime.now().toString();
    final response = await request.send();
    final respStr = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      // Message(context,respStr.toString());
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
  @override
  void initState() {
    // Get.to(logins);

    setState(() {
      PemeriksaanTahun=now.year.toString();
      PemeriksaanBulan=now.month.toString();
      PemeriksaanHari=now.day.toString();
      PemeriksaanJam=now.hour.toString();
      PemeriksaanMenit=now.minute.toString();
      PemeriksaanDetik=now.second.toString();
    });

    super.initState();
    // Obtain shared preferences.

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
                  color: PrimaryColorsLayeredInput(),
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
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
                      //Dokter
                      Container(
                          margin: EdgeInsets.only(top: 10,bottom: 10),
                          child: TextField(
                            controller: cDokter,
                            decoration: InputDecoration(
                              hintText: 'Nama Dokter',
                              labelText: 'Nama Dokter',
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
                      //Tanggal
                      Container(
                          width: double.maxFinite,
                          child: Center(
                            child: Text("Pilih Tanggal Spesimen",
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
                                        value: PemeriksaanHari,
                                        elevation: 16,
                                        isExpanded: true,
                                        hint: Text("Hari"),
                                        icon: Icon(Icons.arrow_drop_down),
                                        onChanged: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            PemeriksaanHari= value!;
                                          });
                                        },
                                        items: CHari.map<DropdownMenuItem<String>>((String value) {
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
                                        value: PemeriksaanBulan,
                                        elevation: 16,
                                        isExpanded: true,
                                        hint: Text("Bulan"),
                                        icon: Icon(Icons.arrow_drop_down),
                                        onChanged: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            PemeriksaanBulan= value!;
                                          });
                                        },
                                        items: CBulan.map<DropdownMenuItem<String>>((String value) {
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
                                        value: PemeriksaanTahun,
                                        elevation: 16,
                                        isExpanded: true,
                                        hint: Text("Tahun"),
                                        icon: Icon(Icons.arrow_drop_down),
                                        onChanged: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            PemeriksaanTahun= value!;
                                          });
                                        },
                                        items: CTahun.map<DropdownMenuItem<String>>((String value) {
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
                      //Jam
                      Container(
                          width: double.maxFinite,
                          child: Center(
                            child: Text("Pilih Jam Pemeriksaan",
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
                                    child: Text("Jam",
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
                                        value: PemeriksaanJam,
                                        elevation: 16,
                                        isExpanded: true,
                                        hint: Text("Jam"),
                                        icon: Icon(Icons.arrow_drop_down),
                                        onChanged: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            PemeriksaanJam= value!;
                                          });
                                        },
                                        items: CJam.map<DropdownMenuItem<String>>((String value) {
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
                                    child: Text("Menit",
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
                                        value: PemeriksaanMenit,
                                        elevation: 16,
                                        isExpanded: true,
                                        hint: Text("Menit"),
                                        icon: Icon(Icons.arrow_drop_down),
                                        onChanged: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            PemeriksaanMenit= value!;
                                          });
                                        },
                                        items: CMenitDetik.map<DropdownMenuItem<String>>((String value) {
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
                                    child: Text("Detik",
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
                                        value: PemeriksaanDetik,
                                        elevation: 16,
                                        isExpanded: true,
                                        hint: Text("Detik"),
                                        icon: Icon(Icons.arrow_drop_down),
                                        onChanged: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            PemeriksaanDetik= value!;
                                          });
                                        },
                                        items: CMenitDetik.map<DropdownMenuItem<String>>((String value) {
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
                      //Hematologi
                      Container(
                        child: Center(
                          child: Text(
                            "Hematologi",
                            style: TextStyle(
                              fontSize: 20,
                              color: PrimaryColors(),
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      //Hemogoblin
                      Container(
                          margin: EdgeInsets.only(top: 10,bottom: 10),
                          child: TextField(
                            controller: cHemogoblin,
                            decoration: InputDecoration(
                              hintText: 'Data Hemogoblin',
                              labelText: 'Hemogoblin',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                          )
                      ),
                      //Lekosit
                      Container(
                          margin: EdgeInsets.only(top: 10,bottom: 10),
                          child: TextField(
                            controller: cLekosit,
                            decoration: InputDecoration(
                              hintText: 'Data Lekosit',
                              labelText: 'Lekosit',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                          )
                      ),
                      //Eritrosit
                      Container(
                          margin: EdgeInsets.only(top: 10,bottom: 10),
                          child: TextField(
                            controller: cEritrosit,
                            decoration: InputDecoration(
                              hintText: 'Data Eritrosit',
                              labelText: 'Eritrosit',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                          )
                      ),
                      //Hematokrit
                      Container(
                          margin: EdgeInsets.only(top: 10,bottom: 10),
                          child: TextField(
                            controller: cHematokrit,
                            decoration: InputDecoration(
                              hintText: 'Data Hematokrit',
                              labelText: 'Hematokrit',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                          )
                      ),
                      //Trombosit
                      Container(
                          margin: EdgeInsets.only(top: 10,bottom: 10),
                          child: TextField(
                            controller: cTrombosit,
                            decoration: InputDecoration(
                              hintText: 'Data Trombosit',
                              labelText: 'Trombosit',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                          )
                      ),
                      //LED
                      Container(
                          margin: EdgeInsets.only(top: 10,bottom: 10),
                          child: TextField(
                            controller: cLED,
                            decoration: InputDecoration(
                              hintText: 'Data LED',
                              labelText: 'LED',
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
                      //Urinalisa
                      Container(
                        child: Center(
                          child: Text(
                            "Urinalisa",
                            style: TextStyle(
                                fontSize: 20,
                                color: PrimaryColors(),
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      //Warna
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Text("Warna"),
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
                                value: dropdownValueWarna,
                                elevation: 16,
                                isExpanded: true,
                                hint: Text("Warna"),
                                icon: Icon(Icons.arrow_drop_down),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownValueWarna= value!;
                                  });
                                },
                                items: Warna.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )
                          )
                      ),
                      //Berat Jenis
                      Container(
                          margin: EdgeInsets.only(top: 10,bottom: 10),
                          child: TextField(
                            controller: cBeratJenis,
                            decoration: InputDecoration(
                              hintText: 'Data Berat Jenis',
                              labelText: 'Berat Jenis',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                          )
                      ),
                      //Berat Jenis
                      Container(
                          margin: EdgeInsets.only(top: 10,bottom: 10),
                          child: TextField(
                            controller: cPH,
                            decoration: InputDecoration(
                              hintText: 'Data PH',
                              labelText: 'PH',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                          )
                      ),
                      //Lekosit
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Text("Lekosit"),
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
                                value: dropdownValueLekosit,
                                elevation: 16,
                                isExpanded: true,
                                hint: Text("Lekosit"),
                                icon: Icon(Icons.arrow_drop_down),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownValueLekosit= value!;
                                  });
                                },
                                items: PositiveNegative.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )
                          )
                      ),
                      //Nitrit
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Text("Nitrit"),
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
                                value: dropdownValueNitrit,
                                elevation: 16,
                                isExpanded: true,
                                hint: Text("Nitrit"),
                                icon: Icon(Icons.arrow_drop_down),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownValueNitrit= value!;
                                  });
                                },
                                items: PositiveNegative.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )
                          )
                      ),
                      //Protein
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Text("Protein"),
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
                                value: dropdownValueProtein,
                                elevation: 16,
                                isExpanded: true,
                                hint: Text("Protein"),
                                icon: Icon(Icons.arrow_drop_down),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownValueProtein= value!;
                                  });
                                },
                                items: PositiveNegative.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )
                          )
                      ),
                      //Glukose
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Text("Glukose"),
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
                                value: dropdownValueGlukose,
                                elevation: 16,
                                isExpanded: true,
                                hint: Text("Glukose"),
                                icon: Icon(Icons.arrow_drop_down),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownValueGlukose= value!;
                                  });
                                },
                                items: PositiveNegative.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )
                          )
                      ),
                      //Keton
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Text("Keton"),
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
                                value: dropdownValueKeton,
                                elevation: 16,
                                isExpanded: true,
                                hint: Text("Keton"),
                                icon: Icon(Icons.arrow_drop_down),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownValueKeton= value!;
                                  });
                                },
                                items: PositiveNegative.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )
                          )
                      ),
                      //Uroblinogen
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Text("Uroblinogen"),
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
                                value: dropdownValueUroblinogen,
                                elevation: 16,
                                isExpanded: true,
                                hint: Text("Uroblinogen"),
                                icon: Icon(Icons.arrow_drop_down),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownValueUroblinogen= value!;
                                  });
                                },
                                items: PositiveNegative.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )
                          )
                      ),
                      //Bilurubin
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Text("Bilurubin"),
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
                                value: dropdownValueBilurubin,
                                elevation: 16,
                                isExpanded: true,
                                hint: Text("Bilurubin"),
                                icon: Icon(Icons.arrow_drop_down),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownValueBilurubin= value!;
                                  });
                                },
                                items: PositiveNegative.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )
                          )
                      ),
                      //Eryl/Hb
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Text("Eryl/Hb"),
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
                                value: dropdownValueEryl,
                                elevation: 16,
                                isExpanded: true,
                                hint: Text("Glukose"),
                                icon: Icon(Icons.arrow_drop_down),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownValueEryl= value!;
                                  });
                                },
                                items: PositiveNegative.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )
                          )
                      ),
                      //Immunoserologi
                      Container(
                        child: Center(
                          child: Text(
                            "Immunoserologi",
                            style: TextStyle(
                                fontSize: 20,
                                color: PrimaryColors(),
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      //HBsAG
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text("HBsAG"),
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
                              value: dropdownValueHBsAG,
                              elevation: 16,
                              isExpanded: true,
                              hint: Text("HBsAG"),
                              icon: Icon(Icons.arrow_drop_down),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropdownValueHBsAG = value!;
                                });
                              },
                              items: Pilihan.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          )
                      ),
                      //HIV
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Text("HIV"),
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
                              value: dropdownValueHIV,
                              elevation: 16,
                              isExpanded: true,
                              hint: Text("HIV"),
                              icon: Icon(Icons.arrow_drop_down),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropdownValueHIV = value!;
                                });
                              },
                              items: Pilihan.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          )
                      ),
                      //VDRL
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Text("VDRL"),
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
                              value: dropdownValueVDRL,
                              elevation: 16,
                              isExpanded: true,
                              hint: Text("VDRL"),
                              icon: Icon(Icons.arrow_drop_down),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropdownValueVDRL = value!;
                                });
                              },
                              items: Pilihan.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          )
                      ),
                      //Sedimen
                      Container(
                        child: Center(
                          child: Text(
                            "Sedimen",
                            style: TextStyle(
                                fontSize: 20,
                                color: PrimaryColors(),
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      //Sedimen
                      //Epitel
                      Container(
                          margin: EdgeInsets.only(top: 10,bottom: 10),
                          child: TextField(
                            controller: cEpitel,
                            decoration: InputDecoration(
                              hintText: 'Data Epitel',
                              labelText: 'Epitel',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                          )
                      ),
                      //Lekosit
                      Container(
                          margin: EdgeInsets.only(top: 10,bottom: 10),
                          child: TextField(
                            controller: cLekositSedimen,
                            decoration: InputDecoration(
                              hintText: 'Lekosit',
                              labelText: 'Lekosit',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                          )
                      ),
                      //Entrosit
                      Container(
                          margin: EdgeInsets.only(top: 10,bottom: 10),
                          child: TextField(
                            controller: cEntrosit,
                            decoration: InputDecoration(
                              hintText: 'Data Entrosit',
                              labelText: 'Entrosit',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                          )
                      ),
                      //Nitrit
                      Container(
                          margin: EdgeInsets.only(top: 10,bottom: 10),
                          child: TextField(
                            controller: cBakteri,
                            decoration: InputDecoration(
                              hintText: 'Data Bakteri',
                              labelText: 'Bakteri',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                          )
                      ),
                      //Glukose
                      Container(
                          margin: EdgeInsets.only(top: 10,bottom: 10),
                          child: TextField(
                            controller: cKristal,
                            decoration: InputDecoration(
                              hintText: 'Data Kristal',
                              labelText: 'Kristal',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                          )
                      ),
                      //
                      //Narkoba
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Text("Narkoba"),
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
                                value: dropdownValueNarkoba,
                                elevation: 16,
                                isExpanded: true,
                                hint: Text("Narkoba"),
                                icon: Icon(Icons.arrow_drop_down),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownValueNarkoba= value!;
                                  });
                                },
                                items: PosNeg.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )
                          )
                      ),
                      dropdownValueKelamin == "P" ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //Kehamilan
                          Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: Text("Kehamilan"),
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
                                    value: dropdownValueKehamilan,
                                    elevation: 16,
                                    isExpanded: true,
                                    hint: Text("Narkoba"),
                                    icon: Icon(Icons.arrow_drop_down),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        dropdownValueKehamilan= value!;
                                      });
                                    },
                                    items: PosNeg.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  )
                              )
                          ),
                        ],
                      ) : Container(),
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
                            Message(context,"Mohon Isi Nama Pemeriksa");
                          }else if(cDokter.text == "" || cDokter.text.isEmpty){
                            Message(context,"Mohon Isi Nama Dokter");
                          }else{
                            PrintAndSave();
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
          ),
        ],
      ),
    );
  }
}
