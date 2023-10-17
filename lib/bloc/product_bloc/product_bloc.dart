import 'package:bloc/bloc.dart';
import 'package:machinetest_intellect/RestApi/domain/repositories/product_repository.dart';


import 'product_event.dart';
import 'product_state.dart';



class ProductBloc extends Bloc<ProductEvent,ProductState> {
  ProductBloc() : super(ProductInitialState()) {
    on<ProductEvent>((event, emit) async {
      emit(ProductLoadingState());
      try {
        if (event is FetchProductEvent) {
          var pdscreen = await Repository().getregister(event.username,event.email,event.password);
          emit(ProductLoadedState(productlistmodel: pdscreen));
        }
      } catch (e) {
        emit(ProductErrorState(message: e.toString()));
      }
    });
  }
}
