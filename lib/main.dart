import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:state_provider_practice/providers/article_provider.dart';
import 'package:state_provider_practice/screens/add_article.dart';
import 'package:state_provider_practice/screens/home_screen.dart';

void main() {
  List<SingleChildWidget> providers = [
    ChangeNotifierProvider<ArticleProvider>(create: (_) => ArticleProvider()),
  ];

  runApp(
    MultiProvider(providers: providers, child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Articles',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const HomeScreen(title: "News Articles"),
        '/add': (context) => const AddArticleScreen(),
      },
    );
  }
}
