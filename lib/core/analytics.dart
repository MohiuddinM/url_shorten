import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class Analytics {
  static final FirebaseAnalytics log = FirebaseAnalytics();
  static final FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: log);
}