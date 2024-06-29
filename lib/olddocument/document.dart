// // // import 'package:flutter/material.dart';
// // //
// // // void main() {
// // //   runApp(MyApp());
// // // }
// // //
// // // class MyApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       title: 'GST Number Validator',
// // //       theme: ThemeData(
// // //         primarySwatch: Colors.blue,
// // //       ),
// // //       home: GSTValidator(),
// // //     );
// // //   }
// // // }
// // //
// // // class GSTValidator extends StatefulWidget {
// // //   @override
// // //   _GSTValidatorState createState() => _GSTValidatorState();
// // // }
// // //
// // // class _GSTValidatorState extends State<GSTValidator> {
// // //   TextEditingController gstController = TextEditingController();
// // //   bool isValid = false;
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('GST Number Validator'),
// // //       ),
// // //       body: Center(
// // //         child: Column(
// // //           mainAxisAlignment: MainAxisAlignment.center,
// // //           children: <Widget>[
// // //             Padding(
// // //               padding: EdgeInsets.all(20.0),
// // //               child: TextField(
// // //                 controller: gstController,
// // //                 decoration: InputDecoration(
// // //                   labelText: 'Enter GST Number',
// // //                 ),
// // //               ),
// // //             ),
// // //             ElevatedButton(
// // //               onPressed: () {
// // //                 setState(() {
// // //                   isValid = validateGST(gstController.text);
// // //                 });
// // //               },
// // //               child: Text('Validate'),
// // //             ),
// // //             SizedBox(height: 20.0),
// // //             Text(
// // //               isValid ? 'Valid GST Number' : 'Invalid GST Number',
// // //               style: TextStyle(
// // //                 fontSize: 20.0,
// // //                 fontWeight: FontWeight.bold,
// // //                 color: isValid ? Colors.green : Colors.red,
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   bool validateGST(String gst) {
// // //     // Regular expression for Indian GST number
// // //     RegExp regex = RegExp(
// // //         r"^\d{2}[A-Z]{5}\d{4}[A-Z]{1}\d[Z]{1}[A-Z\d]{1}$");
// // //
// // //     return regex.hasMatch(gst);
// // //   }
// // // }
// //
// // import 'package:flutter/material.dart';
// //
// //
// // void main() {
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatefulWidget {
// //   @override
// //   State<MyApp> createState() => _MyAppState();
// // }
// //
// //
// // class _MyAppState extends State<MyApp> {
// //   List<Menu> data = [];
// //
// //   @override
// //   void initState() {
// //     dataList.forEach((element) {
// //       data.add(Menu.fromJson(element));
// //     });
// //     super.initState();
// //   }
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         drawer: _drawer(data),
// //         appBar: AppBar(
// //           title: const Text('Expandable ListView'),
// //         ),
// //         body: ListView.builder(
// //           itemCount: data.length,
// //           itemBuilder: (BuildContext context, int index) =>
// //               _buildList(data[index]),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _drawer (List<Menu> data){
// //     return Drawer(
// //         child: SafeArea(
// //           child: SingleChildScrollView(
// //             child: Column(
// //               children: [
// //                 UserAccountsDrawerHeader(margin: EdgeInsets.only(bottom: 0.0),
// //                     accountName: Text('demo'), accountEmail: Text('demo@webkul.com')),
// //                 ListView.builder(
// //                   shrinkWrap: true,
// //                   physics: NeverScrollableScrollPhysics(),
// //                   itemCount: data.length,
// //                   itemBuilder:(context, index){return _buildList(data[index]);},)
// //               ],
// //             ),
// //           ),
// //         ));
// //   }
// //
// //   Widget _buildList(Menu list) {
// //     if (list.subMenu.isEmpty)
// //       return Builder(
// //           builder: (context) {
// //             return ListTile(
// //                // onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context) => SubCategory(list.name))),
// //                 leading: SizedBox(),
// //                 title: Text(list.name)
// //             );
// //           }
// //       );
// //     return ExpansionTile(
// //       leading: Icon(list.icon),
// //       title: Text(
// //         list.name,
// //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //       ),
// //       children: list.subMenu.map(_buildList).toList(),
// //     );
// //   }
// // }
// //
// //
// //
// // List dataList = [
// //   {
// //     "name": "Sales",
// //     "icon": Icons.payment,
// //     "subMenu": [
// //       {"name": "Orders"},
// //       {"name": "Invoices"}
// //     ]
// //   },
// //   {
// //     "name": "Marketing",
// //     "icon": Icons.volume_up,
// //     "subMenu": [
// //       {
// //         "name": "Promotions",
// //         "subMenu": [
// //           {"name": "Catalog Price Rule"},
// //           {"name": "Cart Price Rules"}
// //         ]
// //       },
// //       {
// //         "name": "Communications",
// //         "subMenu": [
// //           {"name": "Newsletter Subscribers"}
// //         ]
// //       },
// //       {
// //         "name": "SEO & Search",
// //         "subMenu": [
// //           {"name": "Search Terms"},
// //           {"name": "Search Synonyms"}
// //         ]
// //       },
// //       {
// //         "name": "User Content",
// //         "subMenu": [
// //           {"name": "All Reviews"},
// //           {"name": "Pending Reviews"}
// //         ]
// //       }
// //     ]
// //   }
// // ];
// //
// // class Menu {
// //   var name;
// //   var icon;
// //   List<Menu> subMenu = [];
// //
// //   Menu({this.name, required this.subMenu, this.icon});
// //
// //   Menu.fromJson(Map<String, dynamic> json) {
// //     name = json['name'];
// //     icon = json['icon'];
// //     if (json['subMenu'] != null) {
// //       subMenu.clear();
// //       json['subMenu'].forEach((v) {
// //         subMenu?.add(new Menu.fromJson(v));
// //       });
// //     }
// //   }
// // }
// // ignore_for_file: file_names, must_be_immutable, non_constant_identifier_names, body_might_complete_normally_nullable, unused_local_variable, use_build_context_synchronously
//
// import 'dart:convert';
//
// import 'package:businessgym/conts/global_values.dart';
// import 'package:businessgym/model/GetDiscussionsModel.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:textfield_tags/textfield_tags.dart';
// import '../Utils/ApiUrl.dart';
// import '../Utils/SharedPreferences.dart';
// import '../Utils/common_route.dart';
// import '../values/Colors.dart';
//
// class GetDiscussionCommentScreen extends StatefulWidget {
//   String? discussion_id;
//    GetDiscussionsModelData data;
//
//   GetDiscussionCommentScreen(
//       {Key? key, required this.data,  this.discussion_id})
//       : super(key: key);
//
//   @override
//   State<GetDiscussionCommentScreen> createState() =>
//       _GetDiscussionCommentScreenState();
// }
//
// class _GetDiscussionCommentScreenState
//     extends State<GetDiscussionCommentScreen> {
//   String UserId = "";
//   String categotyid = "";
//   String? usertoken = "";
//   String? usertype = "";
//
//   final SharedPreference _sharedPreference = SharedPreference();
//   final titleController = TextEditingController();
//   final descriptionController = TextEditingController();
//   // final tagsController = TextEditingController();
//   late TextfieldTagsController _controller;
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getuserType();
//     _controller = TextfieldTagsController();
//   }
//
//   void getuserType() async {
//     usertype = await _sharedPreference.isUserType();
//     UserId = await _sharedPreference.isUsetId();
//     usertoken = await _sharedPreference.isToken();
//     //listData1=getcategotyData();
//     //getcategotyData(UserId);
//   }
//
//   Future<bool?> getcategotyData(
//       String userid, String groupId, String title, String discussionId) async {
//     try {
//       showLoader(context);
//
//       // final response = await http.get(Uri.parse(ApiUrl.getSupportSubject),);
//
//       Map<String, String> requestBody = <String, String>{
//         'user_id': userid,
//         'group_id': groupId,
//         'discussion_id': discussionId,
//         'text': title,
//         // 'description':description,
//         // 'tags':_controller.getTags.toString(),
//       };
//
//       final response = await http.post(
//         Uri.parse(ApiUrl.addDiscussionComment),
//         body: requestBody,
//       );
//       Map<String, dynamic> map = json.decode(response.body);
//
//       // Map<String, dynamic> map = json.decode(response.body);
//
//       if (response.statusCode == 200) {
//         hideLoader();
//
//         /*lon = map['lon'];
//         document = map['document'];
//         raiting = map['raiting'];*/
//         Navigator.pop(context);
//         setState(() {});
//
//         return true;
//       }
//     } catch (e) {
//       hideLoader();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: AppColors.white,
//           leading: IconButton(
//             icon: const Icon(
//               Icons.arrow_back,
//               color: Colors.black,
//             ),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//           title: Container(
//             height: 50,
//             margin: const EdgeInsets.only(left: 0),
//             color: const Color(0xFFffffff),
//             child: Material(
//               child: Row(
//                 children: const [
//                   Text(
//                     "Add Discussion Comment",
//                     style: TextStyle(
//                         color: AppColors.black,
//                         fontFamily: "bold",
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//               /*Container(
//                     margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
//                     child: Card(
//                       child: TextField(
//                         controller: titleController,
//                         style:
//                         TextStyle(color: Colors.black, fontFamily: "reguler"),
//                         //  keyboardType: TextInputType.number,
//
//                         decoration: InputDecoration(
//                           hintText: " Enter questions ",
//                           counterText: "",
//                           hintStyle: const TextStyle(color: Color(0xff808080)),
//                           fillColor: AppColors.white,
//                           filled: true,
//                           focusColor: AppColors.white,
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),
//                             borderSide:
//                             BorderSide(color: AppColors.white, width: 1.0),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),
//                             borderSide:
//                             BorderSide(color: AppColors.white, width: 1.0),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 10,),*/
//               Container(
//                 margin: const EdgeInsets.only(top: 5, left: 20, right: 20),
//                 child: Card(
//                   child: TextField(
//                     controller: descriptionController,
//                     style: const TextStyle(
//                         color: Colors.black, fontFamily: "reguler"),
//                     //  keyboardType: TextInputType.number,
//                     maxLines: 5,
//                     decoration: InputDecoration(
//                       hintText: " Enter Comment ",
//                       counterText: "",
//                       hintStyle: const TextStyle(color: Color(0xff808080)),
//                       fillColor: AppColors.white,
//                       filled: true,
//                       focusColor: AppColors.white,
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: const BorderSide(
//                             color: AppColors.white, width: 1.0),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: const BorderSide(
//                             color: AppColors.white, width: 1.0),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               /* SizedBox(height: 10,),
//                   TextFieldTags(
//                     textfieldTagsController: _controller,
//                     */ /*initialTags: const [
//                       'pick',
//                       'your',
//                       'favorite',
//                       'programming',
//                       'language'
//                     ],*/ /*
//                     textSeparators: const [' ', ','],
//                     letterCase: LetterCase.normal,
//                     */ /*validator: (String tag) {
//                       if (tag == 'php') {
//                         return 'No, please just no';
//                       } else if (_controller.getTags!.contains(tag)) {
//                         return 'you already entered that';
//                       }
//                       return null;
//                     },*/ /*
//                     inputfieldBuilder:
//                         (context, tec, fn, error, onChanged, onSubmitted) {
//                       return ((context, sc, tags, onTagDelete) {
//                         return Padding(
//                           padding: const EdgeInsets.all(20.0),
//                           child: TextField(
//                             controller: tec,
//                             focusNode: fn,
//                             decoration: InputDecoration(
//                               isDense: true,
//                               border: const OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Color.fromARGB(255, 74, 137, 92),
//                                   width: 3.0,
//                                 ),
//                               ),
//                               focusedBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Color.fromARGB(255, 74, 137, 92),
//                                   width: 3.0,
//                                 ),
//                               ),
//                             //  helperText: 'Enter language...',
//                               helperStyle: const TextStyle(
//                                 color: Color.fromARGB(255, 74, 137, 92),
//                               ),
//                               hintText: _controller.hasTags ? '' : "Enter tag...",
//                               errorText: error,
//                               prefixIconConstraints:
//                               BoxConstraints(maxWidth: _distanceToField * 0.74),
//                               prefixIcon: tags.isNotEmpty
//                                   ? SingleChildScrollView(
//                                 controller: sc,
//                                 scrollDirection: Axis.horizontal,
//                                 child: Row(
//                                     children: tags.map((String tag) {
//                                       return Container(
//                                         decoration: const BoxDecoration(
//                                           borderRadius: BorderRadius.all(
//                                             Radius.circular(20.0),
//                                           ),
//                                           color: Color.fromARGB(255, 74, 137, 92),
//                                         ),
//                                         margin: const EdgeInsets.symmetric(
//                                             horizontal: 5.0),
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 10.0, vertical: 5.0),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             InkWell(
//                                               child: Text(
//                                                 '#$tag',
//                                                 style: const TextStyle(
//                                                     color: Colors.white),
//                                               ),
//                                               onTap: () {
//
//                                               },
//                                             ),
//                                             const SizedBox(width: 4.0),
//                                             InkWell(
//                                               child: const Icon(
//                                                 Icons.cancel,
//                                                 size: 14.0,
//                                                 color: Color.fromARGB(
//                                                     255, 233, 233, 233),
//                                               ),
//                                               onTap: () {
//                                                 onTagDelete(tag);
//                                               },
//                                             )
//                                           ],
//                                         ),
//                                       );
//                                     }).toList()),
//                               )
//                                   : null,
//                             ),
//                             onChanged: onChanged,
//                             onSubmitted: onSubmitted,
//                           ),
//                         );
//                       });
//                     },
//                   ),*/
//               const SizedBox(
//                 height: 20,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   // titleController.text.toString();
//                   descriptionController.text.toString();
//                   //  _controller.getTags.toString();
//
//
//                   getcategotyData(
//                       UserId,
//                       widget.data.groupId.toString()!,
//                       descriptionController.text.toString(),
//                       widget.discussion_id!);
//                   // _sharedPreference.getAllPrefsClear();
//                   /*  Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => LoginScreen(),
//                           ));*/
//                 },
//                 child: Container(
//                   margin: const EdgeInsets.all(20),
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                       color: AppColors.purple,
//                       borderRadius: BorderRadius.circular(20)),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       Text(
//                         "Submit",
//                         style: TextStyle(
//                             color: AppColors.white,
//                             fontSize: 20,
//                             fontFamily: "reguler"),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
//
// void main() => runApp(Dene());
//
// class Dene extends StatelessWidget {
//   const Dene({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyApp(),
//     );
//   }
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: [
//             Expanded(
//               child: StaggeredGridView.countBuilder(
//                 crossAxisCount: 4,
//                 itemCount: 22,
//                 itemBuilder: (BuildContext context, int index) => new Container(
//                     color: Colors.green,
//                     child: new Center(
//                       child: new CircleAvatar(
//                         backgroundColor: Colors.white,
//                         child: new Text('$index'),
//                       ),
//                     )),
//                 staggeredTileBuilder: (int index) =>
//                 new StaggeredTile.count(2, index.isEven ? 2 : 1),
//                 mainAxisSpacing: 4.0,
//                 crossAxisSpacing: 4.0,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



