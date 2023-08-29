
class Hits {

  int id;
  String pageURL;
  String type;
  String tags;
  String previewURL;
  int previewWidth;
  int previewHeight;
  String webformatURL;
  int webformatWidth;
  int webformatHeight;
  String largeImageURL;
  int imageWidth;
  int imageHeight;
  int imageSize;
  int views;
  int downloads;
  int favorites;
  int likes;
  int comments;
  int user_id;
  String user;
  String userImageURL;

	Hits.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		pageURL = map["pageURL"],
		type = map["type"],
		tags = map["tags"],
		previewURL = map["previewURL"],
		previewWidth = map["previewWidth"],
		previewHeight = map["previewHeight"],
		webformatURL = map["webformatURL"],
		webformatWidth = map["webformatWidth"],
		webformatHeight = map["webformatHeight"],
		largeImageURL = map["largeImageURL"],
		imageWidth = map["imageWidth"],
		imageHeight = map["imageHeight"],
		imageSize = map["imageSize"],
		views = map["views"],
		downloads = map["downloads"],
		favorites = map["favorites"],
		likes = map["likes"],
		comments = map["comments"],
		user_id = map["user_id"],
		user = map["user"],
		userImageURL = map["userImageURL"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['pageURL'] = pageURL;
		data['type'] = type;
		data['tags'] = tags;
		data['previewURL'] = previewURL;
		data['previewWidth'] = previewWidth;
		data['previewHeight'] = previewHeight;
		data['webformatURL'] = webformatURL;
		data['webformatWidth'] = webformatWidth;
		data['webformatHeight'] = webformatHeight;
		data['largeImageURL'] = largeImageURL;
		data['imageWidth'] = imageWidth;
		data['imageHeight'] = imageHeight;
		data['imageSize'] = imageSize;
		data['views'] = views;
		data['downloads'] = downloads;
		data['favorites'] = favorites;
		data['likes'] = likes;
		data['comments'] = comments;
		data['user_id'] = user_id;
		data['user'] = user;
		data['userImageURL'] = userImageURL;
		return data;
	}
}
