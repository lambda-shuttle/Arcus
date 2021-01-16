import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import './color_request.dart';

class PrimaryColors {
  final Color color1 = Color.fromRGBO(0, 0, 0, 0);
  final Color color2 = Color.fromRGBO(0, 0, 0, 0);
  final Color color3 = Color.fromRGBO(0, 0, 0, 0);
  final Color color4 = Color.fromRGBO(0, 0, 0, 0);

  PrimaryColors({this.color1, this.color2, this.color3, this.color4});

  factory PrimaryColors.fromJson(Map<String, dynamic> json) {
    return PrimaryColors(
        color1: Color.fromRGBO(
            parseInt(json["responses"]["imagePropertiesAnnotation"]
                ["dominantColors"]["colors"][0]["color"]["red"]),
            parseInt(json["responses"]["imagePropertiesAnnotation"]
                ["dominantColors"]["colors"][0]["color"]["green"]),
            parseInt(json["responses"]["imagePropertiesAnnotation"]
                ["dominantColors"]["colors"][0]["color"]["blue"]),
            1.0));
  }
}

class RandImg {
  final String url;

  RandImg({this.url});

  factory RandImg.fromJson(Map<String, dynamic> json) {
    return RandImg(
      url: json["urls"]["raw"],
    );
  }
}

Future<RandImg> fetchImg() async {
  final response =
      await http.get("https://api.unsplash.com/photos/random", headers: {
    HttpHeaders.authorizationHeader:
        "Client-ID OC_8GFmPsPUtKdd9yZeKgYhXSZJ3BSBfmyIFUbLaoQ8"
  });

  if (response.statusCode == 200) {
    return RandImg.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Could not load Random Image");
  }
}

class RandomUnsplash extends StatefulWidget {
  @override
  _RandomUnsplashState createState() => _RandomUnsplashState();
}

class _RandomUnsplashState extends State<RandomUnsplash> {
  Future<RandImg> futureImg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          FutureBuilder<RandImg>(
            future: futureImg,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(fetchPalette(snapshot.data.url)[0]);
                return Image.network(snapshot.data.url);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return CircularProgressIndicator();
            },
          ),
          OutlinedButton(
            onPressed: () {
              futureImg = fetchImg();
              setState(() {});
            },
            child: Icon(Icons.refresh),
          )
        ],
      ),
    );
  }
}
