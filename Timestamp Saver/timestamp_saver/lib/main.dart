import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timestamp_saver/db/db_helper.dart';
import 'package:timestamp_saver/db/timestamp_model.dart';

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

 class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
   DBHelper _dbHelper;
   List<TimeStampModel> timeStampList;

   @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _dbHelper = DBHelper();
  }

   @override
   void dispose() {
     WidgetsBinding.instance.removeObserver(this);
     super.dispose();
   }

   @override
   void didChangeAppLifecycleState(AppLifecycleState state) {
     print('state = $state');
     if(state == AppLifecycleState.resumed)
       {
         //start listening to the Event Channel again
         if(Platform.isAndroid){
           var eventChannel = EventChannel("com.example.timestamp_saver");
           eventChannel.receiveBroadcastStream("Just Listen").listen((event) async {
             debugPrint(event);
             TimeStampModel timeStamp = TimeStampModel(id: null,timestamp: event);
           });
         }
       }

   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
         appBar: AppBar(),
         body: Container(
           child: Column(
             children: [
               RaisedButton(
                 onPressed: (){startServiceAndReceiveUpdatea();},
                 child: Text("Start"),
               ),
               SizedBox(height: 20,),
               RaisedButton(
                 onPressed: (){listenData();},
                 child: Text("Listen"),
               ),
               Expanded(
                   child: FutureBuilder<List<TimeStampModel>>(
                       future: _dbHelper.getTimeStampModels(),
                       builder: (context, snapshot) {
                          if(snapshot.hasData)
                            {
                              timeStampList = snapshot.data;
                              return ListView.builder(
                                   itemCount: timeStampList.length,
                                  itemBuilder: (context, index) => ListTile(
                                    title: Text(timeStampList[index].timestamp),
                                  ),
                              );
                            }else if(snapshot.hasError)
                            return Center(child: Text("Error"),);
                          else
                            return Center(child: CircularProgressIndicator(),);
                       },
                   )
               )
             ],
           ),
         )
     );
   }

   /*void startServiceInPlatform() async {
     if(Platform.isAndroid){
       var methodChannel = MethodChannel("com.example.timestamp_saver");
        String data = await methodChannel.invokeMethod("startService");
       debugPrint(data);
     }
   }*/

   void startServiceAndReceiveUpdatea() async
   {
     if(Platform.isAndroid){
       var eventChannel = EventChannel("com.example.timestamp_saver");
       eventChannel.receiveBroadcastStream("startService").listen((event) async {
         debugPrint("Listner called in dart");
         debugPrint(event);
         TimeStampModel timeStamp = TimeStampModel(id: null,timestamp: event);
         //await _dbHelper.save(timeStamp);
         setState(() {

         });
         /*_dbHelper.getTimeStampModels().then((timeStampList) {
             setState(() {
               this.timeStampList = timeStampList;
             });
         });*/
       });
     }
   }

   void listenData() async
   {
     if(Platform.isAndroid){
       var eventChannel = EventChannel("com.example.timestamp_saver");
       eventChannel.receiveBroadcastStream("Just Listen").listen((event) async {
         debugPrint("Inside Listen Data");
         debugPrint(event);
         TimeStampModel timeStamp = TimeStampModel(id: null,timestamp: event);
         //await _dbHelper.save(timeStamp);
         setState(() {

         });

       });
     }
   }


}



