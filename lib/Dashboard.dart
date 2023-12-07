import 'dart:async';
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'API/Server.dart';
import 'Constant/SizeData.dart';
import 'Constant/colors.dart';
import 'Home.dart';
import 'Model/Ascendant.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool passenable = true; //boolean value to track password view enable disable.
  TextEditingController controllerUsername = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();
  bool isLoading = false;
  bool Selected = false;

  @override
  void initState() {
    // Get.to(logins);
    Checker();
    super.initState();
    // Obtain shared preferences.

  }

  Checker() async{
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('id_user');
    if(token !=null){
      Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 0),
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
                return Home();
              }
          )
      );
    }
  }

  void ChangePageHome(){
    Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 0),
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
              return Home();
            }
        )
    );
  }


  LoginSuccess (String name){
    AwesomeDialog(
        context: context,
        dismissOnTouchOutside: true,
        dismissOnBackKeyPress: false,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        title: "Login Succes",
        desc: "Selamat Datang "+name,
        btnOkOnPress: () {
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
                    return Home();
                  }
              )
          );
        },
        headerAnimationLoop: false
    )..show();
  }
  Logins2(){
    if(controllerUsername.text == "Admin" && controllerPassword.text == "labkes123"){
      LoginSuccess("Admin");
    }else{
      Message(context, "Username atau Password Salah");
    }
  }
  Logins() async{
    int timeout = 5;
    setState(() => isLoading=true);
    try{
      final response = await http.post(
          Uri.parse(getServerName()+Login()),body: {
        "Username": controllerUsername.text,
        "Password": controllerPassword.text
      }).timeout(Duration(seconds: timeout));
      setState(() => isLoading=false);
      print("Zyarga Debugger : "+controllerUsername.toString());
      print(controllerPassword.toString());
      if(jsonDecode(response.body)['code'] == 0){
        // Obtain shared preferences.
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('id_user', jsonDecode(response.body)['data'][0]['id_user'].toString());
        await prefs.setString('username', jsonDecode(response.body)['data'][0]['username'].toString());
        await prefs.setString('name', jsonDecode(response.body)['data'][0]['name'].toString());
        await prefs.setString('picture', jsonDecode(response.body)['data'][0]['picture'].toString());

        String? username = prefs.getString('username');
        String? nama = prefs.getString("name");
        String? picture = prefs.getString("picture");
        // var sessionManager = SessionManager();
        // await sessionManager.set("id", jsonDecode(response.body)['data'][0]['id'].toString());
        // await sessionManager.set("username", jsonDecode(response.body)['data'][0]['username'].toString());
        // await sessionManager.set("name", jsonDecode(response.body)['data'][0]['nama'].toString());

        // String name = await SessionManager().get("name").toString();
        LoginSuccess(nama.toString());
      }else{
        setState(() => isLoading=false);
        print("Zyarga Debugger : "+jsonDecode(response.body)['data'][0]['Message']);
        FailedMessage("Login Failed", "Username atau Password Salah",context);
      }
      return jsonDecode(response.body)['data'][0]['nama'].toString();
    } on TimeoutException catch (e){
      setState(() => isLoading=false);
      print("Zyarga Debugger $e");
      FailedMessage("Login Failed", "Koneksi Gagal",context);
    } on Error catch (e){
      FailedMessage("Login Failed", "Username atau Password Salah",context);
      print("Zyarga Debugger $e");
      setState(() => isLoading=false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 3,
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
              )
          ),
          Expanded(
              flex: 1,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(StandardMargin()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 100,
                          height: 100,
                          child: Image.asset("assets/img/dokkes.png")
                      ),
                      SizedBox(height: 30,),
                      Text("Login User",
                        style: TextStyle(
                            color: PrimaryColors(),fontSize: FontLarge(),fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30,),
                      Container(
                          child: TextField(
                            controller: controllerUsername,
                            decoration: InputDecoration(
                                hintText: 'contoh@gmail.com',
                                prefixIcon: Icon(Icons.mail),
                                labelText: 'Username',
                                border: OutlineInputBorder(),
                                suffixIcon: controllerUsername.text.isEmpty ? Container(width: 0,): IconButton(
                                  icon: Icon(
                                      Icons.close,
                                      color: Colors.red),
                                  onPressed: ()=> controllerUsername.clear(),
                                )
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                          )
                      ),
                      SizedBox(height: 30,),
                      Container(
                          child: TextField(
                            controller: controllerPassword,
                            decoration: InputDecoration(
                                hintText: 'Password Anda...',
                                prefixIcon: Icon(Icons.lock),
                                labelText: 'Password',
                                border: OutlineInputBorder(),
                                suffixIcon: IconButton(
                                    icon: passenable
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility),
                                    onPressed: () =>
                                        setState(() => passenable = !passenable)
                                )
                            ),
                            obscureText: passenable,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                          )
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: double.maxFinite,
                        child: Text("Forgot Password",
                          style: TextStyle(
                              color: Colors.red,fontSize: FontMedium(),
                              fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      SizedBox(height: 30,),
                      AnimatedContainer(
                        width: 200,
                        height: 50,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.bounceInOut,
                        child: InkWell(
                            onTap: () {

                            },
                            child: ElevatedButton.icon(
                              style: ButtonStyle(
                                elevation: MaterialStatePropertyAll(10),
                                backgroundColor: MaterialStateProperty.all(PrimaryColors()),
                              ),
                              label: Text("Login",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Selected ?  Colors.white : Colors.black
                                ),
                              ),
                              icon: Icon(Icons.login),
                              onPressed: () {
                                Logins();
                              },
                            ),
                            onHover: (val){
                              setState(() {
                                Selected= val;
                              });
                            }
                        ),
                      ),
                    ],
                  ),
            ),
          )
          )
        ],
      )
    );
  }
}
