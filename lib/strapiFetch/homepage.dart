import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../helpfoolWidget/cardFile.dart';
import '../milisearch/meili_search_service.dart';

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
    headline: json['headline'],
    description: json['description'],
    publishedAt: json['publishedAt'],
  );
}

class ApiPage extends StatefulWidget {
  const ApiPage({Key? key}) : super(key: key);

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  late Future<List<Article>> _futureArticles;
  final MeiliSearchService _searchService = MeiliSearchService(); // Initialize the search service
  final user = FirebaseAuth.instance.currentUser!; // Get the current user

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

  void _onSearch(String query) async {
    final results = await _searchService.search(query);
    setState(() {
      _futureArticles = Future.value(
        results.map((json) => Article.fromJson(json)).toList(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Welcome ${user.email}"),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              ),
              onChanged: _onSearch,
            ),
          ),
          Expanded(
            child: Stack(
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
          ),
        ],
      ),
    );
  }

  Future<List<Article>> getData() async {
    String newstrapiApi = dotenv.get("API_HOST",fallback: "");
    final response = await http.get(Uri.parse('$newstrapiApi:1337/api/newsblogs')); // Use your local machine's IP address
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final data = body["data"] as List<dynamic>;
    List<Article> articles = [];
    for (var element in data) {
      articles.add(Article.fromJson(element['attributes']));
    }
    return articles;
  }
}


