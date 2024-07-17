import 'package:api_request/bloc/dog_event.dart';
import 'package:api_request/bloc/dog_state.dart';
import 'package:api_request/services/api_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_request/model/dog.dart';

class DogBloc extends Bloc<DogEvent, DogState> {
  final ApiServices apiServices = ApiServices();
  late List<Dog> _dogs;

  DogBloc() : super(DogInitialState()) {
    _dogs = [];
    on<FetchDogEvent>(_onFetchDogs);
  }

  Future<void> _onFetchDogs(FetchDogEvent event, Emitter<DogState> emit) async {
    print('Loading..');
    emit(DogLoadingState());
    try {
      print('Clear previous dogs images');
      _dogs.clear(); // clear previous dog
      // Fetch three dogs
      for (int i = 0; i < 3; i++) {
        Dog dog = await apiServices.fetchDog();
        _dogs.add(dog);
        print('Fetched ${(i + 1).toString()} dog...');
      }
      emit(DogLoadedState(List.from(_dogs)));
      print('Dog images loaded!');
    } catch (e) {
      print(e.toString());
      emit(DogErrorState(e.toString()));
    }
  }
}
