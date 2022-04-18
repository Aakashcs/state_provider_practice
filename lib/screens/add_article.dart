import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_provider_practice/models/article.dart';
import 'package:state_provider_practice/providers/article_provider.dart';

import '../constants.dart';

class AddArticleScreen extends StatefulWidget {
  const AddArticleScreen({Key? key}) : super(key: key);

  @override
  State<AddArticleScreen> createState() => _AddArticleScreenState();
}

class _AddArticleScreenState extends State<AddArticleScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ArticleProvider articleProvider =
        Provider.of<ArticleProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Article"),
      ),
      body: articleProvider.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      showCursor: true,
                      decoration: kTextFiledInputDecoration,
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _bodyController,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      showCursor: true,
                      decoration:
                          kTextFiledInputDecoration.copyWith(labelText: "Body"),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        final article = Article(
                            id: 0,
                            userId: 100,
                            title: _titleController.text,
                            body: _bodyController.text);
                        articleProvider.addArticle(article);
                        Navigator.pop(context);
                      },
                      child: Text("Add"),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 30)),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
