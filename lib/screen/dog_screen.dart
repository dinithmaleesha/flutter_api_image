import 'package:api_request/bloc/dog_bloc.dart';
import 'package:api_request/bloc/dog_event.dart';
import 'package:api_request/bloc/dog_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_request/model/dog.dart';

class DogScreen extends StatelessWidget {
  const DogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DogBloc(),
      child: DogScreenBody(),
    );
  }
}

class DogScreenBody extends StatefulWidget {
  @override
  _DogScreenBodyState createState() => _DogScreenBodyState();
}

class _DogScreenBodyState extends State<DogScreenBody> {
  late DogBloc _dogBloc;

  @override
  void initState() {
    super.initState();
    _dogBloc = BlocProvider.of<DogBloc>(context);
    _dogBloc.add(FetchDogEvent());
  }

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
            return Center(child: Text('Error: ${state.error}'));
          } else if (state is DogLoadedState) {
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
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
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
            return Center(child: Text('No data found'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _dogBloc.add(FetchDogEvent());
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  @override
  void dispose() {
    _dogBloc.close();
    super.dispose();
  }
}

