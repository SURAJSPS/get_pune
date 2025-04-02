
  import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

List<Audit> appStructure=[];
class JsonCreator  {

  static void createJson(Map<String,dynamic> data) {
    appStructure=[];


    final transformedData = transformGSTData(data);
    String json = jsonEncode(transformedData);
    print(transformedData);
    print(json);

    for(int i=0;i<data.length;i++){
      // appStructure[data.keys.elementAt(i)]=[data.values.elementAt(i)];
      for(int j=0;j<data[data.keys.elementAt(i)].length;j++){

        // appStructure[data.keys.elementAt(i)]=[data.values.elementAt(i)];
        for(int k=0;k<data[data.keys.elementAt(i)][j].length;k++){
print("${" i $i"} ${" j $j"} ${" k $k"}");
print((data.values.elementAt(j) as List)[k]);



          appStructure.add( Audit(
              name: data.keys.elementAt(j),
              id: data.keys.elementAt(j).toLowerCase(),
              commissionerates: (data.values.elementAt(j) as List).map((value)=>Commissionerate(
                divisions: [],
                    id: value[0].toString().toLowerCase(),
                name: value[0],
              )).toList()
          ));

          }
          }

        }
    print(appStructure);
      }

  static Future<void> writeJsonToFile(String filePath,Map<String,dynamic> data) async {
    try {
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/$filePath');
      if (!(await directory.exists())) {
        await directory.create(recursive: true);
      }
      String json = jsonEncode(data);
      await file.writeAsString(json);
      print("JSON file created at ${file.path}");
    } catch (e) {
      print("Error writing JSON file: $e");
    }
  }
    }



// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);




class AddressModel {
  Formation formation;

  AddressModel({
    required this.formation,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    formation: Formation.fromJson(json["formation"]),
  );

  Map<String, dynamic> toJson() => {
    "formation": formation.toJson(),
  };
}

class Formation {
  Audit executive;
  Audit audit;

  Formation({
    required this.executive,
    required this.audit,
  });

  factory Formation.fromJson(Map<String, dynamic> json) => Formation(
    executive: Audit.fromJson(json["executive"]),
    audit: Audit.fromJson(json["audit"]),
  );

  Map<String, dynamic> toJson() => {
    "executive": executive.toJson(),
    "audit": audit.toJson(),
  };
}

class Audit {
  String id;
  String name;
  List<Commissionerate> commissionerates;

  Audit({
    required this.id,
    required this.name,
    required this.commissionerates,
  });

  factory Audit.fromJson(Map<String, dynamic> json) => Audit(
    id: json["id"],
    name: json["name"],
    commissionerates: List<Commissionerate>.from(json["commissionerates"].map((x) => Commissionerate.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "commissionerates": List<dynamic>.from(commissionerates.map((x) => x.toJson())),
  };
}

class Commissionerate {
  String id;
  String name;
  List<Division> divisions;

  Commissionerate({
    required this.id,
    required this.name,
    required this.divisions,
  });

  factory Commissionerate.fromJson(Map<String, dynamic> json) => Commissionerate(
    id: json["id"],
    name: json["name"],
    divisions: List<Division>.from(json["divisions"].map((x) => Division.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "divisions": List<dynamic>.from(divisions.map((x) => x.toJson())),
  };
}

class Division {
  String id;
  String name;
  List<Range> ranges;

  Division({
    required this.id,
    required this.name,
    required this.ranges,
  });

  factory Division.fromJson(Map<String, dynamic> json) => Division(
    id: json["id"],
    name: json["name"],
    ranges: List<Range>.from(json["ranges"].map((x) => Range.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "ranges": List<dynamic>.from(ranges.map((x) => x.toJson())),
  };
}

class Range {
  String id;
  String name;
  String addresses;

  Range({
    required this.id,
    required this.name,
    required this.addresses,
  });

  factory Range.fromJson(Map<String, dynamic> json) => Range(
    id: json["id"],
    name: json["name"],
    addresses: json["addresses"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "addresses": addresses,
  };
}


  // Map<String, dynamic> convertToFormation(Map<String, dynamic> jsonData) {
  //   Map<String, dynamic> formation = {
  //     "executive": {
  //       "id": "executive",
  //       "name": "Executive",
  //       "commissionerates": []
  //     },
  //     "audit": {
  //       "id": "audit",
  //       "name": "Audit",
  //       "commissionerates": []
  //     }
  //   };
  //
  //   jsonData.forEach((key, value) {
  //     if (value is List && value.isNotEmpty) {
  //       for (int i = 1; i < value.length; i++) { // Skip header row
  //         List row = value[i];
  //
  //         String formationType = row[0]; // "Executive" or "Audit"
  //         String commissionerateName = row[1];
  //         String sectionName = row[2];
  //         String address = row[4];
  //
  //         // Find or create commissionerate
  //         List commissionerates = formation[formationType.toLowerCase()]["commissionerates"];
  //         var commissionerate = commissionerates.firstWhere(
  //               (c) => c["name"] == commissionerateName,
  //           orElse: () {
  //             var newComm = {
  //               "id": commissionerateName.toLowerCase().replaceAll(" ", "_"),
  //               "name": commissionerateName,
  //               "divisions": []
  //             };
  //             commissionerates.add(newComm);
  //             return newComm;
  //           },
  //         );
  //
  //         // Find or create division
  //         List divisions = commissionerate["divisions"];
  //         var division = divisions.firstWhere(
  //               (d) => d["name"] == sectionName,
  //           orElse: () {
  //             var newDiv = {
  //               "id": sectionName.toLowerCase().replaceAll(" ", "_"),
  //               "name": sectionName,
  //               "ranges": []
  //             };
  //             divisions.add(newDiv);
  //             return newDiv;
  //           },
  //         );
  //
  //         // Add range
  //         division["ranges"].add({
  //           "id": "range_${i}",
  //           "name": "Range",
  //           "addresses": address
  //         });
  //       }
  //     }
  //   });
  //
  //   return {"formation": formation};
  // }
  //
  //


  Map<String, dynamic> transformGSTData(Map<String, dynamic> input) {
    // Initialize output with default structure
    final output = {
      'formation': {
        'executive': {
          'id': 'executive',
          'name': 'Executive',
          'commissionerates': [],
        },
        'audit': {
          'id': 'audit',
          'name': 'Audit',
          'commissionerates': [],
        }
      }
    };

    // Return empty structure if input is null or empty
    if (input == null || input.isEmpty) {
      return output;
    }

    input.forEach((commissionerateKey, sections) {
      // Skip if sections is null or not a List
      if (sections == null || sections is! List) {
        return;
      }

      // Skip if no data rows (header only or empty)
      if (sections.length <= 1) {
        return;
      }

      // Get commissionerate name from first data row
      final firstDataRow = sections[1] as List?;
      final commissionerateName = (firstDataRow != null && firstDataRow.length > 1)
          ? firstDataRow[1].toString()
          : '';

      final commissionerate = {
        'id': commissionerateKey?.toString()?.toLowerCase()?.replaceAll(' ', '-') ?? '',
        'name': commissionerateName,
        'divisions': [],
      };

      // Process each data row (skip header)
      for (var i = 1; i < sections.length; i++) {
        final row = sections[i] as List?;
        if (row == null || row.length < 5) continue;

        final divisionName = row[2]?.toString() ?? '';
        final address = row[4]?.toString() ?? '';

        // Skip if essential data is missing
        if (divisionName.isEmpty || address.isEmpty) continue;

        // Find or create division
        var division = (commissionerate['divisions'] as List).firstWhere(
              (div) => div['name'] == divisionName,
          orElse: () {
            final newDivision = {
              'id': divisionName
                  .toLowerCase()
                  .replaceAll(' ', '-')
                  .replaceAll('/', '-')
                  .replaceAll(RegExp(r'[^a-z0-9-]'), ''),
              'name': divisionName,
              'ranges': [],
            };
            (commissionerate['divisions'] as List).add(newDivision);
            return newDivision;
          },
        );

        // Add range
        (division['ranges'] as List).add({
          'id': '${commissionerate['id']}-range-${(division['ranges'] as List).length + 1}',
          'name': 'Range',
          'addresses': address,
        });
      }

      // Only add commissionerate if it has divisions
      if ((commissionerate['divisions'] as List).isNotEmpty) {
        (output['formation']?['executive']?['commissionerates'] as List).add(commissionerate);
      }
    });

    return output;
  }

  // Example usage with null checks:
