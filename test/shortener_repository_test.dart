import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:url_shorten/core/key_value_store.dart';
import 'package:url_shorten/data/apis/shortener_apis.dart';
import 'package:url_shorten/data/repositories/url_shortening_repositories.dart';

class MockUrlShortenerApiOne extends Mock implements UrlShortenerApi {}

class MockUrlShortenerApiTwo extends Mock implements UrlShortenerApi {}

class MockDatabaseStore extends Mock implements DatabaseKvStore {}

void main() {
  group('tests for shortener repository', () {
    MockUrlShortenerApiOne apiOne;
    MockUrlShortenerApiTwo apiTwo;
    MockDatabaseStore databaseStore;

    setUp(() {
      databaseStore = MockDatabaseStore();
      apiOne = MockUrlShortenerApiOne();
      apiTwo = MockUrlShortenerApiTwo();
    });

    test('repository should call constructor provided api', () async {
      when(databaseStore.getString('http://www.google.com', def: '')).thenAnswer((_) async => '');
      final repository = UrlShorteningRepository(databaseStore, [apiOne, apiTwo]);

      final result = await repository.shorten('http://www.google.com');

      expect(result.isSuccess, true);
      verify(apiOne.shorten('http://www.google.com')).called(1);
    });

    test('repository should call function provided api', () async {
      when(databaseStore.getString('http://www.google.com', def: '')).thenAnswer((_) async => '');
      final repository = UrlShorteningRepository(databaseStore, [apiOne, apiTwo]);

      final result = await repository.shorten('http://www.google.com', service: apiTwo);

      expect(result.isSuccess, true);
      verify(apiTwo.shorten('http://www.google.com')).called(1);
      verifyNever(apiOne.shorten('http://www.google.com'));
    });

    test('repository should return short url', () async {
      when(databaseStore.getString('http://www.google.com', def: '')).thenAnswer((_) async => '');
      when(apiOne.shorten('http://www.google.com')).thenAnswer((_) async => 'shortenedUrl');

      final repository = UrlShorteningRepository(databaseStore, [apiOne, apiTwo]);

      final result = await repository.shorten('http://www.google.com');

      expect(result.isSuccess, true);
      verify(apiOne.shorten('http://www.google.com')).called(1);
      expect(result.value.shortenedUrl, 'shortenedUrl');
    });

    test('repository should retrieve from database ', () async {
      final store = <String, String>{};
      when(databaseStore.setString(any, any)).thenAnswer((i) async {
        store[i.positionalArguments[0]] = i.positionalArguments[1];
        return true;
      });
      when(databaseStore.getString(any, def: '')).thenAnswer((i) async => store[i.positionalArguments[0]] ?? '');
      when(apiOne.shorten('http://www.google.com')).thenAnswer((_) async => 'shortenedUrl');

      final repository = UrlShorteningRepository(databaseStore, [apiOne, apiTwo]);

      var result = await repository.shorten('http://www.google.com');

      expect(result.isSuccess, true);
      verify(apiOne.shorten('http://www.google.com')).called(1);
      verify(databaseStore.getString('http://www.google.com', def: '')).called(1);
      verify(databaseStore.setString('http://www.google.com', 'shortenedUrl')).called(1);
      expect(result.value.shortenedUrl, 'shortenedUrl');

      result = await repository.shorten('http://www.google.com');

      expect(result.isSuccess, true);
      verifyNever(apiOne.shorten('http://www.google.com'));
      verify(databaseStore.getString('http://www.google.com', def: '')).called(1);
      verifyNever(databaseStore.setString('http://www.google.com', 'shortenedUrl'));
      expect(result.value.shortenedUrl, 'shortenedUrl');
    });
  });
}
