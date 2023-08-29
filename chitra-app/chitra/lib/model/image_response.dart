import 'package:chitra/model/hits.dart';

class ImageResponse {

  int total;
  int totalHits;
  List<Hits> hits;

	ImageResponse.fromJsonMap(Map<String, dynamic> map): 
		total = map["total"],
		totalHits = map["totalHits"],
		hits = List<Hits>.from(map["hits"].map((it) => Hits.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['total'] = total;
		data['totalHits'] = totalHits;
		data['hits'] = hits != null ? 
			this.hits.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
