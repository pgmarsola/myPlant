import 'package:mobx/mobx.dart';
import 'package:my_plant/mobx_estruture/data.repository.dart';
import 'package:my_plant/models/applications.dart';
import 'package:my_plant/models/program.dart';

part 'data.controller.g.dart';

class ProgramController = _ProgramontrollerBase with _$ProgramController;

abstract class _ProgramontrollerBase with Store {
  ProgramRepository _monsterRepository;

  _ProgramontrollerBase() {
    _monsterRepository = ProgramRepository();
  }

  @observable
  Program program;

  @observable
  List<Applications> application;

  @observable
  bool isLoading = false;

  @action
  fetchPrograms() async {
    isLoading = true;
    program = await _monsterRepository.fetchProgram();

    if (program != null) {
      application = program.applications;
    }
    isLoading = false;
  }
}
