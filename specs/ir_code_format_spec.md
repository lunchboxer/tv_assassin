# IR Code Format Specifications for TV Assassin

## Overview
This document specifies the format and structure of IR codes used in the TV Assassin application. All codes are stored as hardcoded hexadecimal values in the `CommandRepository` class.

## Code Format

### Basic Structure
IR codes in TV Assassin follow this format:
```
0x[8-digit hexadecimal value]
```

### Example
```dart
// Samsung TV power off code
0xE0E040BF
```

## Technical Details

### Frequency
All codes are transmitted at 38kHz, which is the standard frequency for most consumer IR remote controls.

### Protocol
The codes use the NEC protocol, which is widely supported by television manufacturers. Each code represents a complete IR command sequence.

### Code Structure
Each 32-bit hexadecimal value contains:
1. Custom code (8 bits)
2. Custom code complement (8 bits) 
3. Data code (8 bits)
4. Data code complement (8 bits)

### Transmission Details
- Each code is transmitted 3 times with 80ms delays between transmissions
- This ensures reliable reception by TV IR receivers
- Transmission is handled by the Android `ConsumerIrManager` API

## Brand Coverage

### Supported Brands
The application currently supports IR codes for the following 15+ television brands:
1. Samsung
2. LG
3. Sony
4. Panasonic
5. Toshiba
6. Sharp
7. Vizio
8. Hisense
9. TCL
10. Philips
11. JVC
12. Sanyo
13. Mitsubishi
14. Insignia
15. Element

### Code Validation
Each brand must have at least one power-off code. Multiple codes per brand are supported for improved compatibility.

## Repository Structure
Codes are stored in a constant Map in the `CommandRepository` class:
```dart
static const Map<String, List<int>> _irCodes = {
  'BrandName': [
    0x[HEX_CODE], // Primary power off code
    0x[HEX_CODE], // Alternative power off code (optional)
  ],
};
```

## Adding New Brands
To add support for a new brand:
1. Research the NEC-format power-off codes for that brand
2. Verify the codes work with actual devices
3. Add the brand and codes to the `_irCodes` map in `CommandRepository`
4. Ensure codes follow the 0x[8-digit hex] format
5. Test thoroughly with real hardware if possible

## Quality Assurance
All codes are validated through:
1. Unit tests in `command_repository_test.dart`
2. Format verification (32-bit hexadecimal values)
3. Brand count validation (minimum 15 brands required)