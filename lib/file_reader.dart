import 'dart:convert';
import 'dart:io';
import 'package:excel/excel.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:excel/excel.dart';

class ExcelService {
  /// Reads all sheets from the Excel file and returns a map of sheet name to sheet data

 static Future<Map<String, List<List<String>>>> readExcelFile() async {
    try {
      ByteData data = await rootBundle.load('assets/address.xlsx');
      Uint8List bytes = data.buffer.asUint8List();
      var excel = Excel.decodeBytes(bytes);

      Map<String, List<List<String>>> allSheetsData = {};

      for (var sheetName in excel.tables.keys) {
        var sheetData = <List<String>>[];

        for (var row in excel.tables[sheetName]!.rows) {
          sheetData
              .add(row.map((cell) => cell?.value.toString() ?? "").toList());
        }

        allSheetsData[sheetName] = sheetData;
      }

      return allSheetsData;
    } catch (e) {
      print("Error reading Excel file: $e");
      return {};
    }
  }

  static Future<void> jsonStructureCre(Map<String, dynamic> data) async{
    Map<String, dynamic> jsonStructure = {};

   data.forEach((sheetName, sheetData) {
     // Skip header row if exists
     if (sheetData is List && sheetData.length > 1) {
       // Initialize structure as a single list instead of using sheet name
       if (!jsonStructure.containsKey('formations')) {
         jsonStructure['formations'] = [];
       }

       // Process each data row (skip header)
       for (int i = 1; i < sheetData.length; i++) {
         final row = sheetData[i];
         if (row.length < 2) continue; // Skip rows with insufficient data

         final formationType = row[0].toString();
         final commissionerateName = row[1].toString();

         // Find or create formation type entry
         var formationEntry = jsonStructure['formations'].firstWhere(
           (entry) => entry['id'] == formationType.toLowerCase().replaceAll(' ', '_'),
           orElse: () {
             var newEntry = {
               'id': formationType.toLowerCase().replaceAll(' ', '_'),
               'name': formationType,
               'commissionerates': []
             };
             jsonStructure['formations'].add(newEntry);
             return newEntry;
           }
         );

         // Find or add commissionerate
         var commissionerates = formationEntry['commissionerates'];
         var existingComm = commissionerates.firstWhere(
           (comm) => comm['id'] == commissionerateName.toLowerCase().replaceAll(' ', '_'),
           orElse: () {
             var newComm = {
               'id': commissionerateName.toLowerCase().replaceAll(' ', '_'),
               'name': commissionerateName,
               'divisions': []
             };
             commissionerates.add(newComm);
             return newComm;
           }
         );


        // Find or add divisions
                 if (row.length >= 3) {
                   final divisionName = row[2].toString();
                   final divisions = existingComm['divisions'];
                   var existingDiv = divisions.firstWhere(
                     (div) => div['id'] == divisionName.toLowerCase().replaceAll(' ', '_'),
                     orElse: () {
                       var newDiv = {
                         'id': divisionName.toLowerCase().replaceAll(' ', '_'),
                         'name': divisionName,
                         'ranges': []
                       };
                       divisions.add(newDiv);
                       return newDiv;
                     }
                   );

                   // Add range with address if available
                   if (row.length >= 5) {
                     final address = row[4].toString();
                     final range = row[3].toString();
                     existingDiv['ranges'].add({
                       'id': 'range_${existingDiv['ranges'].length + 1}',
                       'name': range=="NA" ? "" : range,
                       'addresses': address
                     });
                   }
                 }



       }
     }
   });


  final jsonData= jsonEncode(jsonStructure);

    print(jsonStructure);
    print(jsonData);

  }




}



// Example usage:
