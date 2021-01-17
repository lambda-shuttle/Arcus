import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PrimaryColors {
  var colors = [];

  PrimaryColors({this.colors});

  factory PrimaryColors.fromJson(Map<String, dynamic> json) {
    var expCols = [];
    for(var i=0; i<4; i++){
      expCols.add(Color.fromRGBO(
          json["responses"][0]["imagePropertiesAnnotation"]
                  ["dominantColors"]["colors"][i]["color"]["red"],
          json["responses"][0]["imagePropertiesAnnotation"]
                  ["dominantColors"]["colors"][i]["color"]["green"],
          json["responses"][0]["imagePropertiesAnnotation"]
                  ["dominantColors"]["colors"][i]["color"]["blue"],
          1.0));
    }
    return PrimaryColors(colors: expCols);
  }
}

Future<PrimaryColors> fetchPalette(var imageUri) async {
  final body = {"requests" : [{"image" : {"source" : {"imageUri" : "$imageUri"}}, "features" : [{"maxResults" : 4, "type" : "IMAGE_PROPERTIES"},]}]};
  final token = "ya29.c.Kp0B7gfGPQE-ouCts4qxp-Q2jduNb0joTs9uDF5d7hvd1nWLwTYZedZ8lb0u0QNO3QrV-7uxIqys61TKG7lD-02gbRDAETfW7BwjYMWanIBFBnFh49wFidjuMOrz-XJ8fN35hFVRMS7KackPAV64q6dSKVo5vLqCaXiFM1FfVe_oDSD_0dxaER7zCKCo8FeNP0jL4TF1xzVffUxXLbi63w";
  final headers = {"Content-Type": "application/json", "Authorization" : "Bearer $token"};
  final response = await http.post("https://vision.googleapis.com/v1/images:annotate", body: jsonEncode(body), headers: headers);

  if (response.statusCode == 200) {
    print("authed");
    return PrimaryColors.fromJson(jsonDecode(response.body));
  } else {
    print(response.body);
    throw Exception("Could not load Searched Palette");
  }
}
