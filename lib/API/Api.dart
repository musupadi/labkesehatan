import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:labkesehatanehatan/API/Server.dart';

Future<List> GetLaporan(String nama) async{
  List list = [];
  final response=await http.get(
      Uri.parse(
          getServerName()+
          ListDataLaporan(nama)
      ),
  ).timeout(Duration(seconds: 5));
  // final response=await http.get(Uri.parse(getServerName()+'ReservationAll/',queryParameters));
  list = json.decode(response.body)['data'];
  return list;
}
Future<List> getLaporan() async{
  List list = [];
  final response=await http.get(
    Uri.parse(
        getServerName()+
            ListDataLaporan("")
    ),
  ).timeout(Duration(seconds: 5));
  return list = json.decode(response.body)['data'];
}