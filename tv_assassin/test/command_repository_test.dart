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

    test('should have valid code format', () {
      final allCodes = repository.getAllShutdownCodes();
      
      // Verify all codes are valid 32-bit integers
      for (final code in allCodes) {
        // Check that code is not null
        expect(code, isNotNull);
        
        // Check that code is a valid integer
        expect(code, isA<int>());
        
        // Check that code is within 32-bit range (0 to 0xFFFFFFFF)
        expect(code, greaterThanOrEqualTo(0));
        expect(code, lessThanOrEqualTo(0xFFFFFFFF));
        
        // Check that code is not zero (which would be invalid)
        expect(code, isNot(0));
      }
      
      // Also verify a known code format for Samsung
      final samsungCodes = repository.getCodesForBrand('Samsung');
      expect(samsungCodes, isNotNull);
      expect(samsungCodes!.isNotEmpty, isTrue);
      
      // Samsung codes should start with 0xE0E0 (common prefix for Samsung remotes)
      final firstSamsungCode = samsungCodes[0];
      final samsungPrefix = (firstSamsungCode >> 16) & 0xFFFF;
      expect(samsungPrefix, 0xE0E0);
    });
  });
}
