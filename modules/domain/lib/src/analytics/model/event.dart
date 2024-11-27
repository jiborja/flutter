import 'package:domain/src/shared/exceptions/empty_param_exception.dart';

class Event {
  Event({required this.name, required this.data}) {
    if (name.isEmpty) throw EmptyParamException(param: 'name');
    if (data.isEmpty) throw EmptyParamException(param: 'data');
  }

  final String name;
  final String data;
}
