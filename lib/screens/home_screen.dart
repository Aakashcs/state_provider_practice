import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_provider_practice/models/article.dart';
import 'package:state_provider_practice/providers/article_provider.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final articleProvider =
        Provider.of<ArticleProvider>(context, listen: false);
    articleProvider.getArticles();
  }

  @override
  Widget build(BuildContext context) {
    final articleProvider = Provider.of<ArticleProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: 25,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/add").then((value) {
                articleProvider.articles.clear();
                articleProvider.getArticles();
              });
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: articleProvider.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: articleProvider.articles.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildItem(articleProvider.articles[index]);
                },
              ),
      ),
    );
  }

  Widget buildItem(Article article) {
    return Card(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).splashColor, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {},
        child: ListTile(
          contentPadding: EdgeInsets.all(10),
          title: Text(
            article.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            article.body,
            style: Theme.of(context).textTheme.bodyText2,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Card(
            clipBehavior: Clip.hardEdge,
            color: Theme.of(context).splashColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: InkWell(
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.article,
                    size: 25,
                    color: Colors.white,
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
