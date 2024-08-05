import 'package:flutter/material.dart';

class Cardfile extends StatelessWidget {
  final String headline;
  final String description;
  final String publishedAt;

  const Cardfile({
    Key? key,
    required this.headline,
    required this.description,
    required this.publishedAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: Colors.grey[100],
        elevation: 10.0,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Make the column take only as much space as needed
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headline,
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
              ),
              SizedBox(height: 10), // Add some spacing between headline and description
              Text(description),
              SizedBox(height: 10), // Add some spacing between description and publishedAt
              Text("Published on "+
                publishedAt,
                style: TextStyle(color: Colors.grey, fontSize: 12.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}








// import 'package:flutter/material.dart';
//
// class Cardfile extends StatelessWidget {
//   final String headline;
//   final String description;
//
//   const Cardfile({
//     Key? key,
//     required this.headline,
//     required this.description,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(10.0),
//       width: MediaQuery.of(context).size.width,
//       child: Card(
//         color: Colors.grey[100],
//         elevation: 10.0,
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min, // Make the column take only as much space as needed
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 headline,
//                 style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
//               ),
//               SizedBox(height: 10), // Add some spacing between headline and description
//               Text(description),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }










// import 'package:flutter/material.dart';
//
// class Cardfile extends StatelessWidget {
//   final String headline;
//   final String description;
//
//   const Cardfile({
//     Key? key,
//     required this.headline,
//     required this.description,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(15.0),
//       height: 200,
//       width: MediaQuery.of(context).size.width,
//       child: Card(
//         color: Colors.grey[100],
//         elevation: 10.0,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               headline,
//               style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
//             ),
//             Text(description),
//           ],
//         ),
//       ),
//     );
//   }
// }

