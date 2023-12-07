import 'package:flutter/material.dart';


class AdapterPasien extends StatefulWidget {
  String id_laporan;
  String id_pasien;
  String nama_pasien;
  String hematologi;
  String kimiadarah;
  String immunoserologi;
  String sedimen;
  String urinalisa;
  //Data Pribadi
  String nama;
  String kesatuan;
  String nip;
  String nrp;
  String umur;
  String jenis_kelamin;

  //Hematologi
  // String id_hematologi;
  // String hematokrit;
  // String hemogoblin;
  // String eritrosit;
  // String led;
  // String lekosit;
  // String trombosit;
  // String pemeriksa;
  // String tanggal_pemeriksaan;
  // String no_lab;
  //Kimia Darah
  // String id_kimiadarah;
  // String bilurubintotal;
  // String bilurubinindirect;
  // String sgot;
  // String spgt;
  // String cholesteroltotal;
  // String cholesterolldl;
  // String cholesterolhdl;
  // String trigiliserida;
  // String ureum;
  // String asamurat;
  // String guladarahpuasa;
  // String guladarah2jam;
  // String guladarahsewaktu;
  //Urinalisa
  // String id_urinalisa;
  // String warna;
  // String beratjenis;
  // String ph;
  // String lekositUrinalisa;
  // String nitrit;
  // String glukosa;
  // String protein;
  // String keton;
  // String urablinogen;
  // String eryl;
  //Sedimen
  // String id_sedimen;
  // String epitel;
  // String lekositSedimen;
  // String entrosit;
  // String bakteri;
  // String kristal;
  //Immunoserologi
  // String id_immunoserologi;
  // String hbsag;
  // String hiv;
  // String vdrl;
  AdapterPasien({Key? key,
    required this.id_laporan,
    required this.id_pasien,
    required this.nama_pasien,
    required this.hematologi,
    required this.kimiadarah,
    required this.immunoserologi,
    required this.sedimen,
    required this.urinalisa,
    required this.nama,
    required this.kesatuan,
    required this.nip,
    required this.nrp,
    required this.umur,
    required this.jenis_kelamin,
    //Hematologi
    //Kimia Darah
    //Urinalisa
  });

  @override
  State<AdapterPasien> createState() => _AdapterPasienState();
}

class _AdapterPasienState extends State<AdapterPasien> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Text("data")
          ],
        ),
      ),
    );
  }
}
