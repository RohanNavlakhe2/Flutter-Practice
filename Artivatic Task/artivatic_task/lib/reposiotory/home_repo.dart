import 'package:artivatic_task/model/home_data.dart';
import 'package:artivatic_task/network/network_call.dart';

class HomeRepository{

  NetworkCall _networkCall = NetworkCall.networkCall;

  Future<HomeData> getHomeData() async {
    return await _networkCall.getHomeData();
  }

}