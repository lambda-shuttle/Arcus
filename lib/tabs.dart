import 'package:flutter/material.dart';
import './local_image_picker.dart';
import './favourites.dart';
<<<<<<< HEAD
import './random_unsplash.dart';
=======
import 'favourites.dart';
>>>>>>> ddb219543d456b65c148c703223c40e54ac7fd9a

class MainPage extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
                appBar: AppBar(
                    bottom: TabBar(
                        tabs: [
                          Tab(icon: Icon(Icons.camera_alt_rounded)),
                          Tab(icon: Icon(Icons.settings)),
                          Tab(icon: Icon(Icons.favorite)),
                        ]
                    ),
                    title: Text('Arcus')
                ),
                body: TabBarView (
                    children: [
                      LocalImagePicker(),
                      RandomUnsplash(),
                      Favourites(),
                    ]
                )
            )
        )
    );
  }
}