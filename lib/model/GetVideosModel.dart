// ignore_for_file: file_names

class GetVideosModel {
  String? message;
  bool? status;
  int? pendingVideo;
  List<Data>? data;
  List<Videos>? featuredVideos;
  List<Videos>? resentVideos;

  GetVideosModel(
      {this.message,
      this.status,
      this.data,
      this.featuredVideos,
      this.resentVideos,
      this.pendingVideo});

  GetVideosModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    if (json['featured_videos'] != null) {
      featuredVideos = <Videos>[];
      json['featured_videos'].forEach((v) {
        featuredVideos!.add(Videos.fromJson(v));
      });
    }
    if (json['resent_videos'] != null) {
      resentVideos = <Videos>[];
      json['resent_videos'].forEach((v) {
        resentVideos!.add(Videos.fromJson(v));
      });
    }
    pendingVideo = json['pending_video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (featuredVideos != null) {
      data['featured_videos'] = featuredVideos!.map((v) => v.toJson()).toList();
    }
    if (resentVideos != null) {
      data['resent_videos'] = resentVideos!.map((v) => v.toJson()).toList();
    }
    data['pending_video'] = pendingVideo;
    return data;
  }
}

class Data {
  String? title;
  int? id;

  List<Videos>? videos;

  Data({this.title, this.id, this.videos});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];

    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(Videos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['id'] = id;

    if (videos != null) {
      data['videos'] = videos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Videos {
  int? vid;
  String? videoTital;
  String? videoShortDescription;
  String? videoType;
  String? youtubeUrl;
  String? videoDuration;
  List<String>? viewType;
  int? orderNumber;
  int? totalLikes;
  int? totalComment;
  int? videoStatus;
  String? image;
  String? localVideo;

  Videos(
      {this.vid,
      this.videoTital,
      this.videoShortDescription,
      this.videoType,
      this.youtubeUrl,
      this.videoDuration,
      this.viewType,
      this.orderNumber,
      this.totalLikes,
      this.totalComment,
      this.videoStatus,
      this.image,
      this.localVideo});

  Videos.fromJson(Map<String, dynamic> json) {
    vid = json['vid'];
    videoTital = json['video_tital'];
    videoShortDescription = json['video_short_description'];
    videoType = json['video_type'];
    youtubeUrl = json['youtube_url'];
    videoDuration = json['video_duration'];
    viewType = json['view_type'].cast<String>();
    orderNumber = json['order_number'];
    totalLikes = json['total_likes'];
    totalComment = json['total_comments'];
    videoStatus = json['video_status'];
    image = json['image'];
    localVideo = json['local_video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vid'] = vid;
    data['video_tital'] = videoTital;
    data['video_short_description'] = videoShortDescription;
    data['video_type'] = videoType;
    data['youtube_url'] = youtubeUrl;
    data['video_duration'] = videoDuration;
    data['view_type'] = viewType;
    data['order_number'] = orderNumber;
    data['total_likes'] = totalLikes;
    data['total_comments'] = totalComment;
    data['video_status'] = videoStatus;
    data['image'] = image;
    data['local_video'] = localVideo;
    return data;
  }
}
