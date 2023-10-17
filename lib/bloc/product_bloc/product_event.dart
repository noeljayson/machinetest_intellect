import 'package:equatable/equatable.dart';

class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProductEvent extends ProductEvent {
  final  String username,email,password;
  FetchProductEvent(this.username, this.email, this.password);
  @override
  List<Object> get props => [];
}
