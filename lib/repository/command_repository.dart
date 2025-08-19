/// Repository for IR command codes for various TV brands
class CommandRepository {
  // IR codes are stored as const Map for compile-time initialization
  // Format: Map<String, List<int>> where key is brand name and value is list of hex codes
  static const Map<String, List<int>> _irCodes = {
    // Samsung TV power off codes
    'Samsung': [
      0xE0E040BF, // Power off
      0xE0E0807F, // Power (alternative)
    ],

    // LG TV power off codes
    'LG': [
      0x20DF10EF, // Power off
    ],

    // Sony TV power off codes
    'Sony': [
      0xA90F04FB, // Power off
    ],

    // Panasonic TV power off codes
    'Panasonic': [
      0x40040109, // Power off
    ],

    // Toshiba TV power off codes
    'Toshiba': [
      0xF20D04FB, // Power off
    ],

    // Sharp TV power off codes
    'Sharp': [
      0xAA5504FB, // Power off
    ],

    // Vizio TV power off codes
    'Vizio': [
      0x703AC03F, // Power off
    ],

    // Hisense TV power off codes
    'Hisense': [
      0x4CB304FB, // Power off
    ],

    // TCL TV power off codes
    'TCL': [
      0x48B704FB, // Power off
    ],

    // Philips TV power off codes
    'Philips': [
      0xD82704FB, // Power off
    ],

    // JVC TV power off codes
    'JVC': [
      0xC13E04FB, // Power off
    ],

    // Sanyo TV power off codes
    'Sanyo': [
      0x55AA04FB, // Power off
    ],

    // Mitsubishi TV power off codes
    'Mitsubishi': [
      0xCD3204FB, // Power off
    ],

    // Insignia TV power off codes
    'Insignia': [
      0xF50A04FB, // Power off
    ],

    // Element TV power off codes
    'Element': [
      0xE51A04FB, // Power off
    ],
  };

  /// Get all shutdown codes for all brands as a flattened list
  List<int> getAllShutdownCodes() {
    return _irCodes.values.expand((codes) => codes).toList();
  }

  /// Get shutdown codes for a specific brand
  List<int>? getCodesForBrand(String brand) {
    return _irCodes[brand];
  }

  /// Get list of all supported brands
  List<String> getAllBrands() {
    return _irCodes.keys.toList();
  }

  /// Get count of supported brands
  int get brandCount => _irCodes.length;

  /// Get total count of all codes
  int get totalCodeCount =>
      _irCodes.values.fold(0, (sum, codes) => sum + codes.length);
}
