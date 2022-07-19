// import 'package:flutter/material.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:w_news/home.dart';
// import 'package:w_news/start_up/intro_page1.dart';
// import 'package:w_news/start_up/login_screen.dart';

// class OnBoardScreen extends StatefulWidget {
//   const OnBoardScreen({Key? key}) : super(key: key);

//   @override
//   State<OnBoardScreen> createState() => _OnBoardScreenState();
// }

// class _OnBoardScreenState extends State<OnBoardScreen> {
//   PageController _controller = PageController();
//   bool onLastPage = false;
  
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children:[ 
//           PageView(
//             controller: _controller,
//             onPageChanged: (index){
//               setState(() {
//                 onLastPage = (index == 1);
//               });
//             },
//           children: [
//             IntroPage1(),
            
//               Login()
//           ],
//         ),
//         //dot indicator

//         Container(
//           alignment: Alignment(0, 0.75),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               //Skip Button
// //               GestureDetector(
// //                 onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context){
// // return HommePage();
// //                 }));},
// //                 child: Text('Skip')),

//               SmoothPageIndicator(controller: _controller, count: 2),

//               //next Button
// //               onLastPage? 
// //               GestureDetector(
// //                 onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context){
// // return HommePage();
// //                 }));},
// //                 child: Text('Done'))

// //                  :GestureDetector(
// //                 onTap: (){
// //                   _controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
// //                 },
// //                 child: Text('next'))
//             ],
//           ))
//         ]
//       ),

//     );
//   }
// }