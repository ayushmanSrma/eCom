import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../helpfoolWidget/cardFile.dart';

class Article {
  late String headline;
  late String description;
  late String publishedAt;

  Article({
    required this.headline,
    required this.description,
    required this.publishedAt,
  });

  static Article fromJson(Map<String, dynamic> json) => Article(
    headline: json['attributes']['headline'],
    description: json['attributes']['description'],
    publishedAt: json['attributes']['publishedAt'],
  );
}

class ApiPage extends StatefulWidget {
  const ApiPage({Key? key}) : super(key: key);

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  late Future<List<Article>> _futureArticles;

  @override
  void initState() {
    super.initState();
    _futureArticles = getData();
  }

  Future<void> _refreshData() async {
    setState(() {
      _futureArticles = getData();
    });
  }

  Widget buildArticle(Article article) => Cardfile(
    headline: article.headline,
    description: article.description,
    publishedAt: article.publishedAt,
  );

  final user = FirebaseAuth.instance.currentUser!;

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: logout, icon: Icon(Icons.logout)),
        ],
        title: Center(child: Text("Welcome "+user.email.toString())),
      ),
      body: Stack(
        children: [
          FutureBuilder<List<Article>>(
            future: _futureArticles,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final articles = snapshot.data!;
                return ListView(
                  reverse: false,
                  children: articles.map(buildArticle).toList(),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: _refreshData,
              child: Icon(Icons.refresh),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Article>> getData() async {
    final response = await http.get(Uri.parse('http://192.168.1.33:1337/api/newsblogs')); // Use your local machine's IP address
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final data = body["data"] as List<dynamic>;
    List<Article> articles = [];
    for (var element in data) {
      articles.add(Article.fromJson(element));
    }
    return articles;
  }
}



// import 'dart:convert';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import '../helpfoolWidget/cardFile.dart';
//
// class Article {
//   late String headline;
//   late String description;
//   late String publishedAt;
//
//   Article({
//     required this.headline,
//     required this.description,
//     required this.publishedAt,
//   });
//
//   static Article fromJson(Map<String, dynamic> json) => Article(
//     headline: json['attributes']['headline'],
//     description: json['attributes']['description'],
//     publishedAt: json['attributes']['publishedAt'],
//   );
// }
//
// class ApiPage extends StatefulWidget {
//   const ApiPage({Key? key}) : super(key: key);
//
//   @override
//   State<ApiPage> createState() => _ApiPageState();
// }
//
// class _ApiPageState extends State<ApiPage> {
//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }
//
//   Widget buildArticle(Article article) => Cardfile(
//     headline: article.headline,
//     description: article.description,
//     publishedAt: article.publishedAt,
//   );
//   final user = FirebaseAuth.instance.currentUser!;
//
//   void logout() {
//     FirebaseAuth.instance.signOut();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(onPressed: logout, icon: Icon(Icons.logout)),
//         ],
//         title: Center(child: Text(user.email.toString())),
//       ),
//       body: FutureBuilder<List<Article>>(
//           future: getData(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               final articles = snapshot.data!;
//               return ListView(
//                 reverse: false,
//                 children: articles.map(buildArticle).toList(),
//               );
//             } else {
//               return const Center(child: CircularProgressIndicator());
//             }
//           }),
//     );
//   }
//
//   Future<List<Article>> getData() async {
//     final response = await http.get(Uri.parse('http://192.168.1.33:1337/api/newsblogs')); // Use your local machine's IP address
//     final body = jsonDecode(response.body) as Map<String, dynamic>;
//     final data = body["data"] as List<dynamic>;
//     List<Article> articles = [];
//     for (var element in data) {
//       articles.add(Article.fromJson(element));
//     }
//     return articles;
//   }
// }



