import 'package:flutter/material.dart';
import '../db/sql.dart';

class AddingEditModal extends StatelessWidget {
  final Function refreshJournals;
  final String category;
  final int? id;
  final List<Map<String, dynamic>> journals;
  final String routeName;
  const AddingEditModal({
    super.key,
    required this.refreshJournals,
    required this.category,
    required this.id,
    required this.journals,
    required this.routeName,
  });

  static TextEditingController titleController = TextEditingController();

  static TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (id != null) {
      final existingJournal =
          journals.firstWhere((element) => element["id"] == id);
      titleController.text = existingJournal["title"];
      descriptionController.text = existingJournal["description"];
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
                decoration: const InputDecoration(hintText: "みることば"),
                controller: titleController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: const InputDecoration(hintText: "はなすことば"),
                controller: descriptionController,
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
                    routeName == "/selected-category"
                        ? refreshJournals(category: category)
                        : refreshJournals();
                  } else {
                    await Sql.updateItem(
                      id: id!,
                      title: titleController.text,
                      description: descriptionController.text,
                      categories: category,
                    );
                    routeName == "/selected-category"
                        ? refreshJournals(category: category)
                        : refreshJournals();
                  }
                  titleController.text = "";
                  descriptionController.text = "";
                  Navigator.of(context).pop();
                },
                child: id == null ? const Text("さくせい") : const Text("こうしん"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
