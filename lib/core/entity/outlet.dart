import 'package:equatable/equatable.dart';

class OutletEntity extends Equatable {
  final int id;
  final String code;
  final String name;
  final String address;

  OutletEntity({required this.id, required this.code, required this.name, required this.address});

  factory OutletEntity.fromJson(Map<String, dynamic> json) {
    return OutletEntity( id: json['id'],
        code: json['code'], name: json['name'], address: json['address']);
  }

  @override
  List<Object?> get props => [id, code, name, address];
}
