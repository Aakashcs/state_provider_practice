import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:state_provider_practice/models/article.dart';
import 'package:toast/toast.dart';

class ArticleProvider with ChangeNotifier {
  bool isLoading = false;
  var articles = <Article>[];

  getArticles() async {
    isLoading = true;
    articles = await _getAllArticles();
    isLoading = false;

    notifyListeners();
  }

  addArticle(Article article) async {
    isLoading = true;
    await _createArticle(article);
    isLoading = false;

    notifyListeners();
  }

  Future<List<Article>> _getAllArticles() async {
    List<Article> results = [];
    try {
      final response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> items = json.decode(response.body);
        results.addAll(items.map((e) => Article.fromJson(e)).toList());
      } else {
        Toast.show("Data not found",
            duration: 2, backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      log(e.toString());
    }
    return results;
  }

  Future<bool> _createArticle(Article article) async {
    try {
      final response = await http.post(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
        body: json.encode(article.toMap()),
        encoding: Encoding.getByName('utf-8'),
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        Toast.show("Error", duration: 2, backgroundColor: Colors.redAccent);
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }
}
