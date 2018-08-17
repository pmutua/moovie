import 'package:flutter/material.dart';
// Import movie model to be used here
import 'package:moovie/model/model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

//converting data from json
import 'dart:convert';

// API Key
const key = ' ';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Moovy',
      theme: new ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}


class HomeState extends State<HomePage> {
  List<Movie>movies = List();
  bool hasLoaded = true;

  // returns an observable object rather than a string
  final PublishSubject subject = PublishSubject<String>();


  @override
  void dispose() {
    // TODO: implement dispose--close the widget after we are done.
    subject.close();
    super.dispose();
  }

  // Add search movie function
  void searchMovies(query){
    // reset every single time we go for querying
    resetMovies();
    // check query if empty
    if(query.isEmpty){
      //if empty
      setState((){
        hasLoaded= false;

      });

    }
  }

  void resetMovies(){
    setState(()=> movies.clear());
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //debounce helps us create an observable that has some latency on when it can send data through the stream
    //deboounce method helps us to specify the time lag when the user makes a call to the api and when the data shows up in the view
    subject.stream.debounce(Duration(milliseconds:400)).listen(searchMovies);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Searcher')
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(children: <Widget>[
          TextField(
            onChanged: (String string) => (subject.add(string)),
          ),
          hasLoaded ? Container(): CircularProgressIndicator(),
          Expanded(child: ListView.builder(
            padding:EdgeInsets.all(10.0),
            itemCount: movies.length,
            itemBuilder: (BuildContext context,int index){
              return new Container();
            },
          ),)
        ],
        )
      )     
    );
  }


}


//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  // This widget is the home page of your application. It is stateful, meaning
//  // that it has a State object (defined below) that contains fields that affect
//  // how it looks.
//
//  // This class is the configuration for the state. It holds the values (in this
//  // case the title) provided by the parent (in this case the App widget) and
//  // used by the build method of the State. Fields in a Widget subclass are
//  // always marked "final".
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => new _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
//
//  void _incrementCounter() {
//    setState(() {
//      // This call to setState tells the Flutter framework that something has
//      // changed in this State, which causes it to rerun the build method below
//      // so that the display can reflect the updated values. If we changed
//      // _counter without calling setState(), then the build method would not be
//      // called again, and so nothing would appear to happen.
//      _counter++;
//    });
//  }

//  @override
//  Widget build(BuildContext context) {
//    // This method is rerun every time setState is called, for instance as done
//    // by the _incrementCounter method above.
//    //
//    // The Flutter framework has been optimized to make rerunning build methods
//    // fast, so that you can just rebuild anything that needs updating rather
//    // than having to individually change instances of widgets.
//    return new Scaffold(
//      appBar: new AppBar(
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: new Text(widget.title),
//      ),
//      body: new Center(
//        // Center is a layout widget. It takes a single child and positions it
//        // in the middle of the parent.
//        child: new Column(
//          // Column is also layout widget. It takes a list of children and
//          // arranges them vertically. By default, it sizes itself to fit its
//          // children horizontally, and tries to be as tall as its parent.
//          //
//          // Invoke "debug paint" (press "p" in the console where you ran
//          // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
//          // window in IntelliJ) to see the wireframe for each widget.
//          //
//          // Column has various properties to control how it sizes itself and
//          // how it positions its children. Here we use mainAxisAlignment to
//          // center the children vertically; the main axis here is the vertical
//          // axis because Columns are vertical (the cross axis would be
//          // horizontal).
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            new Text(
//              'You have pushed the button this many times:',
//            ),
//            new Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.display1,
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: new FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: new Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
//    );
//  }
//}
