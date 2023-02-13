
abstract class NetworkInfo{
  Future<bool> get isConnected;

}
class NetworkInfoImpl extends NetworkInfo{

  NetworkInfoImpl();
  @override
  Future<bool> get isConnected async => true;




}