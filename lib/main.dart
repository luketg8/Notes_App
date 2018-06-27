import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Notes',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new MyHomePage(title: 'My Notes'),
    );
  }
}

class Note extends StatelessWidget {
  Note({this.noteText});
  final String noteText;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Row(children: <Widget>[
        new IconButton(icon: new Icon(Icons.note), onPressed: null),
        new Text(noteText),
      ]),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Create the list of notes to add to
  final List<Note> _notes = <Note>[];
  final TextEditingController _textController = new TextEditingController();

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _notes.insert(
          0,
          new Note(
            noteText: text,
          ));
    });
  }

  void _clearAll() {
    setState(() {
      _notes.clear();
    });
  }

  Widget _addNote() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: new Row(children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                decoration:
                    new InputDecoration.collapsed(hintText: "Write a note"),
              ),
            ),
            new FloatingActionButton(
                onPressed: () => _handleSubmitted(_textController.text),
                tooltip: 'Create New Note',
                child: new Icon(Icons.add)
                )
          ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
          elevation: 4.0,
        ),
        body: new Container(
            child: new Column(
          children: <Widget>[
            new FloatingActionButton(
                onPressed: _notes.isEmpty ? null : () => _clearAll(),
                shape: RoundedRectangleBorder(),
                backgroundColor: Colors.red,
                tooltip: 'Clear Notes',
                child: new Icon(Icons.clear)),
            new Flexible(
              child: new ListView.builder(
              padding: new EdgeInsets.all(2.0),
              itemBuilder: (_, int index) => _notes[index],
              itemCount: _notes.length,
            )),
            new Divider(height: 5.0),
            new Container(
              decoration: new BoxDecoration(color: Theme.of(context).cardColor),
              child: _addNote(),
            ),
          ],
        )));
  }
}
