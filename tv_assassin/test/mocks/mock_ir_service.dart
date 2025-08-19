import 'package:tv_assassin/services/ir_service.dart';

/// Mock implementation of IRService for testing
class MockIRService implements IRService {
  bool _isAvailable = true;
  bool _shouldThrowOnAvailabilityCheck = false;
  bool _shouldThrowOnTransmission = false;
  List<int> _lastTransmittedCodes = [];
  int _transmitCallCount = 0;
  Duration _transmitDelay = Duration.zero;

  @override
  Future<bool> get isAvailable async {
    if (_shouldThrowOnAvailabilityCheck) {
      throw Exception('IR service error');
    }
    return _isAvailable;
  }

  @override
  Future<void> transmitCodes(List<int> codes) async {
    if (_shouldThrowOnTransmission) {
      throw Exception('Transmission failed');
    }
    
    _lastTransmittedCodes = List<int>.from(codes);
    _transmitCallCount++;
    
    // Simulate transmission delay if set
    if (_transmitDelay > Duration.zero) {
      await Future.delayed(_transmitDelay);
    }
  }

  /// Set whether IR hardware should be available
  void setAvailable(bool available) {
    _isAvailable = available;
  }

  /// Set whether the availability check should throw an exception
  void setShouldThrowOnAvailabilityCheck(bool shouldThrow) {
    _shouldThrowOnAvailabilityCheck = shouldThrow;
  }

  /// Set whether transmission should throw an exception
  void setShouldThrowOnTransmission(bool shouldThrow) {
    _shouldThrowOnTransmission = shouldThrow;
  }

  /// Get the last transmitted codes
  List<int> get lastTransmittedCodes => _lastTransmittedCodes;

  /// Get the number of times transmitCodes was called
  int get transmitCallCount => _transmitCallCount;

  /// Set a delay for transmission to simulate real transmission time
  void setTransmitDelay(Duration delay) {
    _transmitDelay = delay;
  }

  /// Reset the mock to initial state
  void reset() {
    _isAvailable = true;
    _shouldThrowOnAvailabilityCheck = false;
    _shouldThrowOnTransmission = false;
    _lastTransmittedCodes = [];
    _transmitCallCount = 0;
    _transmitDelay = Duration.zero;
  }
}