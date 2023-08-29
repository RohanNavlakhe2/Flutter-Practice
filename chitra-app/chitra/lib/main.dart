import 'package:chitra/bloc/image_bloc.dart';
import 'package:chitra/model/image_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'model/hits.dart';
import 'network/ui_state_notifier.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ImageHome());
  }
}

class ImageHome extends StatefulWidget {
  List<Hits> hits = List();

  @override
  _ImageHomeState createState() => _ImageHomeState();
}

class _ImageHomeState extends State<ImageHome> {
  ImageBloc _imageBloc = ImageBloc();
  Size _size;
  int currentPage = 1;
  bool showNextPageDataLoader = false;
  bool isFirstTimeLoad = true;
  TextEditingController _searchImagesController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: _size.width,
        height: _size.height,
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            controller: _searchImagesController,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey[900]),
                            decoration: InputDecoration(hintText: "Search Here", hintStyle: TextStyle(color: Colors.grey[900]), border: InputBorder.none),
                          ),
                          decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: loadSearchedImages,
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10))),
                              child: Center(
                                child: Text(
                                  "ok",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 12),
            Expanded(
                child: StreamBuilder<Response<ImageResponse>>(
              stream: _imageBloc.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.status == Status.COMPLETED) {
                    print("Image Tag: ${snapshot.data.data.hits[0].tags}");
                    if (isFirstTimeLoad) {
                      widget.hits.addAll(snapshot.data.data.hits);
                      isFirstTimeLoad = false;
                    }
                    return NotificationListener(
                        onNotification: _onNotification,
                        child: LayoutBuilder(builder: (context, constraints) {
                          bool isLargeDisplay = constraints.maxWidth > 700;
                          //int crossAxisCount = isLargeDisplay ? 3 : 2;
                          int crossAxisCount = 4;
                          return StaggeredGridView.countBuilder(
                            padding: const EdgeInsets.all(12.0),
                            crossAxisCount: 4,
                            mainAxisSpacing: 24,
                            crossAxisSpacing: 12,
                            itemCount: widget.hits.length,
                            itemBuilder: (BuildContext context, int index) =>
                               imageView(widget.hits[index]),
                            staggeredTileBuilder: (int index) => StaggeredTile.extent(2,index.isEven ? 300 : 400)
                          );
                        }));
                  } else if (snapshot.data.status == Status.LOADING) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Center(
                      child: Text(snapshot.data.message),
                    );
                  }
                } else {
                  return Center(
                    child: Text("No Data Found"),
                  );
                }
              },
            )),
            Container(
              height: showNextPageDataLoader ? 50.0 : 0,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget imageView(Hits hit) {
    //String imgUrl = kIsWeb ? hit.largeImageURL : hit.webformatURL;
    return Container(
      decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(hit.largeImageURL), fit: BoxFit.cover), borderRadius: BorderRadius.circular(5), color: Colors.grey[300]),
    );
  }

  void loadSearchedImages() {
    currentPage = 1;
    isFirstTimeLoad = true;
    widget.hits.clear();
    _imageBloc.getImages("&q=${_searchImagesController.text}");
  }

  bool _onNotification(ScrollNotification scrollNotification) {
    print("on Notification");
    if (!showNextPageDataLoader && scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent && currentPage <= (500 / 20)) {
      setState(() {
        showNextPageDataLoader = true;
      });
      currentPage++;

      print("Current Page: $currentPage");
      _imageBloc.getNextPageImages("&q=${_searchImagesController.text}&page=$currentPage").then((imageResponse) {
        setState(() {
          widget.hits.addAll(imageResponse.hits);
          showNextPageDataLoader = false;
        });
      });
    }
  }
}
