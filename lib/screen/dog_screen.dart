import 'package:flutter/material.dart';
import 'package:api_request/model/dog.dart';
import 'package:api_request/services/api_services.dart';

class DogScreen extends StatefulWidget {
  const DogScreen({super.key});

  @override
  State<DogScreen> createState() => _DogScreenState();
}

class _DogScreenState extends State<DogScreen> {
  late Future<List<Dog>> dogs;
  late ApiServices apiServices;

  @override
  void initState() {
    super.initState();
    apiServices = ApiServices();
    dogs = fetchThreeDogs();
  }

  Future<List<Dog>> fetchThreeDogs() async {
    List<Dog> dogList = [];
    for (int i = 0; i < 3; i++) {
      Dog dog = await apiServices.fetchDog();
      dogList.add(dog);
    }
    return dogList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Dogs from API'),
      ),
      body: FutureBuilder<List<Dog>>(
        future: dogs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: snapshot.data!.map((dog) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Container(
                        height: 250,
                        child: Image.network(dog.message, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          } else {
            return Center(child: Text('No data found'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            dogs = fetchThreeDogs();
          });
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
