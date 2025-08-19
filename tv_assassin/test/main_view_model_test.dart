import 'package:flutter_test/flutter_test.dart';
import 'package:tv_assassin/repository/command_repository.dart';
import 'package:tv_assassin/services/ir_service.dart';
import 'package:tv_assassin/viewmodel/main_view_model.dart';

/// Mock IR service for testing
class MockIRService implements IRService {
  bool _isAvailable = true;
  bool shouldThrow = false;

  @override
  Future<bool> get isAvailable async {
    if (shouldThrow) {
      throw Exception('IR service error');
    }
    return _isAvailable;
  }

  @override
  Future<void> transmitCodes(List<int> codes) async {
    if (shouldThrow) {
      throw Exception('Transmission failed');
    }
  }

  void setAvailable(bool available) {
    _isAvailable = available;
  }
}

void main() {
  group('MainViewModel', () {
    late MockIRService mockIRService;
    late CommandRepository commandRepository;

    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      mockIRService = MockIRService();
      commandRepository = CommandRepository();
    });

    test('should initialize with default values', () async {
      // Create view model and wait for initialization
      final newViewModel = MainViewModel(
        irService: mockIRService,
        commandRepository: commandRepository,
      );

      // Initially should be false while checking
      expect(newViewModel.isIrReady, isFalse);

      // Wait a bit for async initialization
      await Future.delayed(Duration(milliseconds: 10));

      // Should be true with our mock
      expect(newViewModel.isIrReady, isTrue);
      expect(newViewModel.isTransmitting, isFalse);
      expect(newViewModel.errorMessage, isNull);
    });

    test('should check IR hardware availability', () async {
      final newViewModel = MainViewModel(
        irService: mockIRService,
        commandRepository: commandRepository,
      );

      // Initially should be false while checking
      expect(newViewModel.isIrReady, isFalse);

      // Wait for the constructor to finish checking hardware
      await Future.delayed(Duration(milliseconds: 10));

      // Should be true with our mock
      expect(newViewModel.isIrReady, isTrue);
    });

    test('should handle IR hardware unavailable', () async {
      mockIRService.setAvailable(false);
      final newViewModel = MainViewModel(
        irService: mockIRService,
        commandRepository: commandRepository,
      );

      // Wait for the constructor to finish checking hardware
      await Future.delayed(Duration(milliseconds: 10));

      expect(newViewModel.isIrReady, isFalse);
      expect(newViewModel.errorMessage, isNotNull);
    });

    test('should handle IR service error', () async {
      mockIRService.shouldThrow = true;
      final newViewModel = MainViewModel(
        irService: mockIRService,
        commandRepository: commandRepository,
      );

      // Wait for the constructor to finish checking hardware
      await Future.delayed(Duration(milliseconds: 10));

      expect(newViewModel.isIrReady, isFalse);
      expect(newViewModel.errorMessage, isNotNull);
    });

    test('should start and end transmission', () {
      // Create with available IR service
      final newViewModel = MainViewModel(
        irService: mockIRService,
        commandRepository: commandRepository,
      );

      expect(newViewModel.isTransmitting, isFalse);

      newViewModel.startTransmission();
      expect(newViewModel.isTransmitting, isTrue);

      newViewModel.endTransmission();
      expect(newViewModel.isTransmitting, isFalse);
    });

    test('should not start transmission if already transmitting', () {
      // Create with available IR service
      final newViewModel = MainViewModel(
        irService: mockIRService,
        commandRepository: commandRepository,
      );

      newViewModel.startTransmission();
      expect(newViewModel.isTransmitting, isTrue);

      // Try to start again
      newViewModel.startTransmission();
      expect(newViewModel.isTransmitting, isTrue); // Should still be true
    });

    test('should transmit all shutdown codes', () async {
      // Create with available IR service
      final newViewModel = MainViewModel(
        irService: mockIRService,
        commandRepository: commandRepository,
      );

      // Wait for the constructor to finish checking hardware
      await Future.delayed(Duration(milliseconds: 10));

      expect(newViewModel.isIrReady, isTrue);
      expect(newViewModel.isTransmitting, isFalse);

      await newViewModel.transmitAllShutdownCodes();

      // Should have finished transmitting
      expect(newViewModel.isTransmitting, isFalse);
    });

    test('should handle transmission with IR hardware unavailable', () async {
      mockIRService.setAvailable(false);
      final newViewModel = MainViewModel(
        irService: mockIRService,
        commandRepository: commandRepository,
      );

      // Wait for the constructor to finish checking hardware
      await Future.delayed(Duration(milliseconds: 10));

      await newViewModel.transmitAllShutdownCodes();

      expect(newViewModel.errorMessage, isNotNull);
      expect(newViewModel.errorMessage, contains('IR hardware not available'));
    });
  });
}
