import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:tv_assassin/repository/command_repository.dart';
import 'package:tv_assassin/services/android_ir_service.dart';
import 'package:tv_assassin/services/ir_service.dart';

/// Main view model that manages the application state
class MainViewModel with ChangeNotifier {
  final IRService _irService;
  final CommandRepository _commandRepository;

  bool _isIrReady = false;
  bool _isTransmitting = false;
  String? _errorMessage;

  MainViewModel({IRService? irService, CommandRepository? commandRepository})
    : _irService = irService ?? AndroidIRService(),
      _commandRepository = commandRepository ?? CommandRepository() {
    // Check IR hardware availability when view model is created
    _checkIrHardware();
  }

  /// Whether IR hardware is available and ready
  bool get isIrReady => _isIrReady;

  /// Whether transmission is currently in progress
  bool get isTransmitting => _isTransmitting;

  /// Any error message to display
  String? get errorMessage => _errorMessage;

  /// Check if IR hardware is available
  Future<void> _checkIrHardware() async {
    try {
      _isIrReady = await _irService.isAvailable;
      _errorMessage = _isIrReady ? null : 'IR hardware not available';
    } catch (e) {
      _isIrReady = false;
      _errorMessage = 'Error checking IR hardware: ${e.toString()}';
    }

    notifyListeners();
  }

  /// Start the transmission process
  void startTransmission() {
    if (_isTransmitting) return;

    _isTransmitting = true;
    _errorMessage = null;
    notifyListeners();
  }

  /// End the transmission process with haptic feedback
  void endTransmission() {
    _isTransmitting = false;

    // Provide haptic feedback on completion
    _provideHapticFeedback();

    notifyListeners();
  }

  /// Provide haptic feedback
  void _provideHapticFeedback() {
    HapticFeedback.mediumImpact();
  }

  /// Transmit all shutdown codes to nearby TVs
  Future<void> transmitAllShutdownCodes() async {
    if (!_isIrReady) {
      _errorMessage = 'IR hardware not available';
      notifyListeners();
      return;
    }

    if (_isTransmitting) return;

    startTransmission();

    try {
      final codes = _commandRepository.getAllShutdownCodes();
      await _irService.transmitCodes(codes);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      endTransmission();
    }
  }

  /// Re-check IR hardware availability
  Future<void> recheckIrHardware() async {
    await _checkIrHardware();
  }
}
