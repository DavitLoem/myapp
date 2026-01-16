import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefScreen extends StatefulWidget {
  const SharedPrefScreen({super.key});

  @override
  State<SharedPrefScreen> createState() => _SharedPrefScreenState();
}

class _SharedPrefScreenState extends State<SharedPrefScreen> {
  // void saveString() async {
  //   var pref = await SharedPreferences.getInstance();

  //   pref.setString("stringPref", "Hello from pref");
  //   // pref.setBool("boolPref", false);
  //   // pref.setInt("intPref", 1);
  //   // pref.setDouble("doublePref", 1.1);
  // }

  // void readString() async {
  //   var pref = await SharedPreferences.getInstance();
  //   var value = pref.getString("stringPref");
  //   debugPrint("Data from pref: value : $value");
  // }
  var storedIndex = <String>[];

  void toggleBookmark(int index) async {
    var pref = await SharedPreferences.getInstance();
    setState(() {
      if (storedIndex.contains("bookmark_$index")) {
        storedIndex.remove("bookmark_$index");
      } else {
        storedIndex.add("bookmark_$index");
      }
    });
    pref.setStringList("bookmarkIndex", storedIndex);
  }

  void loadBookmark() async {
    var pref = await SharedPreferences.getInstance();
    var data = pref.getStringList("bookmarkIndex") ?? [];
    setState(() {
      storedIndex = data;
    });
  }

  @override
  void initState() {
    loadBookmark();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shared Pref',
          style: TextStyle(
            color: Colors.orangeAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 100,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Bounceable(
              scaleFactor: 0.5,
              duration: Duration(milliseconds: 100),
              onTap: () {
                toggleBookmark(index);
              },
              child: Icon(
                storedIndex.contains("bookmark_$index")
                    ? Icons.bookmark
                    : Icons.bookmark_outline,
                color: storedIndex.contains("bookmark_$index")
                    ? Colors.teal
                    : Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }
}
