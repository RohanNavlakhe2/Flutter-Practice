

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

 class MyHomePage extends StatefulWidget {

   @override
   _MyHomePageState createState() => _MyHomePageState();
 }

 class _MyHomePageState extends State<MyHomePage> {
  var _image;
  List<dynamic> _outputs;
  String _label = "Empty";
  @override
  void initState() {
    super.initState();
    loadModel();
  }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(),
       body: Center(
         child: Container(
           child: Column(
             children: [
               RaisedButton(onPressed: () => pickImage(),child: Text("Upload Image"),),
               SizedBox(height: 20,),
               _image !=null ? Image.file(_image,width: 200,height: 200,) : Text("No Image"),
               SizedBox(height: 20,),
               Text(_label)
             ],
           ),
         ),
       ),

     );
   }

   loadModel() async
   {
     String res = await Tflite.loadModel(
          model: "assets/flower_model.tflite",
          labels: "assets/labels.txt",
          numThreads: 1, // defaults to 1
          isAsset: true, // defaults to true, set to false to load resources outside assets
          useGpuDelegate: false // defaults to false, set to true to use GPU delegate
      );
   }

  pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      //_loading = true;
      _image = image;
    });
    classifyImage(image);
  }

  classifyImage(File image) async {

    //_image = (await rootBundle.load(image.path)).buffer.asUint8List();
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      //_loading = false;
      _outputs = output;
      _label = _outputs[0]['label'];
      print(output);
    });
  }
 }

