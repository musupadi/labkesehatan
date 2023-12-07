import 'dart:io';

import 'package:flutter/material.dart';
import 'package:labkesehatanehatan/Route/Route.dart';
import 'package:path/path.dart';
import 'Adapter/AdapterButton.dart';
import 'Constant/SizeData.dart';
import 'Constant/colors.dart';
import 'Model/Ascendant.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}





class _HomeState extends State<Home> {
  List<bool> selected = [false,false,false,false];
  List<String> Menus =  ['Home','Laporan','Profile','Logout'];
  bool isMount = true;


  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }




  @override
  Widget build(BuildContext context) {
    Widget Menu(int index){
      return AnimatedContainer(
        height: 50,
        duration: Duration(milliseconds: 300),
        curve: Curves.bounceInOut,
        padding: EdgeInsets.only(right: (selected[index]) ? 5 : 10.0, left: !(selected[index]) ? 5 : 10),
        color: selected[index] ? Colors.red : null,
        child: Container(
          child: InkWell(
            onTap: () {
              if(index==0){

              }else if(index==1){
                toLaporan(context);
              }else if(index==2){

              }else if(index==3){
                LogoutMessage(
                  "Apakah Anda Yakin Ingin Logout ? ",
                  "Anda Akan membutuhkan login lagi jika Logout",
                  context
                );
              }
            },
            child: Container(
              margin: EdgeInsets.all(10),
              child: Align(
                  alignment: FractionalOffset.centerLeft,
                  child: Text(Menus[index],
                      style: TextStyle(color: selected[index] ? Colors.white : Colors.black
                      )
                  )
              ),
            ),
            onHover: (val) {
              setState(() {
                selected[index] = val;
              });
            },
          ),
        ),
      );
    }
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 300,
            color: PrimaryColors(),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: 100,
                          height: 100,
                          child: Image.asset("assets/img/dokkes.png")
                      ),
                      SizedBox(height: 10),
                      Text("Admin",
                        style: TextStyle(
                          fontSize: FontMedium(),
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text("1234567",
                        style: TextStyle(
                          fontSize: FontSmall(),
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                ),
                Menu(0),
                Menu(1),
                Menu(2),
                Menu(3),
              ],
            ),
          ),
          Expanded(
              child: Column(
                children: [
                  Container(
                    height: 300,
                    child: Stack(
                      children: [
                        Container(
                            height: double.maxFinite,
                            width: double.maxFinite,
                            child: Image.asset("assets/img/labolatorium.jpg",fit: BoxFit.fill,)
                        ),
                        Container(
                          color: PrimaryColorsLayered(),
                        ),
                        Container(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  width: 200,
                                  height: 200,
                                  child: Image.asset("assets/img/dokkes.png")
                              ),
                              Text("LABKES \nLaboratorium Satkes",
                                style: TextStyle(
                                  fontSize: FontTitle(),
                                  color: PrimaryColors(),
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.all(10),
                          width: 150,
                          height: 150,
                          child: AdapterButton(id: "id", img: "assets/img/pasien.jpg", nama: "Daftarkan Pasien", detail: "detail", id_category: "id_category")),
                      Container(
                          margin: EdgeInsets.all(10),
                          width: 150,
                          height: 150,
                          child: AdapterButton(
                              id: "id", img: "assets/img/hematologi.jpg", nama: "Hematologi", detail: "detail", id_category: "id_category")
                      ),
                      Container(
                          margin: EdgeInsets.all(10),
                          width: 150,
                          height: 150,
                          child: AdapterButton(id: "id",
                              img: "assets/img/kimiadarah.jpg",
                              nama: "Kimia Darah",
                              detail: "detail",
                              id_category: "id_category")
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.all(10),
                          width: 150,
                          height: 150,
                          child: AdapterButton(id: "id", img: "assets/img/urinalisa.jpg", nama: "Urinalisa", detail: "detail", id_category: "id_category")),
                      Container(
                          margin: EdgeInsets.all(10),
                          width: 150,
                          height: 150,
                          child: AdapterButton(id: "id", img: "assets/img/immunoserologi.jpg", nama: "Immunoserologi", detail: "detail", id_category: "id_category")),
                      Container(
                          margin: EdgeInsets.all(10),
                          width: 150,
                          height: 150,
                          child: AdapterButton(id: "id", img: "assets/img/sedimens.jpg", nama: "Sedimen", detail: "detail", id_category: "id_category")),
                    ],
                  ),
                ],
              )
          )
        ],
      ),

    );
  }
}
