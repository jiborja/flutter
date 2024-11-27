import 'package:domain/domain.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:infrastructure/src/analytics/anticorruption/event_translator.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AnalyticsRepository)
class AnalyticsFirebaseRepository implements AnalyticsRepository {
  AnalyticsFirebaseRepository({
    required FirebaseAnalytics firebaseAnalytics,
  }) : _firebaseAnalytics = firebaseAnalytics;

  final FirebaseAnalytics _firebaseAnalytics;

  @override
  Future<void> registerEvent(Event event) async {
    await _firebaseAnalytics.logEvent(
      name: event.name,
      parameters: EventTranslator.fromDomainToMap(event.data),
    );
  }
}
