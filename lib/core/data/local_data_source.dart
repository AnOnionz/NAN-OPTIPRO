import 'dart:async';
import 'package:flinq/flinq.dart';
import '../../core/common/keys.dart';
import '../../core/platform/date_time.dart';

abstract class LocalDataSource {

  const LocalDataSource();

  // DataToday get dataToday;
  // Future<void> cacheDataToday({
  //   bool? isCheckIn,
  // });
  // bool get hasDataNonSync;
  // Future<void> cacheReasons({required List<ReasonEntity> reasons});
  // List<ReasonEntity> getReasons();
  // List<VoucherEntity> getVouchers();
  // void cacheDelivery({required DeliveryEntity delivery});
  // void cacheDeliveryError({required DeliveryEntity delivery});
  // void cacheVoucherError({required VoucherEntity voucher});
  // List<DeliveryEntity> getDelivery();
  // List<DeliveryEntity> getDeliveryError();
  // Sync getSync();
}

class LocalDataSourceImpl extends LocalDataSource {

  const LocalDataSourceImpl();

  // @override
  // bool get hasDataNonSync {
  //   final sync = getSync();
  //   return sync.deliveries.isNotEmpty ||
  //       sync.errorDeliveries.isNotEmpty ||
  //       sync.errorVouchers.isNotEmpty;
  // }
  //
  // @override
  // DataToday get dataToday {
  //   final _dataTodayBox =
  //       Hive.box(AuthenticationBloc.loginEntity!.id.toString() + dataToDayBox);
  //   DataToday defaultData = DataToday(
  //     isCheckIn: false,
  //   );
  //   final result = _dataTodayBox.get(MyDateTime.today, defaultValue: defaultData);
  //   if (result == defaultData) {
  //     _dataTodayBox.put(MyDateTime.today, result!);
  //   }
  //   return result;
  // }
  //
  // @override
  // Future<void> cacheReasons({required List<ReasonEntity> reasons}) async {
  //   final Box<ReasonEntity> _reasonsBox =
  //       Hive.box(AuthenticationBloc.loginEntity!.id.toString() + reasonsBox);
  //   await _reasonsBox.clear();
  //   await _reasonsBox.addAll(reasons);
  // }
  //
  // @override
  // List<ReasonEntity> getReasons() {
  //   final Box<ReasonEntity> _reasonsBox =
  //       Hive.box(AuthenticationBloc.loginEntity!.id.toString() + reasonsBox);
  //   return _reasonsBox.values.toList();
  // }
  //
  // @override
  // Sync getSync() {
  //   final Box<DeliveryEntity> _deliveryBox =
  //       Hive.box(AuthenticationBloc.loginEntity!.id.toString() + deliveryBox);
  //   final Box<DeliveryEntity> _deliveryErrorBox = Hive.box(
  //       AuthenticationBloc.loginEntity!.id.toString() + deliveryErrorBox);
  //   final Box<VoucherEntity> _voucherErrorBox = Hive.box(
  //       AuthenticationBloc.loginEntity!.id.toString() + voucherErrorBox);
  //   return Sync(
  //       deliveries: _deliveryBox.values
  //           .whereList((delivery) => delivery.isSync == false),
  //       errorDeliveries: _deliveryErrorBox.values
  //           .whereList((delivery) => delivery.isSync == false),
  //       errorVouchers: _voucherErrorBox.values
  //           .whereList((voucher) => voucher.isSync == false));
  // }
  //
  // @override
  // Future<void> cacheDataToday({bool? isCheckIn}) async {
  //   final data = dataToday;
  //   data.isCheckIn = isCheckIn ?? data.isCheckIn;
  //   await data.save();
  // }
  //
  // @override
  // void cacheDelivery({required DeliveryEntity delivery}) {
  //   final Box<DeliveryEntity> _box =
  //       Hive.box(AuthenticationBloc.loginEntity!.id.toString() + deliveryBox);
  //   _box.add(delivery);
  // }
  //
  // @override
  // void cacheDeliveryError({required DeliveryEntity delivery}) {
  //   final Box<DeliveryEntity> _box = Hive.box(
  //       AuthenticationBloc.loginEntity!.id.toString() + deliveryErrorBox);
  //   _box.add(delivery);
  // }
  //
  // @override
  // void cacheVoucherError({required VoucherEntity voucher}) {
  //   final Box<VoucherEntity> _box = Hive.box(
  //       AuthenticationBloc.loginEntity!.id.toString() + voucherErrorBox);
  //   _box.add(voucher);
  // }
  //
  // @override
  // List<DeliveryEntity> getDelivery() {
  //   final Box<DeliveryEntity> _box =
  //       Hive.box(AuthenticationBloc.loginEntity!.id.toString() + deliveryBox);
  //   List<DeliveryEntity> deliveries = _box.values.toList();
  //   return deliveries;
  // }
  //
  // @override
  // List<VoucherEntity> getVouchers() {
  //   final deliveries = getDelivery();
  //   return deliveries
  //       .mapList((delivery) => delivery.vouchers)
  //       .expand((element) => element)
  //       .toList();
  // }
  //
  // @override
  // List<DeliveryEntity> getDeliveryError() {
  //   final Box<DeliveryEntity> _box = Hive.box(
  //       AuthenticationBloc.loginEntity!.id.toString() + deliveryErrorBox);
  //   List<DeliveryEntity> deliveries = _box.values.toList();
  //   return deliveries;
  // }
}
