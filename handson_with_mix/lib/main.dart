import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  // save data
  final List<String> _todoList = <String>[];
  List<bool> isChecked = [];
  final TextEditingController _textFieldController = TextEditingController();
  bool checked = false;
  bool switchX = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: ListView.builder(
          itemCount: _todoList.length,
          itemBuilder: (BuildContext context, int index) {
            return CardX(children: [
              HBox(mix: Mix(gap(26.0)), children: [
                CheckboxX(
                  mix: Mix(bgColor(Colors.white)),
                  checked: isChecked[index],
                  onChanged: (v) => setState(() => isChecked[index] = v),
                ),
                TextMix(_todoList[index],
                    mix: Mix(
                        fontSize(18.0),
                        textColor(Colors.white),
                        (isChecked[index])(
                            textDecoration(TextDecoration.lineThrough))))
              ])
            ]);
          }),
      // add items to the to-do list
      floatingActionButton: Pressable(
        onPressed: () => _displayDialog(context),
        child: Box(
          mix: Mix(
            bgColor(Colors.white),
            rounded(20),
            padding(10),
          ),
          child: TextMix(
            'Create ToDO',
            mix: Mix(
              fontSize(18.0),
              (disabled)(
                textColor(Colors.grey.shade900),
              ),
              textColor(Colors.black),
              bold(),
            ),
          ),
        ),
      ),
    );
  }

  void _addTodoItem(String title) {
    // Wrapping it inside a set state will notify
    // the app that the state has changed
    setState(() {
      _todoList.add(title);
      isChecked.add(false);
    });
    _textFieldController.clear();
  }

  // display a dialog for the user to enter items
  Future<AlertDialog> _displayDialog(BuildContext context) async {
    // alter the app state to show a dialog
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add a task to your list'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: 'Enter task here'),
            ),
            actions: <Widget>[
              // Cancel button
              Pressable(
                onPressed: () {
                  Navigator.of(context).pop();
                  _addTodoItem(_textFieldController.text);
                },
                child: Box(
                  child: TextMix(
                    'Cancel',
                    mix: Mix(
                      fontSize(18.0),
                      (disabled)(
                        textColor(Colors.grey.shade900),
                      ),
                      textColor(Colors.white),
                      bold(),
                    ),
                  ),
                ),
              ),
              Box(
                mix: Mix(width(10)),
              ),
              // add button
              Pressable(
                onPressed: () {
                  Navigator.of(context).pop();
                  if (_textFieldController.text.trim().isNotEmpty) {
                    _addTodoItem(_textFieldController.text);
                  }
                },
                child: Box(
                  mix: Mix(
                    // when nothing's happening, bg color is the default grey
                    bgColor(Colors.grey),
                    width(50),
                    (hover)(
                      // when hovering, bg color is a lighter grey
                      bgColor(Colors.grey.shade100),
                    ),
                    (press)(
                      // when pressing, bg color is a darker grey
                      bgColor(Colors.grey.shade200),
                    ),
                    rounded(5),
                    padding(8),
                  ),
                  child: TextMix(
                    'Add',
                    mix: Mix(
                      fontSize(18.0),
                      (disabled)(
                        textColor(Colors.grey.shade900),
                      ),
                      textColor(Colors.white),
                      bold(),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
}
