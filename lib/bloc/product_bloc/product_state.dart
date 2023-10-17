
import 'package:equatable/equatable.dart';
import 'package:machinetest_intellect/Model/product_model.dart';
import 'package:machinetest_intellect/Model/register_model.dart';


class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProductInitialState extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoadingState extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoadedState extends ProductState {
  final RegisterModel productlistmodel;

  ProductLoadedState({required this.productlistmodel});

  @override
  List<Object> get props => [];
}

class ProductErrorState extends ProductState {
  String message;

  ProductErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
