// ignore_for_file: non_constant_identifier_names

class AllVideosModal {
  String? title;
  String? videoUrl;
  String? imgUrl;
  String? description;
  AllVideosModal({this.title, this.videoUrl, this.imgUrl, this.description});
  @override
  String toString() {
    return "title :  $title , videoUrl : $videoUrl , , imgUrl : $imgUrl";
  }
}

List<AllVideosModal> all_videoList = [];
