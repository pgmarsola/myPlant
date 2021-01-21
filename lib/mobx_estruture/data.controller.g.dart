// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProgramController on _ProgramontrollerBase, Store {
  final _$programAtom = Atom(name: '_ProgramontrollerBase.program');

  @override
  Program get program {
    _$programAtom.reportRead();
    return super.program;
  }

  @override
  set program(Program value) {
    _$programAtom.reportWrite(value, super.program, () {
      super.program = value;
    });
  }

  final _$applicationAtom = Atom(name: '_ProgramontrollerBase.application');

  @override
  List<Applications> get application {
    _$applicationAtom.reportRead();
    return super.application;
  }

  @override
  set application(List<Applications> value) {
    _$applicationAtom.reportWrite(value, super.application, () {
      super.application = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_ProgramontrollerBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$fetchProgramsAsyncAction =
      AsyncAction('_ProgramontrollerBase.fetchPrograms');

  @override
  Future fetchPrograms() {
    return _$fetchProgramsAsyncAction.run(() => super.fetchPrograms());
  }

  @override
  String toString() {
    return '''
program: ${program},
application: ${application},
isLoading: ${isLoading}
    ''';
  }
}
