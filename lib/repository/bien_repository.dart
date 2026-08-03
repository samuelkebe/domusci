import '../models/request/create_bien_request.dart';
import '../web-services/bien_service.dart';

class BienRepository {
  final BienService _service;

  BienRepository(this._service);

  Future<String?> createBien(CreateBienRequest request) async {
    final data = request.toJson();
    return await _service.createBien(data);
  }
}
