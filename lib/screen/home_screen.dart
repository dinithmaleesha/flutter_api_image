import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_request/bloc/dog_bloc.dart';
import 'package:api_request/bloc/dog_event.dart';
import 'package:api_request/bloc/dog_state.dart';
import 'package:api_request/model/dog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Dogs from API'),
      ),
      body: BlocBuilder<DogBloc, DogState>(
        builder: (context, state) {
          if (state is DogLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is DogErrorState) {
            return Center(child: Text('Error'));
          } else if (state is DogLoadedState) {;
            if (state.dogs.isEmpty) {
              return Center(child: Text('No dogs found!'));
            }
            return ListView.builder(
              itemCount: state.dogs.length,
              itemBuilder: (context, index) {
                Dog dog = state.dogs[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        dog.message,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data found!'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<DogBloc>(context).add(FetchDogEvent());
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
