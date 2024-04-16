import 'package:flutter/material.dart';

class LoaderPage extends StatefulWidget {
  const LoaderPage({super.key});

  @override
  AddPromptPageState createState() => AddPromptPageState();
}

class AddPromptPageState extends State<LoaderPage> {
  TextEditingController nameAlbumController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return animatedDialogueWithTextFieldAndButton(context);
  }

  Widget appBar() {
    return SizedBox(
      height: 45,
      child: Material(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 16),
              width: 32,
              height: 32,
            ),
          ],
        ),
      ),
    );
  }

  animatedDialogueWithTextFieldAndButton(context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 24, bottom: 24),
              child: Column(
                children: <Widget>[
                  const CircularProgressIndicator(),
                  Container(
                    width: 0,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
