// import 'package:flutter/material.dart';
// import 'package:theme_provider/theme_provider.dart';
//
// class SmallCard extends StatelessWidget {
//   final String str;
//   final IconData icon;
//   final String value;
//
//   SmallCard({this.str, this.icon, this.value});
//
//   @override
//   Widget build(BuildContext context) {
//     Color smallCardColor = ThemeProvider.themeOf(context).id == "actual_dark"
//         ? Colors.blueGrey.shade900
//         : Colors.grey.shade300;
//     return Center(
//       child: Container(
//         width: 3 * MediaQuery.of(context).size.width / 7,
//         height: 80,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(18), color: smallCardColor),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Icon(
//               icon,
//               color: icon == Icons.trending_up ? Colors.green : Colors.red,
//               size: 30,
//             ),
//             SizedBox(
//               width: 20,
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                   str,
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   value,
//                   style: TextStyle(fontSize: 20),
//                 ),
//               ],
//             ),
//             SizedBox(
//               width: 10,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
