import 'package:connect/models/opinion.dart';
import 'package:flutter/material.dart';
import '../screens/favorite_screen.dart';
import '../db/sql.dart';

class AddingEditModal extends StatelessWidget {
  final Function refreshJournals;
  final String category;
  final int? id;
  final Opinion? cardItem;
  final String routeName;
  const AddingEditModal({
    super.key,
    required this.refreshJournals,
    required this.category,
    required this.id,
    required this.cardItem,
    required this.routeName,
  });

  static TextEditingController titleController = TextEditingController();

  static TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (id != null && cardItem != null) {
      titleController.text = cardItem!.title;
      descriptionController.text = cardItem!.description;
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          // this will prevent the soft keyboard from covering the text fields
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            children: [
              TextField(
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(hintText: "みることば"),
                controller: titleController,
                key: const Key("adding_edit_modal_see"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(hintText: "はなすことば"),
                controller: descriptionController,
                key: const Key("adding_edit_modal_speack"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (id == null) {
                    await Sql.createItem(
                      title: titleController.text,
                      description: descriptionController.text,
                      categories: category,
                    );
                    routeName == FavoriteScreen.routeName
                        ? refreshJournals()
                        : refreshJournals(category: category);
                  } else {
                    await Sql.updateItem(
                      id: id!,
                      title: titleController.text,
                      description: descriptionController.text,
                      categories: category,
                    );
                    routeName == FavoriteScreen.routeName
                        ? refreshJournals()
                        : refreshJournals(category: category);
                  }
                  titleController.text = "";
                  descriptionController.text = "";
                  Navigator.of(context).pop();
                },
                child: id == null
                    ? const Text(
                        "さくせい",
                        key: Key("adding_edit_modal_make"),
                        style: TextStyle(color: Colors.white),
                      )
                    : const Text(
                        "こうしん",
                        key: Key("adding_edit_modal_update"),
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
