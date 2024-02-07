String getServerName(){
  return 'https://apilabkes.siegemilsystem.com/';
  // return 'http://localhost/apilabkes.siegemilsystem.com/';
}
String Login(){
  return 'labkes/login';
}

String TambahPasien(){
  return 'labkes/tambahpasien';
}

String ListPasien(){
  return 'labkes/datapasien';
}
String SaveHematologi(){
  return 'labkes/hematologi';
}

String SaveKimiadarah(){
  return 'labkes/kimiadarah';
}
String SaveUrinalisa(){
  return 'labkes/urinalisa';
}
String SaveSedimen(){
  return 'labkes/sedimen';
}
String SaveImmunoserologi(){
  return 'labkes/immunoserologi';
}
String SaveAddon(){
  return 'labkes/addon';
}
String ListDataLaporan(String nama){
  return 'labkes/laporan?nama='+nama;
}
String LaporanExcel(){
  return 'labkes/laporanexcel';
}






