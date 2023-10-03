import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



/*
class API extends StatelessWidget {
  const API({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: API11(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  _API11State createState() => _API11State();
}

class _API11State extends State<API11> {
  String _data = 'No data yet';

  // Function to make a GET request to the API
  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://development.frontbitsolutions.com/my_api/api.php?package_name=com.Eventplanner&api_key=Denish123'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        _data = jsonData['title'];
      });
    } else {
      setState(() {
        _data = 'Failed to load data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API GET Request Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Data from API:',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            Text(
              _data,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchData,
              child: const Text('Fetch Data'),
            ),
          ],
        ),
      ),
    );
  }
}



class API2 extends StatefulWidget {
  const API2({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _API2State createState() => _API2State();
}

class _API2State extends State<API2> {
  String _apiResponse = 'No data';

  // Function to make a GET request to the API
  Future<void> fetchData() async {
    final response = await http.post(Uri.parse(
        'https://development.frontbitsolutions.com/my_api/api.php?package_name=com.Eventplanner&api_key=Denish123'));

    final jsonData = json.decode(response.body);
    final title = jsonData['extra'];
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {}

    if (kDebugMode) {
      print("======$jsonData");
    }
    if (kDebugMode) {
      print("======$title");
    }

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        _apiResponse = 'Title:${jsonData['title']}\nBody: ${jsonData['body']}';
      });
    } else {
      setState(() {
        _apiResponse = 'Failed to load data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Call Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'API Response:',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            Text(
              _apiResponse,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchData,
              child: const Text('Fetch Data'),
            ),
          ],
        ),
      ),
    );
  }
}




*/






/*class APi1 extends StatefulWidget {
  const APi1({Key? key}) : super(key: key);

  @override
  _APi1State createState() => _APi1State();
}

class _APi1State extends State<APi1> {
  List<dynamic> responseData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse(
          'https://development.frontbitsolutions.com/my_api/api.php?package_name=com.Eventplanner&api_key=Denish123'), // Replace with your API URL
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> apiData = jsonData['home_slaider'];

      setState(() {
        responseData = List<dynamic>.from(apiData);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: ListView.builder(
        itemCount: responseData.length,
        itemBuilder: (context, index) {
          final item = responseData[index];
          final String sliderName = item['slaider_name'];
          final String imageUrl = item['image'];

          return ListTile(
            title: Text(sliderName),
            leading: Image.network(imageUrl),
          );
        },
      ),
    );
  }
}*/




class APi1 extends StatefulWidget {
  const APi1({Key? key}) : super(key: key);

  @override
  _APi1State createState() => _APi1State();
}

class _APi1State extends State<APi1> {
  List<Map<String, dynamic>> apiData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse(
          'https://development.frontbitsolutions.com/my_api/api.php?package_name=com.Eventplanner&api_key=Denish123'), // Replace with your API URL
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> sliderData = jsonData['home_slaider'];

      setState(() {
        apiData = List<Map<String, dynamic>>.from(sliderData);
      });
    } else {
      // Handle the case where the API request failed
      print('API request failed with status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('API Data Example'),
        ),
        body: apiData.isEmpty
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
          itemCount: apiData.length,
          itemBuilder: (context, index) {
            final item = apiData[index];
            final String sliderName = item['slaider_name'];
            final String imageUrl = item['image'];

            return Card(
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(sliderName),
                leading: Image.network(imageUrl), // Assuming imageUrl is a valid URL
              ),
            );
          },
        ),
      ),
    );
  }
}



class Update extends StatelessWidget {
  const Update({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Update Dialog Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              _showUpdateDialog(context);
            },
            child: Text('Show Update Dialog'),
          ),
        ),
      ),
    );
  }

  Future<void> _showUpdateDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Disallow tapping outside of the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Available'),
          content: Text('A new version of the app is available.'),
          actions: <Widget>[
            TextButton(
              child: Text('Force Update'),
              onPressed: () {
                // Add your force update logic here
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Skip Update'),
              onPressed: () {
                // Add your skip update logic here
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Maintenance Mode'),
              onPressed: () {
                // Add your maintenance mode logic here
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
