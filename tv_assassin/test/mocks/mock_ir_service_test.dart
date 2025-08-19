import 'package:flutter_test/flutter_test.dart';
import 'mock_ir_service.dart';

void main() {
  group('MockIRService', () {
    late MockIRService mockIRService;

    setUp(() {
      mockIRService = MockIRService();
    });

    tearDown(() {
      mockIRService.reset();
    });

    test('should be initially available', () async {
      final isAvailable = await mockIRService.isAvailable;
      expect(isAvailable, isTrue);
    });

    test('should return correct availability status', () async {
      mockIRService.setAvailable(false);
      expect(await mockIRService.isAvailable, isFalse);

      mockIRService.setAvailable(true);
      expect(await mockIRService.isAvailable, isTrue);
    });

    test(
      'should throw exception when availability check is set to throw',
      () async {
        mockIRService.setShouldThrowOnAvailabilityCheck(true);

        expect(() => mockIRService.isAvailable, throwsA(isA<Exception>()));
      },
    );

    test('should transmit codes successfully', () async {
      final codes = [0xE0E040BF, 0xE0E0807F];

      await mockIRService.transmitCodes(codes);

      expect(mockIRService.lastTransmittedCodes, equals(codes));
      expect(mockIRService.transmitCallCount, equals(1));
    });

    test('should throw exception when transmission is set to throw', () async {
      mockIRService.setShouldThrowOnTransmission(true);

      expect(
        () => mockIRService.transmitCodes([0xE0E040BF]),
        throwsA(isA<Exception>()),
      );
    });

    test('should track multiple transmissions', () async {
      final codes1 = [0xE0E040BF];
      final codes2 = [0xE0E0807F, 0x20DF10EF];

      await mockIRService.transmitCodes(codes1);
      await mockIRService.transmitCodes(codes2);

      expect(mockIRService.lastTransmittedCodes, equals(codes2));
      expect(mockIRService.transmitCallCount, equals(2));
    });

    test('should simulate transmission delay', () async {
      final codes = [0xE0E040BF];
      mockIRService.setTransmitDelay(Duration(milliseconds: 100));

      final stopwatch = Stopwatch()..start();
      await mockIRService.transmitCodes(codes);
      stopwatch.stop();

      expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(90));
      expect(stopwatch.elapsedMilliseconds, lessThanOrEqualTo(150));
    });

    test('should reset to initial state', () async {
      // Set up some state
      mockIRService.setAvailable(false);
      mockIRService.setShouldThrowOnAvailabilityCheck(false);
      mockIRService.setShouldThrowOnTransmission(false);
      mockIRService.setTransmitDelay(Duration(milliseconds: 100));

      // Verify state is changed
      expect(await mockIRService.isAvailable, isFalse);

      await mockIRService.transmitCodes([0xE0E040BF]);

      expect(mockIRService.transmitCallCount, equals(1));

      // Reset and verify initial state
      mockIRService.reset();

      expect(await mockIRService.isAvailable, isTrue);
      expect(mockIRService.transmitCallCount, equals(0));
      expect(mockIRService.lastTransmittedCodes, isEmpty);
    });
  });
}
