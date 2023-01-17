import 'package:flutter/material.dart';
import '../db/sqlCrud.dart';

class EditDialog extends StatelessWidget {
  final Function refreshJournals;
  final String category;
  final int? id;
  final List<Map<String, dynamic>> journals;
  const EditDialog({
    super.key,
    required this.refreshJournals,
    required this.category,
    required this.id,
    required this.journals,
  });

  @override
  Widget build(BuildContext context) {
    print("EditDialog");
    print(id);
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    if (id != null) {
      final existingJournal =
          journals.firstWhere((element) => element["id"] == id);
      titleController.text = existingJournal["title"];
      descriptionController.text = existingJournal["description"];
    }

    return Padding(
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
              decoration: const InputDecoration(hintText: "いうことば"),
              controller: descriptionController,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (id == null) {
                  print("null");
                  await SqlCrud.createItem(
                    title: titleController.text,
                    description: descriptionController.text,
                    categories: category,
                  );
                  refreshJournals();
                } else {
                  await SqlCrud.updateItem(
                    id: id!,
                    title: titleController.text,
                    description: descriptionController.text,
                    categories: category,
                  );
                  refreshJournals();
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
    );
  }
}
