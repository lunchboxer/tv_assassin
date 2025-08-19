import 'package:flutter_test/flutter_test.dart';
import 'package:tv_assassin/repository/command_repository.dart';

void main() {
  group('CommandRepository', () {
    late CommandRepository repository;

    setUp(() {
      repository = CommandRepository();
    });

    test('should have at least 15 brands', () {
      expect(repository.brandCount, greaterThanOrEqualTo(15));
    });

    test('should have Samsung brand with codes', () {
      final codes = repository.getCodesForBrand('Samsung');
      expect(codes, isNotNull);
      expect(codes!.length, greaterThan(0));
    });

    test('should return null for non-existent brand', () {
      final codes = repository.getCodesForBrand('NonExistentBrand');
      expect(codes, isNull);
    });

    test('should return all brands as list', () {
      final brands = repository.getAllBrands();
      expect(brands, isNotEmpty);
      expect(brands.contains('Samsung'), isTrue);
      expect(brands.contains('LG'), isTrue);
    });

    test('should flatten all codes correctly', () {
      final allCodes = repository.getAllShutdownCodes();
      expect(allCodes, isNotEmpty);
      expect(allCodes.length, repository.totalCodeCount);
    });

    test('should have reasonable total code count', () {
      final allCodes = repository.getAllShutdownCodes();
      // We expect at least 15 brands with at least 1 code each
      expect(allCodes.length, greaterThanOrEqualTo(15));
    });
  });
}
