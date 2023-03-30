import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref extends StatefulWidget {
  @override
  State<SharedPref> createState() => _SharedPrefState();
}

class _SharedPrefState extends State<SharedPref> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _positionController = TextEditingController();

  void initState() {
    super.initState();
    getValue();
  }

  // const SharedPref({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 172, 142, 207),
        centerTitle: true,
        title: Text(
          "Shared Preferences",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(255, 219, 133, 133),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _nameController, // obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your Name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  // obscureText: true,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your Email',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _phoneController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your Phone Number',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _positionController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Position',
                  ),
                ),
              ),
              // SizedBox(
              //   height: 11,
              // ),
              ElevatedButton(
                  onPressed: () async {
                    var prefs = await SharedPreferences.getInstance();
                    prefs.setString('Name', _nameController.text);
                    prefs.setString('Email', _emailController.text);
                    prefs.setString('Phone', _phoneController.text);
                    prefs.setString('Position', _positionController.text);
                    setState(() {});
                  },
                  // onPressed: (() async {
                  //   // var name = _nameController.text.toString();
                  //   var prefs = await SharedPreferences.getInstance();
                  //   prefs.setString(KEYNAME, _nameController.text.toString());
                  // }),
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.black),
                  )),
              FutureBuilder(
                future: getValue(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    Map data = snapshot.data as Map;

                    return ListTile(
                      title: Column(
                        children: [
                          Text(data['name'] ?? "Khali bharw ma aako haii"),
                          Text(data['phone'] ?? "Khali bharw ma aako haii"),
                          Text(data['email'] ?? "Khali bharw ma aako haii"),
                          Text(data['position'] ?? "Khali bharw ma aako haii"),
                        ],
                      ),
                      subtitle:
                          Text(data['phone'] ?? "Khali bharw ma aako haii"),
                    );
                  }
                  return CircularProgressIndicator();
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> getValue() async {
    var prefs = await SharedPreferences.getInstance();
    // prefs.get(KEYNAME);
    var getNAme = prefs.getString('Name');
    var getEmail = prefs.getString('Email');
    var getPhone = prefs.getString('Phone');
    var getPosition = prefs.getString('Position');

    return {
      'name': getNAme,
      'email': getEmail,
      'phone': getPhone,
      'position': getPosition,
    };
  }
}
