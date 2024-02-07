import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:labkesehatanehatan/Model/Ascendant.dart';
import 'package:labkesehatanehatan/Model/Model/ModelHematologi.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'OpenFileWeb.dart';
double MainSize = 90;
Future<void> generatePDFSemua(
    //Data Pribadi
    String Nama,
    String NRP,
    String NIP,
    String Kesatuan,
    String jk,
    String TempatLahir,
    String TanggalLahir,
    String Pemeriksa,
    String Dokter,
    String NoLab,
    String TanggalPemeriksaan,
    //Hematologi
    String Hemogoblin,
    String Lekosit,
    String Eritrosit,
    String Hematokrit,
    String Trombosit,
    String LED,
    //Kimia Darah
    String BilurubinTotal,
    String BilurubinDirect,
    String BilurubinIndirect,
    String SGOT,
    String SPGT,
    String CholesterolTotal,
    String CholesterolLDL,
    String CholesterolHDL,
    String Trigliserida,
    String Ureum,
    String Creatinin,
    String AsamUrat,
    String GulaDarahPuasa,
    String GulaDarah2JamPP,
    String GulaDarahSewaktu,
    //Urinalisa
    String Warna,
    String BeratJenis,
    String PH,
    String LekositUrinalisa,
    String Nitrit,
    String Glukosa,
    String Protein,
    String Keton,
    String Urablinogen,
    String Bilurubin,
    String Eryl,
    //Sedimen
    String Epitel,
    String LekositSedimen,
    String EritrositSedimen,
    String Bakteri,
    String Kristal,
    //Immunoserologi
    String HbSag,
    String HIV,
    String VDRL,
    String Narkoba,
    String Kehamilan,

    String Pemeriksaan,
    String Spesimen
    ) async {
  MainSize != 95 ? MainSize=95 : MainSize;
  //Create a PDF document.
  final PdfDocument document = PdfDocument();
  //Add page to the PDF
  final PdfPage page = document.pages.add();
  //Get page client size
  final Size pageSize = page.getClientSize();

  //Draw rectangle
  // page.graphics.drawRectangle(
  //     bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
  //     pen: PdfPen(PdfColor(142, 170, 219)));
  //Generate PDF grid.
  final PdfGrid grid = _getGrid(
    //Hematologi
      Hemogoblin,
      Lekosit,
      Eritrosit,
      Hematokrit,
      Trombosit,
      LED
  );
  final PdfGrid grid2 = _getGridKimiaDarah(
    //Kimia Darah
      BilurubinTotal,
      BilurubinDirect,
      BilurubinIndirect,
      SGOT,
      SPGT,
      CholesterolTotal,
      CholesterolLDL,
      CholesterolHDL,
      Trigliserida,
      Ureum,
      Creatinin,
      AsamUrat,
      GulaDarahPuasa,
      GulaDarah2JamPP,
      GulaDarahSewaktu
  );
  final PdfGrid grid3 = _getGridUrinalisa(
    //Urinalisa
    Warna,
    BeratJenis,
    LekositUrinalisa,
    Nitrit,
    Glukosa,
    Keton,
    Urablinogen,
    Bilurubin,
    Eryl,
  );
  //Draw the header section by creating text element
  final PdfLayoutResult result = _drawHeader(
      page,
      pageSize,
      //Data Pribadi
      Nama,
      NRP,
      NIP,
      Kesatuan,
      jk,
      TempatLahir,
      TanggalLahir,
      NoLab,
      Pemeriksa,
      Dokter,
      TanggalPemeriksaan
  );
  //Draw grid
  _drawGridHematologi(page,Hemogoblin,Hematokrit,Lekosit,Trombosit,Eritrosit,LED);
  _drawGridKimiaDarah(page, BilurubinTotal, BilurubinDirect, BilurubinIndirect, SGOT, SPGT, CholesterolTotal, CholesterolHDL, CholesterolLDL, Trigliserida, Ureum, Creatinin, AsamUrat, GulaDarahPuasa, GulaDarah2JamPP, GulaDarahSewaktu);
  _drawGridUrinalisa(page, Warna, BeratJenis,PH, Lekosit, Nitrit, Protein, Glukosa, Keton,Urablinogen, Bilurubin, Eryl);
  _drawGridSedimen(page, Epitel, LekositSedimen, EritrositSedimen, Bakteri, Kristal);
  if(HbSag=="-" || HIV=="-" || VDRL == "-" || Narkoba == "-"){

  }else{
    _drawGridImmunoserologi(page, HbSag,HIV,VDRL,Narkoba,Kehamilan,jk);
  }
  _drawGridFooter(page, Pemeriksa,Pemeriksaan,Spesimen);
  //Add invoice footer
  // _drawFooter(page, pageSize,Pemeriksa);
  //Save and dispose the document.
  final List<int> bytes = await document.save();
  document.dispose();
  //Launch file.
  await saveAndLaunchFile(bytes, "Laporan_"+Nama+'.pdf');
}

