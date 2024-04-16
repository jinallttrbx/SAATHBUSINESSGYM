import 'dart:convert';
import 'dart:io';


import 'package:businessgym/Controller/userprofilecontroller.dart';
import 'package:businessgym/model/AllFeedModel.dart';

import 'package:businessgym/values/assets.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:businessgym/values/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../Utils/ApiUrl.dart';
import '../../Utils/common_route.dart';
import '../../model/GetVideosModel.dart';
import '../../model/videoCommentModel.dart';
import '../../values/Colors.dart';
import 'VideoPlayerScreen.dart';
import '../../conts/global_values.dart';
import 'package:http/http.dart' as http;


class VideosDetailScreen extends StatefulWidget {
  AllFeedModeldata? data;
  VideosDetailScreen({Key? key, this.data}) : super(key: key);

  @override
  State<VideosDetailScreen> createState() => _VideosDetailScreenState();
}

class _VideosDetailScreenState extends State<VideosDetailScreen> {
  dynamic totalcomments = [];
  bool isLoading = false;
  bool addcomment = false;
  List<VideoComment> totalComments = [];
  VideoPlayerController? _controller;
  final userprofile=Get.find<UserProfileController>();
  Future<void>? _initializeVideoPlayerFuture;
  late YoutubePlayerController _controllerr;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  addLike() async {
    showGetLoader();
    try {
      print(USERTOKKEN);
      print(widget.data!.id.toString());
      final response = await http.post(
        Uri.parse(ApiUrl.addLikeURL),
        headers: {
          'Authorization': '$USERTOKKEN',
        },
        body: {
          'video_id': widget.data!.id.toString(),
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        // showInSnackBar("you liked video");
      }
      hideLoader();
      sendPostRequest(widget.data!.id.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  addComment() async {
    showGetLoader();
    try {
      print(USERTOKKEN);
      print(widget.data!.id.toString());
      final response = await http.post(
        Uri.parse(ApiUrl.addcommentURL),
        headers: {
          'Authorization': '$USERTOKKEN',
        },
        body: {
          'video_id': widget.data!.id.toString(),
          'comment': msg.text,
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        // showInSnackBar("Commented successfuly");
      }
      hideLoader();
      setState(() {
        msg.clear();
        addcomment = false;
      });
      sendPostRequest(widget.data!.id.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  void sendPostRequest(
      String id,
      ) async {
    print("VIDEO ID PRINT $id");
    totalcomments = [];
    setState(() {
      isLoading = true;
    });
    try {
      // showGetLoader();
      final response = await http.post(
        Uri.parse(ApiUrl.videoComment),
        headers: {
          'Authorization': '$USERTOKKEN',
        },
        body: {
          'video_id': id,
        },
      );

      Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("PRINT VIDEO ID IN THIS SCREEN $id");
        List<VideoComment> commentList = [];
        totalComments = [];
        totalcomments = [];
        print(response.body);
        if (data["data"]["video_comment"] != null) {
          for (var i = 0; i < data["data"]["video_comment"].length; i++) {
            commentList.add(VideoComment(
              id: data["data"]["video_comment"][i]["id"]??"",
              userId: data["data"]["video_comment"][i]["user_id"]??"",
              videoId: data["data"]["video_comment"][i]["video_id"]??"",
              comment: data["data"]["video_comment"][i]["comment"]??"",
              createdAt: data["data"]["video_comment"][i]["created_at"]??0,
              updatedAt: data["data"]["video_comment"][i]["updated_at"]??0,
              profileImage: data["data"]["video_comment"][i]["profile_image"]??"",
              user: User(
                id: data["data"]["video_comment"][i]["user"]["id"]??"",
                username: data["data"]["video_comment"][i]["user"]["username"] ??"", media: [],
              ), ));
          }
          totalComments = commentList.reversed.toList();
        }
        setState(() {
          totalcomments = jsonDecode(response.body);
          isLoading = false;
        });
        // print(totalcomments);
        // Get.back();
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } on Exception catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e is SocketException) {
        // showInSnackBar("No Internet Access", color: Colors.red);
      }
      print(e.toString());
    }
  }

  PodPlayerController? controller;

  @override
  void initState() {
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(widget.data!.youtubeUrl!,
          videoPlayerOptions:
          VideoPlayerOptions(allowBackgroundPlayback: false)),
      podPlayerConfig: const PodPlayerConfig(
        wakelockEnabled: true,
        forcedVideoFocus: false,
        autoPlay: false,
        isLooping: false,
        videoQualityPriority: [720, 360],
      ),
    )..initialise();
    // TODO: implement initState
    super.initState();
    sendPostRequest(widget.data!.id.toString());
    userprofile.viewprofile();

    _controller = VideoPlayerController.network(
      '' + widget.data!.youtubeUrl!,
    );
    _initializeVideoPlayerFuture = _controller!.initialize();

    _controller!.setLooping(true);

    String? videoId;
    videoId = YoutubePlayer.convertUrlToId("" + widget.data!.youtubeUrl!);
    print(videoId);

    _controllerr = YoutubePlayerController(
      initialVideoId: "" + videoId!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );

    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  @override
  void dispose() {
    // _controller?.dispose();
    controller?.dispose();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    // ]);

    super.dispose();
  }

  final TextEditingController msg = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(USERTOKKEN);
    return WillPopScope(
      onWillPop: () async {
        controller?.dispose();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                controller?.dispose();
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.white,
          flexibleSpace: Container(

          ),
          title: boldtext(AppColors.DarkBlue, 18, "Videos Details"),
          centerTitle: true,
        ),
        // APPBar(title: "Videos Details"),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.transparent,
                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child:
                  // PodVideoPlayer(
                  //   controller: controller!,
                  // ),
                  Stack(children: [
                    Image.network(
                      "" + widget.data!.thumbnailImage!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 90,
                      left: 180,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPlayerScreen(
                                video_urle: widget.data!.youtubeUrl,
                              ),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          child: Icon(Icons.play_arrow),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              vertical(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: boldtext(AppColors.black, 18,
                  widget.data!.videoTital.toString(),
                ),
              ),
              vertical(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: regulartext(AppColors.blackShade4, 12,
                  widget.data!.videoShortDescription!.toString(),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            addLike();
                          },
                          child:  Container(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            height: 33,
                            width: 75,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.primary,width: 1),
                                borderRadius: BorderRadius.all(Radius.circular(17),)
                            ),
                            child: Row(
                              children: [

                                SvgPicture.asset(AppImages.like,color: AppColors.primary,),


                                horizental(10),
                                boldtext(AppColors.black, 13,
                                    "${totalcomments["video_like"]}"),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              addcomment=true;
                            });
                          },
                          child:  Container(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            height: 33,
                            width: 75,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.primary,width: 1),
                                borderRadius: BorderRadius.all(Radius.circular(17),)
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(AppImages.comment,color: AppColors.primary,),
                                horizental(10),
                                boldtext(AppColors.black, 13,
                                    "${totalComments.length ?? ""}"),
                              ],
                            ),
                          ),
                        ),

                        horizental(30),
                        Row(
                          children: [
                            SvgPicture.asset(AppImages.time,height: 20,),
                            SizedBox(width: 5,),
                            Text( widget.data!.videoDuration.toString()),

                          ],
                        )
                        // boldtext(AppColors.black, 13,
                        //     "Views  ${totalcomments["video_view"]}"),
                      ],
                    ),

                    vertical(10),
                    Container(
                      color: AppColors.hint,
                      height: 1,
                      width: double.infinity,
                    ),
                    vertical(10),
                    vertical(10),
                  ],
                ),
              ),
              addcomment
                  ? Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 0,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                NetworkImage( userprofile.productprofilelist?.profileImage??"",),
                              ),
                            ),),
                          SizedBox(width: 10,),
                          Expanded(
                            flex: 5,
                            child:   TextFormField(

                              textAlign : TextAlign.start,
                              controller: msg,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10,right: 10),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(30.0),
                                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:  BorderRadius.circular(30.0),
                                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                                  ),
                                  hintText: "Enter Comment",
                                  hintStyle:   TextStyle(
                                    color: AppColors.black.withOpacity(0.5),
                                    fontSize: 14,
                                    fontFamily: "OpenSans",
                                    fontWeight: FontWeight.w600,
                                  ),suffixIcon: GestureDetector(
                                onTap: (){
                                  if (msg.text.isEmpty) {
                                    // showInSnackBar(
                                    //     "Please Add Text In Comment",
                                    //     color: AppColors.red);
                                  } else {
                                    addComment();
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: CircleAvatar(
                                    radius: 20,
                                    child: SvgPicture.asset(AppImages.send),

                                  ),
                                ),
                              )


                              ),
                            ),),
                          SizedBox(width: 10,),

                        ],
                      )
                  ),
                  // ButtonMain(
                  //     ontap: () {
                  //     },
                  //     text: "Add Comment",
                  //     width: 0.5,
                  //     loader: false)
                ],
              )
                  : const SizedBox(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(left: 20),child:  boldtext(AppColors.black, 16, "Comments"),),
                  ListView.builder(
                    controller: ScrollController(),
                    itemCount: totalComments.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Row(
                              children: [
                                CircleAvatar(
                                  radius: 20.0,
                                  backgroundImage: NetworkImage(totalComments[index].profileImage.toString()),
                                  backgroundColor: Colors.transparent,
                                ),
                                horizental(10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    boldtext(AppColors.black, 13,
                                        totalComments[index].user.username.toString()),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0),
                                      child: boldtext(AppColors.blackShade4, 12,
                                          totalComments[index].comment.toString()),
                                    ),
                                  ],
                                )
                              ],
                            ),

                          ),

                        ],
                      );
                    },
                  ),


                ],
              ),

              vertical(100),
            ],
          ),
        ),

      ),
    );
  }
  Widget textAreasearch(TextEditingController controller, String hint,
      {double? width}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 0),
          child: TextField(
            onTap: () async {
            },
            controller: controller,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 15,right: 15,bottom: 5,top: 5),
                focusedBorder: OutlineInputBorder(
                  borderRadius:  BorderRadius.circular(30.0),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius:  BorderRadius.circular(30.0),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
                filled: true,
                border: InputBorder.none,
                fillColor:  Colors.white,
                hintText: hint,
                suffix:  TextButton(
                    onPressed: () {
                      if (msg.text.isEmpty) {
                        // showInSnackBar(
                        //     "Please Add Text In Comment",
                        //     color: AppColors.red);
                      } else {
                        addComment();
                      }
                    },
                    child: Container(
                        color: AppColors.primary,
                        child:
                        SvgPicture.asset(AppImages.send)
                    ))

            ),
          ),
        ),
      ],
    );
  }

  Widget textArea(TextEditingController controller, String hint, {double? width}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: TextField(
            textCapitalization: TextCapitalization.words,
            controller: controller,
            keyboardType:  TextInputType.text,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(0),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              ),
              filled: true,
              border: InputBorder.none,
              fillColor: AppColors.textfieldcolor,
              hintText: hint,
            ),
          ),
        ),
      ],
    );
  }


}
