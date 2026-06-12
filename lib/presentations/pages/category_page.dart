import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool _isSwitchOn = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories', style: TextStyle(fontSize: 20))),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Switch(
                    value: _isSwitchOn,
                    onChanged: (value) {
                      setState(() {
                        _isSwitchOn = value;
                      });
                    },
                    activeThumbColor: Colors.white,
                    inactiveThumbColor: Colors.white,
                    activeTrackColor: Colors.green,
                    inactiveTrackColor: Colors.red,
                    trackOutlineColor: WidgetStatePropertyAll(
                      Colors.transparent,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(_isSwitchOn == true ? 'Income' : 'Outcome'),
                  Spacer(),

                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: Text(
                              'Add ${_isSwitchOn ? 'Income' : 'Outcome'}',
                              style: TextStyle(
                                color: _isSwitchOn ? Colors.green : Colors.red,
                              ),
                            ),
                            content: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Add a new category...',
                                hintStyle: TextStyle(fontSize: 12),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                ),
                                onPressed: () {},
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
              SizedBox(height: 30),

              Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 10,
                child: ListTile(
                  onTap: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  tileColor: Colors.white,
                  title: Text('Sedekah'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                      SizedBox(width: 10),

                      IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                    ],
                  ),
                  leading: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _isSwitchOn ? Icons.download : Icons.upload,
                      color: _isSwitchOn ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
