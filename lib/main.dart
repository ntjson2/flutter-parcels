// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(TheApp());
}

class changingBox extends StatefulWidget {
  final int gridIndex;
  changingBox(this.gridIndex);

  @override
  State<StatefulWidget> createState() => ChangingBoxState();
}

class ChangingBoxState extends State<changingBox> {
  int gridIndex = 0;
  String imageData = 'holder';

  int? updateResourceCounter() {
    TheApp? app = context.findAncestorWidgetOfExactType<TheApp>();
    app?.resourceCounter++;
    print('Resource counter: ${app?.resourceCounter}');
    return app?.resourceCounter;
  }

  void updateImageData(String data) {
    imageData = data;
  }

  String getUpdatedImageData() {
    return imageData;
  }

  void imageGetReq() {
    // 1 based index
    gridIndex = widget.gridIndex.toInt() + 1;

    int? resourceLimit = updateResourceCounter();

    if (resourceLimit! > 3) {
      print('Resource limit reached');
      // Add alert functionality here
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Resource Limit Reached'),
            content: Text(
                'You have reached the resource limit. Please try again by refreshing the page.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    var res = http.get(
      Uri.parse('https://parceldata-wrq3uwlj6a-uc.a.run.app/?index=$gridIndex'),
      // Uri.parse('http://localhost:5000/njflutter-01/us-central1/parcelData?index=$gridIndex'),
    );

    res.then((value) {
      var data = jsonDecode(value.body);
      /*  Data JSON format: {"1": ["imagename1"], "2": ["imagename2"]} */
      print(data[0]);

      // Check for data
      if (data.isNotEmpty) {
        var imageData = data[0];
        // Set the new image data state
        setState(() {
          updateImageData(imageData);
        });

        if (data.length == 2 && data[1] == 1) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Gold Vein Found!'),
                content: Text(
                    'You have located a gold vein.\n Please contact the mine owner to claim your reward. \n Notice the gold vein white coloring and visible native gold in the prospect you have chosen.'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
          return;
        }

        print("AFTER image URL: $imageData \n gridIndex: $gridIndex");
      } else {
        print('Invalid data format');
      }
    });
  }

  void _handleTap() {
    setState(() {
      imageGetReq();
      imageData = getUpdatedImageData();
    });
  }

  Future<ImageProvider> getImageFromUrl(String imageData) async {
    String imagePath = 'assets/images/$imageData.jpg';
    return AssetImage(imagePath);
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        width: 200,
        height: 100,
        /* decoration: BoxDecoration(
            color: _active ? Colors.lightGreen[700] : Colors.grey[600],
          ), */
        child: Center(
          child: FutureBuilder(
            future: getImageFromUrl(imageData),
            builder:
                (BuildContext context, AsyncSnapshot<ImageProvider> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Container(
                    width: 200,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: snapshot.data!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}

class TheApp extends StatelessWidget {
  @override
  int resourceCounter = 0;

  Widget build(BuildContext context) {
    return (MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 62, 62, 62),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              color: const Color.fromARGB(255, 123, 123, 123),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    'Parcel Data Viewer - Mine parcels',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 244, 231, 204),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 5,
              color: Color.fromARGB(255, 255, 199, 79),
            ),
            Container(
              height: 20,
              child: Text(
                'Click on the boxes to view parcel data. You can view a maximum of 3 parcels before the resource limit is reached. To start over refresh the page.',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 244, 231, 204),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 5),
                constraints: BoxConstraints(maxWidth: 800),
                child: GridView.count(
                  crossAxisCount: 4,
                  childAspectRatio: 2,
                  children: List.generate(16, (gridIndex) {
                    return Container(
                      height: 100,
                      width: 200,
                      constraints: BoxConstraints(maxWidth: 200),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 59, 59, 59),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: changingBox(gridIndex),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}





/* class TextBox extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();

    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    final text = myController.text;
    print("second $text (${text.characters.length})");
    var res = http.get(Uri.parse(
        'http://localhost:5000/cs-322-0/us-central1/helloWorld?number=${text}'));
    res.then((value) => print(value.body));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value) {
            print("first $value (${value.characters.length})");
          },
        ),
        TextField(
          controller: myController,
        ),
      ],
    );
  }
} */