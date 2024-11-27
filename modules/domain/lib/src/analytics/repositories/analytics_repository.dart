import 'package:domain/src/analytics/model/event.dart';

abstract class AnalyticsRepository {
  Future<void> registerEvent(Event event);
}
