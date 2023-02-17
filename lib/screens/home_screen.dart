import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../widgets/top_bar.dart';
import '../widgets/shake.dart';
import '../Function/home_function.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home-screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    // TODO: implement initState
    Shake.detector.startListening();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Shake.detector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const TopBar(),
      ),
      body: SizedBox(
        child: ListView.builder(
          itemCount: categoryModel.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Ink(
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    // side: BorderSide(
                    //   color: categoryModel[index].color,
                    //   width: 3,
                    // ),
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    leading: Icon(
                      categoryModel[index].iconData,
                      // color: categoryModel[index].color,
                      size: 50,
                    ),
                    title: Align(
                      alignment: Alignment.center,
                      child: Text(
                        categoryModel[index].title,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    trailing: const Icon(Icons.volume_up),
                    onLongPress: () {
                      HomeFunction.buttonTapProcess(index);
                      HomeFunction.selectedCategory(
                        context: context,
                        index: index,
                      );
                    },
                    onTap: () {
                      HomeFunction.buttonTapProcess(index);
                      HomeFunction.selectedCategory(
                        context: context,
                        index: index,
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
