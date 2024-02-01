import 'package:uas_project/important/model.dart';

class PostResponse {
  List<PostModel> listRespons = [];

  PostResponse.fromJson(json) {
    for (int i = 0; i < json.length; i++) {
      PostModel model = PostModel.fromJson(json[i]);
      listRespons.add(model);
    }
  }
}
