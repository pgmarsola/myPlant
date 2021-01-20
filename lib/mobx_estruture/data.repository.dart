import 'package:my_plant/mobx_estruture/data.repository.interface.dart';
import 'package:my_plant/models/program.dart';
import 'package:my_plant/data/json.dart';

class ProgramRepository extends IProgramRepository {
  JsonData _jsonData = JsonData();

  @override
  Future<Program> fetchProgram() async {
    try {
      var response = _jsonData;
      if (response != null) {
        var program = Program.fromJson(response.data);
        return program;
      } else {
        print('Erro ao obter dados');
        return null;
      }
    } catch (e) {
      print('$e');
      return null;
    }
  }
}
