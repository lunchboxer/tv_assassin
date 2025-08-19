abstract class IRService {
  /// Check if IR hardware is available on the device
  Future<bool> get isAvailable;

  /// Transmit a list of IR codes
  Future<void> transmitCodes(List<int> codes);
}