//Draws the invoice header
PdfLayoutResult _drawHeader(
    PdfPage page,
    Size pageSize,
    //Data Pribadi
    String Nama,
    String NRP,
    String NIP,
    String Kesatuan,
    String jk,
    String TempatLahir,
    String TanggalLahir,
    String NoLab,
    String Pemeriksa,
    String Dokter,
    String TanggalPemeriksaan
    ) {
  
  final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, MainSize+90, pageSize.width, 20),
      brush: PdfSolidBrush(PdfColor(5, 165, 5)));
  page.graphics.drawString("Hematologi",
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      bounds: Rect.fromLTWH(0,MainSize+90, pageSize.width, 20),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  //Draw string;
  //Create data foramt and convert it to text.
  final DateFormat format = DateFormat.yMMMMd('en_US');
  const String text2 =
      'Nama Pasien\n'
      'NRP/NIP\n'
      'Jenis Kelamin\n'
      'Kesatuan';
  final Size contentSize = contentFont.measureString(text2);
  String Text2 =
      ': '+Nama+'\n'+
          ': '"$NRP/$NIP"'\n'+
          ': '+jk+'\n'+
          ': '+Kesatuan+'\n';
  PdfTextElement(text: Text2, font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(
          60,
          MainSize+40,
          pageSize.width*(1/4),
          pageSize.height - 120)
  );

  String text1 =
      'TTL / Umur\n'+
      'No Lab\n'
      'Dokter\n'
      'Tgl Pemeriksa\n';
  PdfTextElement(text: text1, font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(
          290,
          MainSize+40,
          pageSize.width*(2/4),
          pageSize.height - 120)
  );
  String Text1 =
      ': $TempatLahir,'+DateBuilder(TanggalLahir)+'/ '+CalculateAge(TanggalLahir)+' \n'+
          ': '+NoLab+'\n'+
          ': '+Dokter+'\n'+
          ': '+DateBuilder(DateTime.now().toString())+'\n';
  PdfTextElement(text: Text1, font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(
          370,
          MainSize+40,
          pageSize.width*(3/4),
          pageSize.height - 120)
  );

  return PdfTextElement(text:text2, font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(
          0,
          MainSize+40,
          pageSize.width - (contentSize.width + 30),
          pageSize.height - 120)
  )!;
}
//Draws the grid
void _drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
  Rect? totalPriceCellBounds;
  Rect? quantityCellBounds;

  //Invoke the beginCellLayout event.
  grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
    final PdfGrid grid = sender as PdfGrid;
    if (args.cellIndex == grid.columns.count - 1) {
      totalPriceCellBounds = args.bounds;
    } else if (args.cellIndex == grid.columns.count - 2) {
      quantityCellBounds = args.bounds;
    }
  };
  //Draw the PDF grid and get the result.
  result = grid.draw(
      page: page,
      bounds: Rect.fromLTWH(
          0,
          result.bounds.bottom + 50,
          0,
          0)
  )!;
}
void _drawGridHematologi(PdfPage page,String Hemogoblin,String Hematokrit,String Lekosit,String Trombosit,String Eritrosit,String LED) {
  final Size pageSize = page.getClientSize();
  //-------------------------------------------------------
  //HEMATOLGI


  
  //Hemogoblin
  page.graphics.drawString("Hemogoblin",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(0,MainSize+105, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+105, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(Hemogoblin,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+105, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(
      "\nP : 14 - 18 gr/dl"
      "\nW : 12 - 14 gr/dl",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(2/6),MainSize+105, pageSize.width/6-5, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle));
  //Hemotokrit
  page.graphics.drawString("Hematokrit",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(3/6)+5,MainSize+105, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(4/6),MainSize+105, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(Hematokrit,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(4/6),MainSize+105, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(
      "\nP : 40 - 48 %"
      "\nW : 37 - 43 %",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH((pageSize.width*(5/6)),MainSize+105, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle));
  //Lekosit
  page.graphics.drawString("Lekosit",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(0,MainSize+135, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+135, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(Lekosit,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+135, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString("/ul x 10² 5 - 10",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(2/6),MainSize+135, pageSize.width/6-5, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle));
  //Trombsit
  page.graphics.drawString("Trombosit",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(3/6)+5,MainSize+135, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(4/6),MainSize+135, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(Trombosit,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(4/6),MainSize+135, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString("/ul x 10³ 150 - 350",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH((pageSize.width*(5/6)),MainSize+135, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle));
  //Eritrosit
  page.graphics.drawString("Eritrosit",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(0/6),MainSize+155, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+155, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(Eritrosit,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+155, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString("juta/ul P : 4.5 - 5.5\nW : 4.0 - 5.0",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH((pageSize.width*(2/6)),MainSize+155, pageSize.width/6-5, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle));
  //LED
  page.graphics.drawString("LED",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(3/6)+5,MainSize+155, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(4/6),MainSize+155, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(LED,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(4/6),MainSize+155, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString("/mm/jam P : 0 - 10\nW :  0 - 20",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH((pageSize.width*(5/6)),MainSize+155, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle));
  //-------------------------------------------------------
  //HEMATOLGI
}
void _drawGridFooter(PdfPage page,String Pemeriksa,String Pemeriksaan,Spesimen){
  final Size pageSize = page.getClientSize();
  page.graphics.drawString("Waktu Pemeriksaan",
      PdfStandardFont(PdfFontFamily.helvetica, 6),
      bounds: Rect.fromLTWH(page.size.width*(0/6),pageSize.height - 55, page.size.width*(2/6), 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(": "+Pemeriksaan,
      PdfStandardFont(PdfFontFamily.helvetica, 6),
      bounds: Rect.fromLTWH(page.size.width*(3/12),pageSize.height - 55, page.size.width*(2/6), 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString("Hasil Spesimen",
      PdfStandardFont(PdfFontFamily.helvetica, 6),
      bounds: Rect.fromLTWH(page.size.width*(0/6),pageSize.height - 50, page.size.width*(2/6), 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(": "+Spesimen,
      PdfStandardFont(PdfFontFamily.helvetica, 6),
      bounds: Rect.fromLTWH(page.size.width*(3/12),pageSize.height - 50, page.size.width*(2/6), 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString("Pemeriksa",
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      bounds: Rect.fromLTWH(page.size.width*(3/6),pageSize.height - 95, page.size.width*(3/6), 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString("($Pemeriksa)",
      PdfStandardFont(PdfFontFamily.helvetica,12),
      bounds: Rect.fromLTWH(page.size.width*(3/6),pageSize.height -35, page.size.width*(3/6), 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
}
void _drawGridImmunoserologi(PdfPage page,String hbsag,String hiv,String vdrl,String Narkoba,String Kehamilan,String Kelamin){
  final Size pageSize = page.getClientSize();
  MainSize = MainSize+350;
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, MainSize, pageSize.width/2, 20),
      brush: PdfSolidBrush(PdfColor(5, 165, 5)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Immunoserologi",
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      bounds: Rect.fromLTWH(0,MainSize, pageSize.width/2, 20),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));

  //HBsAg
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, MainSize+20, pageSize.width/2, 20),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("HBsAg",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(0+5,MainSize, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize, pageSize.width/4, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(hbsag,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize, pageSize.width/4, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  //HIV
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, MainSize+40, pageSize.width/2, 20),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("HIV",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(0+5,MainSize+20, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+20, pageSize.width/4, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(hiv,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+20, pageSize.width/4, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  //HIV
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, MainSize+60, pageSize.width/2, 20),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("VDRL",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(0+5,MainSize+40, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+40, pageSize.width/4, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(vdrl,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+40, pageSize.width/4, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));

  //Narkoba
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(pageSize.width/2, MainSize, pageSize.width/4-5, 20),
      brush: PdfSolidBrush(PdfColor(5, 165, 5)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Narkoba",
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      bounds: Rect.fromLTWH(pageSize.width/2+5,MainSize, pageSize.width/4, 20),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(pageSize.width/2, MainSize, pageSize.width/2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString(Narkoba,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width-(pageSize.width/4)+5,MainSize, pageSize.width/6, 20),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  //Kehamilan
  Kelamin == "P" ?page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(pageSize.width/2, MainSize+20, pageSize.width/4-5, 20),
      brush: PdfSolidBrush(PdfColor(5, 165, 5)),
      pen: PdfPen(PdfColor(0,0,0))
  ) : null;

  Kelamin == "P" ? page.graphics.drawString("Kehamilan",
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      bounds: Rect.fromLTWH(pageSize.width/2+5,MainSize+20, pageSize.width/4, 20),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle)) : null;

  Kelamin == "P" ? page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(pageSize.width/2, MainSize+20, pageSize.width/2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  ) : null;
  Kelamin == "P" ? page.graphics.drawString(Kehamilan,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width-(pageSize.width/4)+5,MainSize+20, pageSize.width/6, 20),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle)) : null;
}
void _drawGridUrinalisa(
    PdfPage page,
    String Warna,
    String BeratJenis,
    String PH,
    String Lekosit,
    String Nitrit,
    String Protein,
    String Glukose,
    String Keton,
    String Uroblinogen,
    String Bilurubin,
    String Eryl
    ){
  final Size pageSize = page.getClientSize();
  MainSize = MainSize;
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(pageSize.width/2, MainSize+10, pageSize.width/2, 20),
      brush: PdfSolidBrush(PdfColor(5, 165, 5)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Urinalisa",
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      bounds: Rect.fromLTWH(pageSize.width/2,MainSize+10, pageSize.width/2, 20),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));

  //Urinalisa
  //Warna
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(pageSize.width/2, MainSize+30, pageSize.width / 2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Warna",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width/2+5,MainSize+10, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(4.5/6),MainSize+10, pageSize.width/4, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(Warna,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(4.5/6),MainSize+10, pageSize.width/4, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  //Berat jenis
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(pageSize.width/2, MainSize+50, pageSize.width / 2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Berat Jenis",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width/2+5,MainSize+30, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(4.5/6),MainSize+30, pageSize.width/4, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(BeratJenis,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(4.5/6),MainSize+30, pageSize.width/4, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  //PH
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(pageSize.width/2, MainSize+70, pageSize.width / 2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("PH",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width/2+5,MainSize+50, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(4.5/6),MainSize+50, pageSize.width/4, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(PH,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(4.5/6),MainSize+50, pageSize.width/4, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  //Lekosit
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(pageSize.width/2, MainSize+90, pageSize.width / 2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Lekosit",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width/2+5,MainSize+70, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(4.5/6),MainSize+70, pageSize.width/4, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(Lekosit,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(4.5/6),MainSize+70, pageSize.width/4, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  //Nitrit
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(pageSize.width/2, MainSize+110, pageSize.width / 2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Nitrit",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width/2+5,MainSize+90, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(4.5/6),MainSize+90, pageSize.width/4, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(Nitrit,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(4.5/6),MainSize+90, pageSize.width/4, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  //Protein
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(pageSize.width/2, MainSize+130, pageSize.width / 2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Protein",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width/2+5,MainSize+110, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(4.5/6),MainSize+110, pageSize.width/4, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(Protein,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(4.5/6),MainSize+110, pageSize.width/4, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  //Glukose
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(pageSize.width/2, MainSize+150, pageSize.width / 2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Glukose",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width/2+5,MainSize+130, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(4.5/6),MainSize+130, pageSize.width/4, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(Glukose,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(4.5/6),MainSize+130, pageSize.width/4, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  //Keton
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(pageSize.width/2, MainSize+170, pageSize.width / 2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Keton",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width/2+5,MainSize+150, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(4.5/6),MainSize+150, pageSize.width/4, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(Keton,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(4.5/6),MainSize+150, pageSize.width/4, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  //Uroblinogen
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(pageSize.width/2, MainSize+190, pageSize.width / 2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Uroblinogen",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width/2+5,MainSize+170, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(4.5/6),MainSize+170, pageSize.width/4, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(Uroblinogen,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(4.5/6),MainSize+170, pageSize.width/4, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  //Bilurubin
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(pageSize.width/2, MainSize+210, pageSize.width / 2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Bilurubin",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width/2+5,MainSize+190, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(4.5/6),MainSize+190, pageSize.width/4, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(Bilurubin,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(4.5/6),MainSize+190, pageSize.width/4, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  //Eryl
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(pageSize.width/2, MainSize+230, pageSize.width / 2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Eryl/Hb",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width/2+5,MainSize+210, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(4.5/6),MainSize+210, pageSize.width/4, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(Eryl,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(4.5/6),MainSize+210, pageSize.width/4, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
}
void _drawGridSedimen(
    PdfPage page,
    String Epitel,
    String Lekosit,
    String Eritrosit,
    String Bakteri,
    String Kristal
    ){
  final Size pageSize = page.getClientSize();
  MainSize = MainSize;
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(pageSize.width/2, MainSize+250, pageSize.width/4-5, 20),
      brush: PdfSolidBrush(PdfColor(5, 165, 5)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Sedimen",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width/2+5,MainSize+230, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));

  // page.graphics.drawString("Urinalisa",
  //     PdfStandardFont(PdfFontFamily.helvetica, 18),
  //     bounds: Rect.fromLTWH(pageSize.width/2,MainSize, pageSize.width/2, 30),
  //     brush: PdfBrushes.white,
  //     format: PdfStringFormat(
  //         alignment: PdfTextAlignment.center,
  //         lineAlignment: PdfVerticalAlignment.middle));

  //Epitel
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(pageSize.width/2, MainSize+250, pageSize.width/2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Epitel",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width-(pageSize.width/4)+5,MainSize+230, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width-(pageSize.width/6),MainSize+230, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(Epitel,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width-(pageSize.width/6),MainSize+230, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  //Lekosit
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(pageSize.width/2, MainSize+270, pageSize.width/2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Lekosit",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width-(pageSize.width/4)+5,MainSize+250, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width-(pageSize.width/6),MainSize+250, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(Lekosit,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width-(pageSize.width/6),MainSize+250, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  //Eritrosit
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(pageSize.width/2, MainSize+290, pageSize.width/2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Eritrosit",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width-(pageSize.width/4)+5,MainSize+270, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width-(pageSize.width/6),MainSize+270, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(Eritrosit,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width-(pageSize.width/6),MainSize+270, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  //Bakteri
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(pageSize.width/2, MainSize+310, pageSize.width/2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Bakteri",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width-(pageSize.width/4)+5,MainSize+290, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width-(pageSize.width/6),MainSize+290, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(Bakteri,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width-(pageSize.width/6),MainSize+290, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  //Kristal
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(pageSize.width/2, MainSize+330, pageSize.width/2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Kristal",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width-(pageSize.width/4)+5,MainSize+310, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width-(pageSize.width/6),MainSize+310, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(Kristal,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width-(pageSize.width/6),MainSize+310, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
}
void _drawGridKimiaDarah(
    PdfPage page,
    String BilurubinTotal,
    String BilurubinDirect,
    String BilurubinIndirect,
    String SGOT,
    String SGPT,
    String CholesterolTotal,
    String HDL,
    String LDL,
    String Trigliserida,
    String Ureum,
    String Creatinin,
    String AsamUrat,
    String GulaDarahN,
    String GulaDarah2JamPP,
    String GulaDarahSewaktu) {
  final Size pageSize = page.getClientSize();
  MainSize = MainSize + 200;

  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, MainSize+10, pageSize.width/2, 20),
      brush: PdfSolidBrush(PdfColor(5, 165, 5)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Kimia Darah",
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      bounds: Rect.fromLTWH(0,MainSize+10, pageSize.width/2, 20),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));

  //-------------------------------------------------------
  //Kimia Darah
  //Bilurubin Total
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, MainSize+30, pageSize.width / 2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Bilurubin Total",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(0+5,MainSize+10, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+10, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(BilurubinTotal,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+10, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString("0.5 - 1.0 mg/dl",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(2/6),MainSize+10, pageSize.width/6-5, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle));
  //Bilurubin Dircet
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, MainSize+50, pageSize.width / 2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Bilurubin Direct",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(0+5,MainSize+30, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+30, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(BilurubinDirect,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+30, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString("0 - 0.4",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(2/6),MainSize+30, pageSize.width/6-5, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle));
  //Bilurubin Indirect
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, MainSize+70, pageSize.width / 2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Bilurubin Indirect",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(0+5,MainSize+50, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+50, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(BilurubinIndirect,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+50, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString("0 - 0.5 mg/dl",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH((pageSize.width*(2/6)),MainSize+50, pageSize.width/6-5, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle));
  //SGOT
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, MainSize+90, pageSize.width / 2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("SGOT",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(0/6)+5,MainSize+70, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+70, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(SGOT,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+70, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString("<40 U/L",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH((pageSize.width*(2/6)),MainSize+70, pageSize.width/6-5, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle));
  //SGPT
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, MainSize+110, pageSize.width / 2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("SGPT",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(0+5,MainSize+90, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+90, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(SGPT,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+90, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString("<40 U/L",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH((pageSize.width*(2/6)),MainSize+90, pageSize.width/6-5, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle));
  //Cholesterol Total
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, MainSize+130, pageSize.width / 2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Cholesterol Total",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(0+5,MainSize+110, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+110, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(CholesterolTotal,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+110, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString("150 - 200 mg/dl",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH((pageSize.width*(2/6)),MainSize+110, pageSize.width/6-5, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle));
  //HDL
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, MainSize+150, pageSize.width / 2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("HDL",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(0+5,MainSize+130, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+130, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(HDL,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+130, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(">45 mg/dl",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH((pageSize.width*(2/6)),MainSize+130, pageSize.width/6-5, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle));
  //LDL
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, MainSize+170, pageSize.width / 2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("LDL",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(0+5,MainSize+150, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+150, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(LDL,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+150, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString("<130",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH((pageSize.width*(2/6)),MainSize+150, pageSize.width/6-5, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle));
  //Trigliserida
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, MainSize+190, pageSize.width / 2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Trigliserida",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(0+5,MainSize+170, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+170, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(Trigliserida,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+170, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString("40 - 150",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH((pageSize.width*(2/6)),MainSize+170, pageSize.width/6-5, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle));
  //Ureum
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, MainSize+210, pageSize.width / 2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Ureum",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(0/6)+5,MainSize+190, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(": ",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+190, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(Trigliserida,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+190, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString("15 - 50",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH((pageSize.width*(2/6)),MainSize+190, pageSize.width/6-5, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle));
  //Creatinin
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, MainSize+230, pageSize.width / 2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Creatinin",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(0/6)+5,MainSize+210, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+210, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(Creatinin,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+210, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString("0.3 - 1.3 mg/dl",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH((pageSize.width*(2/6)),MainSize+210, pageSize.width/6-5, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle));
  //Asam Urat
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, MainSize+250, pageSize.width / 2, 40),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Asam Urat",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(0+5,MainSize+230, pageSize.width/6, 80),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+230, pageSize.width/6, 80),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(AsamUrat,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+230, pageSize.width/6, 80),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString("P : 3.0 - 7.0 mg/dl\nW : 3.0 - 5.7",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH((pageSize.width*(2/6)),MainSize+230, pageSize.width/6-5, 80),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle));
  //Gula Darah N
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, MainSize+290, pageSize.width / 2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Gula Darah N",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(0+5,MainSize+270, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+270, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(GulaDarahN,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+270, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString("60 - 110 mg/dl",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH((pageSize.width*(2/6)),MainSize+270, pageSize.width/6-5, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle));
  //Gula Darah 2 Jam PP
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, MainSize+310, pageSize.width / 2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Gula Darah 2 Jam PP",
      PdfStandardFont(PdfFontFamily.helvetica, 8),
      bounds: Rect.fromLTWH(pageSize.width*(0/6)+5,MainSize+290, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+290, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(GulaDarah2JamPP,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+290, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString("<140 mg/dl",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH((pageSize.width*(2/6)),MainSize+290, pageSize.width/6-5, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle));
  //Gula Darah Sewaktu
  page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, MainSize+330, pageSize.width / 2, 20),
      // brush: PdfSolidBrush(PdfColor(65, 200, 45)),
      pen: PdfPen(PdfColor(0,0,0))
  );
  page.graphics.drawString("Gula Darah Sewaktu",
      PdfStandardFont(PdfFontFamily.helvetica, 8),
      bounds: Rect.fromLTWH(pageSize.width*(0/6)+5,MainSize+310, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(":",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+310, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.left,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString(GulaDarahSewaktu,
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH(pageSize.width*(1/6),MainSize+310, pageSize.width/6, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.center,
          lineAlignment: PdfVerticalAlignment.middle));
  page.graphics.drawString("<140 mg/dl",
      PdfStandardFont(PdfFontFamily.helvetica, 10),
      bounds: Rect.fromLTWH((pageSize.width*(2/6)),MainSize+310, pageSize.width/6-5, 60),
      brush: PdfBrushes.black,
      format: PdfStringFormat(
          alignment: PdfTextAlignment.right,
          lineAlignment: PdfVerticalAlignment.middle));
  //-------------------------------------------------------
  //Kimia Darah
}

//Draw the invoice footer data.
void _drawFooter(PdfPage page, Size pageSize,String nama) {
  final PdfPen linePen =
  PdfPen(PdfColor(65, 200, 65), dashStyle: PdfDashStyle.custom);
  linePen.dashPattern = <double>[3, 3];
  //Draw line
  page.graphics.drawLine(linePen, Offset(0, pageSize.height - 80),
      Offset(pageSize.width, pageSize.height - 80));
  String footerContent =
      nama+
      '\r\n\r\n'
      '\r\n\r\n'
      '\r\n\r\n'
      '(______________)';
  //Added 30 as a margin for the layout
  page.graphics.drawString(
      footerContent, PdfStandardFont(PdfFontFamily.helvetica, 9),
      format: PdfStringFormat(alignment: PdfTextAlignment.right),
      bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 50, 0, 0));
}

//Create PDF grid and return
PdfGrid _getGrid(
    //Hematologi
    String Hemogoblin,
    String Lekosit,
    String Eritrosit,
    String Hematokrit,
    String Trombosit,
    String LED
    ) {
  //Create a PDF grid
  final PdfGrid grid = PdfGrid();
  //Secify the columns count to the grid.
  grid.columns.add(count: 3);
  //Create the header row of the grid.
  final PdfGridRow headerRow = grid.headers.add(1)[0];
  //Set style
  headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(65, 200, 65));

  headerRow.style.textBrush = PdfBrushes.white;
  headerRow.cells[0].value = 'Pemeriksaan';
  headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
  headerRow.cells[1].value = 'Nilai';
  headerRow.cells[1].stringFormat.alignment = PdfTextAlignment.center;
  headerRow.cells[2].value = 'Rujukan';
  headerRow.cells[2].stringFormat.alignment = PdfTextAlignment.center;
  _addData("Hemogoblin", Hemogoblin, "14 - 18 gr/dl/p ", grid);
  _addData("Lekosit", Lekosit, "5 - 10 /ulx 10²", grid);
  _addData("Eritrosit", Eritrosit, "4,5 - 5,5 juta/ul P", grid);
  _addData("Hematokrit", Hematokrit, "40 - 48 % P", grid);
  _addData("Trombosit", Trombosit, "150 - 350 ul x 10² P", grid);
  _addData("LED", LED, "0 - 10 mm/jam P", grid);
  // grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
  for (int i = 0; i < headerRow.cells.count; i++) {
    headerRow.cells[i].style.cellPadding =
        PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
  }
  for (int i = 0; i < grid.rows.count; i++) {
    final PdfGridRow row = grid.rows[i];
    for (int j = 0; j < row.cells.count; j++) {
      final PdfGridCell cell = row.cells[j];
      // if (j == 0) {
      //   cell.stringFormat.alignment = PdfTextAlignment.center;
      // }
      cell.stringFormat.alignment = PdfTextAlignment.center;
      cell.style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
  }
  return grid;
}
PdfGrid _getGridUrinalisa(
    //Urinalisa
    String Warna,
    String BeratJenis,
    String Lekosit,
    String Nitrit,
    String Glukosa,
    String Keton,
    String Urablinogen,
    String Bilurubin,
    String Eryl,
    ) {
  //Create a PDF grid
  final PdfGrid grid = PdfGrid();
  //Secify the columns count to the grid.
  grid.columns.add(count: 2);
  //Create the header row of the grid.
  final PdfGridRow headerRow = grid.headers.add(1)[0];
  //Set style
  headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(65, 200, 65));

  headerRow.style.textBrush = PdfBrushes.white;
  headerRow.cells[0].value = 'Pemeriksaan';
  headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
  headerRow.cells[1].value = 'Nilai';
  headerRow.cells[1].stringFormat.alignment = PdfTextAlignment.center;
  _addData2("Warna", Warna,grid);
  _addData2("Berat Jenis", BeratJenis,grid);
  _addData2("Lekosit", Lekosit,grid);
  _addData2("Nitrit", Nitrit,grid);
  _addData2("Glukosa", Glukosa,grid);
  _addData2("Keton", Keton,grid);
  _addData2("Urablinogen", Urablinogen,grid);
  _addData2("Bilurubin", Bilurubin,grid);
  _addData2("Eryl/Hb", Eryl,grid);
  // grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
  for (int i = 0; i < headerRow.cells.count; i++) {
    headerRow.cells[i].style.cellPadding =
        PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
  }
  for (int i = 0; i < grid.rows.count; i++) {
    final PdfGridRow row = grid.rows[i];
    for (int j = 0; j < row.cells.count; j++) {
      final PdfGridCell cell = row.cells[j];
      // if (j == 0) {
      //   cell.stringFormat.alignment = PdfTextAlignment.center;
      // }
      cell.stringFormat.alignment = PdfTextAlignment.center;
      cell.style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
  }
  return grid;
}
PdfGrid _getGridKimiaDarah(
    //Hematologi
    String BilurubinTotal,
    String BilurubinDirect,
    String BilurubinIndirect,
    String SGOT,
    String SPGT,
    String CholesterolTotal,
    String CholesterolLDL,
    String CholesterolHDL,
    String Trigliserida,
    String Ureum,
    String Creatinin,
    String AsamUrat,
    String GulaDarahPuasa,
    String GulaDarah2JamPP,
    String GulaDarahSewaktu
    ) {
  //Create a PDF grid
  final PdfGrid grid = PdfGrid();
  //Secify the columns count to the grid.
  grid.columns.add(count: 3);
  //Create the header row of the grid.
  final PdfGridRow headerRow = grid.headers.add(1)[0];
  //Set style
  headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(65, 200, 65));

  headerRow.style.textBrush = PdfBrushes.white;
  headerRow.cells[0].value = 'Pemeriksaan';
  headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
  headerRow.cells[1].value = 'Nilai';
  headerRow.cells[1].stringFormat.alignment = PdfTextAlignment.center;
  headerRow.cells[2].value = 'Rujukan';
  headerRow.cells[2].stringFormat.alignment = PdfTextAlignment.center;
  _addData("Bilurubin Total", BilurubinTotal, "0.5-1.0 mg/dl ", grid);
  _addData("Bilurubin Direct", BilurubinDirect, "0-0.4 mg/dl", grid);
  _addData("Bilurubin Indirect", BilurubinIndirect, "0 - 0.5 mg/dl", grid);
  _addData("SGOT", SGOT, "<40 U/L", grid);
  _addData("SPGT", SPGT, "<40 U/L", grid);
  _addData("Cholesterol Total", CholesterolTotal, "150-200 mg/dl", grid);
  _addData("Cholesterol LDL", CholesterolLDL, ">45 mg/dl", grid);
  _addData("Cholesterol HDL", CholesterolHDL, "<130 mg/dl", grid);
  _addData("Trigiliserida", Trigliserida, "40 - 150 mg/dl", grid);
  _addData("Ureum", Ureum, "15 - 50 mg/dl", grid);
  _addData("Asam Urat", AsamUrat, "P : 3.0-7.0 mg/dl\nW L 3.0-5.7 mg/dl", grid);
  _addData("Gula Darah Puasa", GulaDarahPuasa, "60 - 110 mg/dl", grid);
  _addData("Gula Darah 2 Jam PP", GulaDarah2JamPP, "<140 mg/dl", grid);
  _addData("Gula Darah Sewaktu", GulaDarahSewaktu, "<140 mg/dl", grid);
  // grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
  for (int i = 0; i < headerRow.cells.count; i++) {
    headerRow.cells[i].style.cellPadding =
        PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
  }
  for (int i = 0; i < grid.rows.count; i++) {
    final PdfGridRow row = grid.rows[i];
    for (int j = 0; j < row.cells.count; j++) {
      final PdfGridCell cell = row.cells[j];
      // if (j == 0) {
      //   cell.stringFormat.alignment = PdfTextAlignment.center;
      // }
      cell.stringFormat.alignment = PdfTextAlignment.center;
      cell.style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
  }
  return grid;
}

void _addData(String Nama,String Nilai,String Rujukan, PdfGrid grid){
  final PdfGridRow row = grid.rows.add();
  row.cells[0].value = Nama;
  row.cells[1].value = Nilai;
  row.cells[2].value = Rujukan;
}
void _addData2(String Nama,String Nilai, PdfGrid grid){
  final PdfGridRow row = grid.rows.add();
  row.cells[0].value = Nama;
  row.cells[1].value = Nilai;
}