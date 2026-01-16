import 'package:flutter/material.dart';

import 'db_helper/db_helper.dart';

class SqliteDemo extends StatefulWidget {
  const SqliteDemo({super.key});

  @override
  State<SqliteDemo> createState() => _SqliteDemoState();
}

class _SqliteDemoState extends State<SqliteDemo> {
  final DbHelper dbHelper = DbHelper();
  List<Map<String, dynamic>> dataList = [];

  Future<void> _loadData() async {
    var openDb = await dbHelper.initDatabase();
    final result = await openDb.query('tb_notes');
    setState(() {
      dataList = result;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('SQLite Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pushNamed(context, '/addDataScreen').then((value) {
            //       _loadData();
            //     });
            //   },
            //   child: const Text('write to db'),
            // ),
            // ElevatedButton(
            //   onPressed: _readData,
            //   child: const Text('read from db'),
            // ),
            // ElevatedButton(
            //   onPressed: _deleteData,
            //   child: const Text('delete from db'),
            // ),
            const SizedBox(height: 20),
            Expanded(
              child: dataList.isEmpty
                  ? const Center(child: Text('No data in database'))
                  : ListView.builder(
                      itemCount: dataList.length,
                      itemBuilder: (context, index) {
                        final item = dataList[index];
                        return ListTile(
                          title: Text(
                            "Title: ${item['title']?.toString() ?? 'No title'}",
                          ),
                          subtitle: Text(
                            "Subtitle: ${item['subtitle']?.toString() ?? 'No subtitle'}",
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.teal,
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/addDataScreen',
                                    arguments: item,
                                  ).then((value) {
                                    _loadData();
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  dbHelper.deleteData(item['id'] as int);
                                  _loadData(); // Refresh display
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 20),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/addDataScreen').then((value) {
                    _loadData();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 8,
                  shadowColor: Colors.blue.withOpacity(0.3),
                ),

                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add_circle, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'write to db',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}
