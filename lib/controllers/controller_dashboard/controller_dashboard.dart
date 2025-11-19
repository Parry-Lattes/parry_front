import 'package:parry_front/controllers/controller_dashboard/struct_data.dart';

class ControllerDashboard {
  Future<StructData> get data async {
    await Future.delayed(Duration(seconds: 5)); // inventando o tempo de delay

    return StructData();
  }
}