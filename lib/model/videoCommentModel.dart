// // class VideoCommentModel {
//
// class VideoCommentModel {
//   final int? videoLike;
//   final int? videoComment;
//   final int? like;
//   final bool? status;
//   final Data? data;
//   final String? message;
//
//   VideoCommentModel({
//     this.videoLike,
//     this.videoComment,
//     this.like,
//     this.status,
//     this.data,
//     this.message,
//   });
//
//   VideoCommentModel.fromJson(Map<String, dynamic> json)
//       : videoLike = json['video_like'] as int?,
//         videoComment = json['video_comment'] as int?,
//         like = json['like'] as int?,
//         status = json['status'] as bool?,
//         data = (json['data'] as Map<String, dynamic>?) != null
//             ? Data.fromJson(json['data'] as Map<String, dynamic>)
//             : null,
//         message = json['message'] as String?;
//
//   Map<String, dynamic> toJson() => {
//         'video_like': videoLike,
//         'video_comment': videoComment,
//         'like': like,
//         'status': status,
//         'data': data?.toJson(),
//         'message': message
//       };
// }
//
// class Data {
//   final int? id;
//   final int? categoryId;
//   final String? videoTital;
//   final String? videoShortDescription;
//   final String? videoDuration;
//   final String? videoType;
//   final String? youtubeUrl;
//   final String? viewType;
//   final int? orderNumber;
//   final int? videoStatus;
//   final int? isFeatured;
//   final dynamic deletedAt;
//   final String? createdAt;
//   final String? updatedAt;
//   final Category? category;
//   final VideoLike? videoLike;
//   final List<VideoComment>? videoComment;
//
//   Data({
//     this.id,
//     this.categoryId,
//     this.videoTital,
//     this.videoShortDescription,
//     this.videoDuration,
//     this.videoType,
//     this.youtubeUrl,
//     this.viewType,
//     this.orderNumber,
//     this.videoStatus,
//     this.isFeatured,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//     this.category,
//     this.videoLike,
//     this.videoComment,
//   });
//
//   Data.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         categoryId = json['category_id'] as int?,
//         videoTital = json['video_tital'] as String?,
//         videoShortDescription = json['video_short_description'] as String?,
//         videoDuration = json['video_duration'] as String?,
//         videoType = json['video_type'] as String?,
//         youtubeUrl = json['youtube_url'] as String?,
//         viewType = json['view_type'] as String?,
//         orderNumber = json['order_number'] as int?,
//         videoStatus = json['video_status'] as int?,
//         isFeatured = json['is_featured'] as int?,
//         deletedAt = json['deleted_at'],
//         createdAt = json['created_at'] as String?,
//         updatedAt = json['updated_at'] as String?,
//         category = (json['category'] as Map<String, dynamic>?) != null
//             ? Category.fromJson(json['category'] as Map<String, dynamic>)
//             : null,
//         videoLike = (json['video_like'] as Map<String, dynamic>?) != null
//             ? VideoLike.fromJson(json['video_like'] as Map<String, dynamic>)
//             : null,
//         videoComment = (json['video_comment'] as List?)
//             ?.map(
//                 (dynamic e) => VideoComment.fromJson(e as Map<String, dynamic>))
//             .toList();
//
//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'category_id': categoryId,
//         'video_tital': videoTital,
//         'video_short_description': videoShortDescription,
//         'video_duration': videoDuration,
//         'video_type': videoType,
//         'youtube_url': youtubeUrl,
//         'view_type': viewType,
//         'order_number': orderNumber,
//         'video_status': videoStatus,
//         'is_featured': isFeatured,
//         'deleted_at': deletedAt,
//         'created_at': createdAt,
//         'updated_at': updatedAt,
//         'category': category?.toJson(),
//         'video_like': videoLike?.toJson(),
//         'video_comment': videoComment?.map((e) => e.toJson()).toList()
//       };
// }
//
// class Category {
//   final int? id;
//   final String? title;
//   final int? orderNumber;
//   final dynamic deletedAt;
//   final String? createdAt;
//   final String? updatedAt;
//
//   Category({
//     this.id,
//     this.title,
//     this.orderNumber,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   Category.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         title = json['title'] as String?,
//         orderNumber = json['order_number'] as int?,
//         deletedAt = json['deleted_at'],
//         createdAt = json['created_at'] as String?,
//         updatedAt = json['updated_at'] as String?;
//
//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'title': title,
//         'order_number': orderNumber,
//         'deleted_at': deletedAt,
//         'created_at': createdAt,
//         'updated_at': updatedAt
//       };
// }
//
// class VideoLike {
//   final int? id;
//   final int? userId;
//   final int? videoId;
//   final String? createdAt;
//   final String? updatedAt;
//
//   VideoLike({
//     this.id,
//     this.userId,
//     this.videoId,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   VideoLike.fromJson(Map<String, dynamic> json)
//       : id = json['id'] as int?,
//         userId = json['user_id'] as int?,
//         videoId = json['video_id'] as int?,
//         createdAt = json['created_at'] as String?,
//         updatedAt = json['updated_at'] as String?;
//
//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'user_id': userId,
//         'video_id': videoId,
//         'created_at': createdAt,
//         'updated_at': updatedAt
//       };
// }
//
// // class VideoComment {
// //   final int? id;
// //   final int? userId;
// //   final int? videoId;
// //   final String? comment;
// //   final String? createdAt;
// //   final String? updatedAt;
// //   final String? userName;
//
// //   VideoComment({
// //     this.id,
// //     this.userId,
// //     this.videoId,
// //     this.comment,
// //     this.createdAt,
// //     this.updatedAt,
// //     this.userName
// //   });
//
// //   VideoComment.fromJson(Map<String, dynamic> json)
// //       : id = json['id'] as int?,
// //         userId = json['user_id'] as int?,
// //         videoId = json['video_id'] as int?,
// //         comment = json['comment'] as String?,
// //         createdAt = json['created_at'] as String?,
// //         updatedAt = json['updated_at'] as String?;
// //         userName = json['updated_at'] as String?;
//
// //   Map<String, dynamic> toJson() => {
// //         'id': id,
// //         'user_id': userId,
// //         'video_id': videoId,
// //         'comment': comment,
// //         'created_at': createdAt,
// //         'updated_at': updatedAt
// //       };
// // }
//
// class VideoComment {
//   VideoComment({
//     required this.id,
//     required this.userId,
//     required this.videoId,
//     required this.comment,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.user,
//   });
//   late final int id;
//   late final int userId;
//   late final int videoId;
//   late final String comment;
//   late final String createdAt;
//   late final String updatedAt;
//   late final User user;
//
//   VideoComment.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     videoId = json['video_id'];
//     comment = json['comment'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     user = User.fromJson(json['user']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['user_id'] = userId;
//     _data['video_id'] = videoId;
//     _data['comment'] = comment;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     _data['user'] = user.toJson();
//     return _data;
//   }
// }
//
// class User {
//   User({
//     required this.id,
//     required this.username,
//
//   });
//   late final int id;
//   late final String username;
//
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     username = json['username'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['username'] = username;
//     return _data;
//   }
// }
class VideoCommentModel {
  VideoCommentModel({
    required this.totalComment,
    required this.like,
    required this.videoLike,
    required this.videoView,
    required this.status,
    required this.data,
    required this.message,
  });
  late final int totalComment;
  late final int like;
  late final int videoLike;
  late final String videoView;
  late final bool status;
  late final Data data;
  late final String message;

  VideoCommentModel.fromJson(Map<String, dynamic> json){
    totalComment = json['total_comment'];
    like = json['like'];
    videoLike = json['video_like'];
    videoView = json['video_view'];
    status = json['status'];
    data = Data.fromJson(json['data']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['total_comment'] = totalComment;
    _data['like'] = like;
    _data['video_like'] = videoLike;
    _data['video_view'] = videoView;
    _data['status'] = status;
    _data['data'] = data.toJson();
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.categoryId,
    required this.videoTital,
    required this.videoShortDescription,
    required this.videoDuration,
    required this.videoType,
    required this.youtubeUrl,
    required this.viewType,
    required this.orderNumber,
    required this.videoStatus,
    required this.isFeatured,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.videoComment,
  });
  late final int id;
  late final int categoryId;
  late final String videoTital;
  late final String videoShortDescription;
  late final String videoDuration;
  late final String videoType;
  late final String youtubeUrl;
  late final String viewType;
  late final int orderNumber;
  late final int videoStatus;
  late final int isFeatured;
  late final Null deletedAt;
  late final String createdAt;
  late final String updatedAt;
  late final Category category;
  late final List<VideoComment> videoComment;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    categoryId = json['category_id'];
    videoTital = json['video_tital'];
    videoShortDescription = json['video_short_description'];
    videoDuration = json['video_duration'];
    videoType = json['video_type'];
    youtubeUrl = json['youtube_url'];
    viewType = json['view_type'];
    orderNumber = json['order_number'];
    videoStatus = json['video_status'];
    isFeatured = json['is_featured'];
    deletedAt = null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = Category.fromJson(json['category']);
    videoComment = List.from(json['video_comment']).map((e)=>VideoComment.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['category_id'] = categoryId;
    _data['video_tital'] = videoTital;
    _data['video_short_description'] = videoShortDescription;
    _data['video_duration'] = videoDuration;
    _data['video_type'] = videoType;
    _data['youtube_url'] = youtubeUrl;
    _data['view_type'] = viewType;
    _data['order_number'] = orderNumber;
    _data['video_status'] = videoStatus;
    _data['is_featured'] = isFeatured;
    _data['deleted_at'] = deletedAt;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['category'] = category.toJson();
    _data['video_comment'] = videoComment.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Category {
  Category({
    required this.id,
    required this.title,
    required this.orderNumber,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String title;
  late final int orderNumber;
  late final Null deletedAt;
  late final String createdAt;
  late final String updatedAt;

  Category.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    orderNumber = json['order_number'];
    deletedAt = null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['order_number'] = orderNumber;
    _data['deleted_at'] = deletedAt;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

class VideoComment {
  VideoComment({
    required this.id,
    required this.userId,
    required this.videoId,
    this.comment,
    required this.createdAt,
    required this.updatedAt,
    required this.profileImage,
    required this.user,
  });
  late final int id;
  late final int userId;
  late final int videoId;
  late final String? comment;
  late final String createdAt;
  late final String updatedAt;
  late final String profileImage;
  late final User user;

  VideoComment.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    videoId = json['video_id'];
    comment = null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profileImage = json['profile_image'];
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['video_id'] = videoId;
    _data['comment'] = comment;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['profile_image'] = profileImage;
    _data['user'] = user.toJson();
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.username,
    required this.media,
  });
  late final int id;
  late final String username;
  late final List<Media> media;

  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    username = json['username'];
    media = List.from(json['media']).map((e)=>Media.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['username'] = username;
    _data['media'] = media.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Media {
  Media({
    required this.id,
    required this.modelType,
    required this.modelId,
    required this.uuid,
    required this.collectionName,
    required this.name,
    required this.fileName,
    required this.mimeType,
    required this.disk,
    required this.conversionsDisk,
    required this.size,
    required this.manipulations,
    required this.customProperties,
    required this.generatedConversions,
    required this.responsiveImages,
    required this.orderColumn,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String modelType;
  late final int modelId;
  late final String uuid;
  late final String collectionName;
  late final String name;
  late final String fileName;
  late final String mimeType;
  late final String disk;
  late final String conversionsDisk;
  late final int size;
  late final List<dynamic> manipulations;
  late final List<dynamic> customProperties;
  late final List<dynamic> generatedConversions;
  late final List<dynamic> responsiveImages;
  late final int orderColumn;
  late final String createdAt;
  late final String updatedAt;

  Media.fromJson(Map<String, dynamic> json){
    id = json['id'];
    modelType = json['model_type'];
    modelId = json['model_id'];
    uuid = json['uuid'];
    collectionName = json['collection_name'];
    name = json['name'];
    fileName = json['file_name'];
    mimeType = json['mime_type'];
    disk = json['disk'];
    conversionsDisk = json['conversions_disk'];
    size = json['size'];
    manipulations = List.castFrom<dynamic, dynamic>(json['manipulations']);
    customProperties = List.castFrom<dynamic, dynamic>(json['custom_properties']);
    generatedConversions = List.castFrom<dynamic, dynamic>(json['generated_conversions']);
    responsiveImages = List.castFrom<dynamic, dynamic>(json['responsive_images']);
    orderColumn = json['order_column'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['model_type'] = modelType;
    _data['model_id'] = modelId;
    _data['uuid'] = uuid;
    _data['collection_name'] = collectionName;
    _data['name'] = name;
    _data['file_name'] = fileName;
    _data['mime_type'] = mimeType;
    _data['disk'] = disk;
    _data['conversions_disk'] = conversionsDisk;
    _data['size'] = size;
    _data['manipulations'] = manipulations;
    _data['custom_properties'] = customProperties;
    _data['generated_conversions'] = generatedConversions;
    _data['responsive_images'] = responsiveImages;
    _data['order_column'] = orderColumn;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}