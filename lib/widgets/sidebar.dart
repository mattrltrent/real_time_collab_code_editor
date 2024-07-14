import 'package:alert_banner/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uvec/state/firebase.dart';
import 'package:uvec/config/typography.dart';
import 'package:uvec/effects/touchable_opacity.dart';
import 'package:uvec/state/state.dart';
import 'package:uvec/widgets/banner.dart';
import 'package:uvec/widgets/file_listing.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  final TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _addText() {
    final text = _textController.text;
    // and no weird chars via regex
    bool weirdChars = RegExp(r'[^\w\-.]').hasMatch(text);
    if (text.isNotEmpty && !text.contains(' ') && !weirdChars) {
      // takes file name and then body
      Provider.of<FirebaseState>(context, listen: false).addDocument(text, '');
      _textController.clear();
    } else {
      showAlertBanner(
        context,
        () {},
        const MyBanner(text: "Invalid file name, try newFile.js"),
        maxLength: 500,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7.2),
          color: Theme.of(context).colorScheme.shadow,
          child: Text(
            "uvec demo",
            textAlign: TextAlign.center,
            style: miniFont.copyWith(
                color: Theme.of(context).colorScheme.secondary),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add a new file",
                  style: miniFont.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.shadow,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _textController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  border: InputBorder.none,
                                  hintText: 'newFile.js',
                                  hintStyle: miniFont.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                                style: miniFont.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                onSubmitted: (_) => _addText(),
                              ),
                            ),
                            TouchableOpacity(
                              onTap: _addText,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.shadow,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: const Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  height: 2,
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.shadow,
                ),
                Expanded(
                  child: Consumer<FirebaseState>(
                    builder: (context, firebaseState, child) {
                      if (firebaseState.documents.isEmpty) {
                        return Center(child: Text('No documents found.'));
                      }
                      return ListView.builder(
                        itemCount: firebaseState.documents.length,
                        itemBuilder: (context, index) {
                          final document = firebaseState.documents[index];
                          return FileListing(
                            onClick: () {
                              // if doc to open's id is already in _openFiles then ignore and set it to the focused one
                              if (Provider.of<AppState>(context, listen: false)
                                  .openFiles
                                  .any((doc) => doc.id == document.id)) {
                                Provider.of<AppState>(context, listen: false).setSelectedFileId(
                                  document.id,
                                );
                                return;
                              }

                              // add to open files, and then set selected file index to that index
                              Provider.of<AppState>(context, listen: false).addOpenFile(document);
                              // get idx by getIdxOfOpenFile, then set that as the focused one
                              Provider.of<AppState>(context, listen: false).setSelectedFileId(
                                document.id,
                              );
                            },
                            onDeletePressed: () {},
                            onEditPressed: (newName) {},
                            fileName: document.title,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
// =======
//   final textController = TextEditingController();
//   final FocusNode _focusNode = FocusNode();

//   Widget build(BuildContext context) {
//     return Form(
//         key: _formKey,
//         child: Column(children: <Widget>[
//           KeyboardListener(
//               focusNode: _focusNode,
//               autofocus: true,
//               onKeyEvent: (event) {
//                 final firebaseState =
//                     Provider.of<FirebaseState>(context, listen: false);
//                 firebaseState.insertText(
//                     textController.text.length, event.logicalKey.keyLabel);
//                 print(event.logicalKey);
//               },
//               child: Column(
//                 children: [
//                   TextField(
//                     controller: textController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: 'Enter Data',
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       // Validate returns true if the form is valid, or false otherwise.
//                       // If the form is valid, display a snackbar. In the real world,
//                       // you'd often call a server or save the information in a database.

//                       final firebaseState =
//                           Provider.of<FirebaseState>(context, listen: false);
//                       firebaseState.detectChange();
//                       firebaseState.addDocument('test', textController.text);
//                       print(firebaseState.globalText);
//                     },
//                     child: const Text('Submit'),
//                   ),
//                 ],
//               ))
//         ]));
// >>>>>>> Stashed changes
//   }
  }
}
