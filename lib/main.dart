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
      child: new Row(
        children: <Widget>[   
            new IconButton(icon: new Icon(Icons.done), onPressed: null),
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
    Note note = new Note(
      noteText: text,
    );
    setState(() {
      _notes.insert(0, note);
    });
  }

  Widget _addNote() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                decoration:
                    new InputDecoration.collapsed(hintText: "Write a note"),
              ),
            )])),
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
            new Flexible(
              child: new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              itemBuilder: (_, int index) => _notes[index],
              itemCount: _notes.length,
            )),
            new Divider(height: 1.0),
            new Container(
              decoration: new BoxDecoration(color: Theme.of(context).cardColor),
              child: _addNote(),
            ),
            new FloatingActionButton(
              onPressed: () => _handleSubmitted(_textController.text),
              tooltip: 'Create New Note',
              child: new Icon(Icons.add)
            ),
          ],
        )));
  }
}
