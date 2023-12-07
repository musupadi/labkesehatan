

import 'package:flutter/material.dart';
import 'package:labkesehatanehatan/API/Api.dart';

import 'Constant/SizeData.dart';
import 'Constant/colors.dart';

class Laporan extends StatefulWidget {
  const Laporan({Key? key}) : super(key: key);

  @override
  State<Laporan> createState() => _LaporanState();
}

class _LaporanState extends State<Laporan> {
  bool back = false;
  String tanggal = "";
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
              width: 750,
              margin: EdgeInsets.only(top: 20,bottom: 20),
              decoration: BoxDecoration(
                  color: PrimaryColorsLayered(),
                  borderRadius: BorderRadius.circular(50)
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 40,bottom: 40),
              width: 750,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50)
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
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
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: PrimaryColors(),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("Pilih Tanggal Pemeriksaan",
                            style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                            width:50,
                            margin: EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                  "No",
                                  textAlign: TextAlign.center
                              ),
                            )
                        ),
                        Container(
                            width:100,
                            margin: EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                  "Nama",
                                  textAlign: TextAlign.center
                              ),
                            )
                        ),
                        Container(
                            width:100,
                            margin: EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                  "NRP",
                                  textAlign: TextAlign.center),
                            )
                        ),
                        Container(
                            width:100,
                            margin: EdgeInsets.all(10),
                            child: Text(
                                "Tanggal Pemeriksaan",
                                textAlign: TextAlign.center
                            )
                        ),
                        Container(
                            width:100,
                            margin: EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                "Jenis Kelamin",
                                textAlign: TextAlign.center,
                              ),
                            )
                        ),
                        Container(
                            width:150,
                            margin: EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                "No Labolatorium",
                                textAlign: TextAlign.center,
                              ),
                            )
                        ),
                      ],
                    ),
                    Expanded(
                        child: FutureBuilder<List>(
                          future: getLaporan(),
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              return ListView.builder(
                                  itemCount: snapshot.requireData.length,
                                  itemBuilder: (context, index) {
                                return Visibility(
                                  visible: snapshot.requireData[index]['tanggal_pemeriksaan'] == null ? false : true ,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                          width:50,
                                          margin: EdgeInsets.all(10),
                                          child: Center(
                                            child: Text(
                                                (index+1).toString(),
                                                textAlign: TextAlign.center
                                            ),
                                          )
                                      ),
                                      Container(
                                          width:100,
                                          margin: EdgeInsets.all(10),
                                          child: Center(
                                            child: Text(
                                                snapshot.requireData[index]['nama'],
                                                textAlign: TextAlign.center
                                            ),
                                          )
                                      ),
                                      Container(
                                          width:100,
                                          margin: EdgeInsets.all(10),
                                          child: Center(
                                            child: Text(
                                                snapshot.requireData[index]['nrp'],
                                                textAlign: TextAlign.center),
                                          )
                                      ),
                                      Container(
                                          width:100,
                                          margin: EdgeInsets.all(10),
                                          child: Text(
                                              snapshot.requireData[index]['tanggal_pemeriksaan'] == null ? "" : snapshot.requireData[index]['tanggal_pemeriksaan'] ,
                                              textAlign: TextAlign.center
                                          )
                                      ),
                                      Container(
                                          width:100,
                                          margin: EdgeInsets.all(10),
                                          child: Center(
                                            child: Text(
                                              snapshot.requireData[index]['jenis_kelamin'],
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                      ),
                                      Container(
                                          width:150,
                                          margin: EdgeInsets.all(10),
                                          child: Center(
                                            child: Text(
                                              snapshot.requireData[index]['hematogi_lab'] != null ? snapshot.requireData[index]['hematogi_lab'] :
                                              snapshot.requireData[index]['kimiadarah_lab'] != null ? snapshot.requireData[index]['kimiadarah_lab'] :
                                              snapshot.requireData[index]['urinalisa_lab'] != null ? snapshot.requireData[index]['urinalisa_lab'] :
                                              snapshot.requireData[index]['sedimen_lab'] != null ? snapshot.requireData[index]['sedimen_lab'] :
                                              snapshot.requireData[index]['immunoserologi_lab'] != null ? snapshot.requireData[index]['immunoserologi_lab'] : "",
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                );
                              });
                            }else if(snapshot.hasError){
                              return Container();
                            }else{
                              return Container();
                            }
                          },
                        )
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
                        height: 50,
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
