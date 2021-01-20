import 'package:my_plant/models/program.dart';

abstract class IProgramRepository {
  Future<Program> fetchProgram();
}
