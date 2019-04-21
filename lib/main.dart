import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hacker_news/src/article.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter List Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Article> _articles = articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await new Future.delayed(const Duration(seconds: 1));
          setState(() {
            _articles.removeAt(0);
          });
        },
        child: ListView(
            children: _articles.map(_buildItem).toList(),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildItem(Article article) {
    return new Padding(
      padding: EdgeInsets.all(10.0),
      child: new ExpansionTile(
        title: new Text(article.text, style: new TextStyle(fontSize: 19.0)),
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Text("${article.commentsCount} comments"),
              new IconButton(
                  icon: new Icon(Icons.launch),
                  onPressed: () async {
                    final fakeUrl = "http://${article.domain}";
                    if (await canLaunch(fakeUrl)) {
                      launch(fakeUrl);
                    }
                  },
              )
            ],
          ),
        ],
      ),
    );
  }
}
