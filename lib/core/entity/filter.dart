import 'package:equatable/equatable.dart';



class Filter extends Equatable{
  int skip;
  int take;
  String outletCode;

  Filter({required this.skip, required this.take, required this.outletCode});

  @override
  List<Object?> get props => [skip, take, outletCode];

}