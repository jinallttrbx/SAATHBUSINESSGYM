import 'package:businessgym/model/AllFeedModel.dart';
import 'package:businessgym/values/const_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/ViewNewsModel.dart';
import '../../values/Colors.dart';

class NewsDetailScreen extends StatefulWidget {
  AllFeedModeldata? videos;
  NewsDetailScreen({Key? key, this.videos}) : super(key: key);

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BGColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "News Details",
          style: TextStyle(
              color: AppColors.black,
              fontFamily: "bold",
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.transparent,
              margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  "" + widget.videos!.thumbnailImage!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  width: 300,
                  child: Text(
                    textAlign: TextAlign.left,
                    "" + widget.videos!.title!,
                    style: const TextStyle(
                        color: AppColors.black,
                        fontFamily: "bold",
                        fontSize: 20,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: (){
                _openURL(widget.videos!.link??"");
                print( widget.videos!.link??"");

              },
              child:  Container(
                alignment: Alignment.centerLeft,
                margin:  EdgeInsets.only(top: 10, left: 30, right: 30),
                child: regulartext(AppColors.primary,15,
                  "" + widget.videos!.link!,
                ),
              ),
            ),
            const SizedBox(
              height: 150,
            ),
          ],
        ),
      ),

    );
  }

  Future <void> _openURL(String url) async{
    print(url);
    if(await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: true,
      );
    }
    else{
      throw 'Cant open URL';
    }
  }
}
