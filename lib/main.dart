import 'package:flutter/material.dart';
import 'package:sqlite_app/core/exception.dart';
import 'package:sqlite_app/model/note.dart';
import 'package:sqlite_app/repository/note_repository.dart';
import 'package:sqlite_app/services/database_service.dart';

void main() => runApp(MaterialApp(home: HomePage()));

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  late NoteRepositoryImpl noteRepositoryImpl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseService databaseService = DatabaseService();
    noteRepositoryImpl = NoteRepositoryImpl(dbService: databaseService);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Insert a note please";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_form.currentState!.validate()) {
            try {
              final name = _name.text;
              Note note = Note.create(name: name);
              bool status  = await noteRepositoryImpl.save(note);
              if (status) {
                _name.clear();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Note Added Successfully'),
                  ),
                );
              }
            } on InsertErrorException catch (ex) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error to insert the data'),
                ),
              );
            } catch (ex) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Unknown error please try again'),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
