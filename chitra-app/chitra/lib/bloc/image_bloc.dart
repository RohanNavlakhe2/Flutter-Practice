import 'dart:async';

import 'package:chitra/constants.dart';
import 'package:chitra/model/hits.dart';
import 'package:chitra/model/image_response.dart';
import 'package:chitra/network/custom_exception.dart';
import 'package:chitra/network/ui_state_notifier.dart';
import 'package:chitra/repository/main_repo.dart';

class ImageBloc {
  MainRepo _mainRepo = MainRepo();
  StreamController<Response<ImageResponse>> _streamController;
  StreamSink<Response<ImageResponse>> _streamSink;
  Stream<Response<ImageResponse>> stream;

  ImageBloc() {
    _streamController = StreamController();
    _streamSink = _streamController.sink;
    stream = _streamController.stream;
    getImages("");
  }

  void getImages(String imageQuery) {
    //loadingType can be "paginate" or "page_load"
    _streamSink.add(Response.loading("loading"));
    try{
      _mainRepo.getImages(imageQuery).then((value) {
        _streamSink.add(Response.completed(value));
      });
    }catch(ex){
      _streamSink.add(Response.error(ex.message));
    }

  }

   Future<ImageResponse> getNextPageImages(String imageQuery) async {
    return await _mainRepo.getImages(imageQuery);
  }

  dispose() { _streamController.close();}
}
