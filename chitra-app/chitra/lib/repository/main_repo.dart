import 'package:chitra/model/image_response.dart';
import 'package:chitra/network/network_call.dart';
import 'package:chitra/network/ui_state_notifier.dart';

class MainRepo{
  NetworkCall _networkCall = NetworkCall.networkCall;

  Future<ImageResponse> getImages(String imageQuery){
     return _networkCall.getImages(imageQuery);
  }
}