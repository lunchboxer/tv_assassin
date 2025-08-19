# Developer Guide: Adding New TV Brands to TV Assassin

## Overview
This guide explains how to add support for new TV brands to the TV Assassin application. The process involves researching IR codes, adding them to the repository, and verifying functionality.

## Prerequisites
- Basic understanding of Dart and Flutter
- Access to IR code databases or physical remote controls
- IR-capable Android device for testing (optional but recommended)

## Step-by-Step Process

### 1. Research IR Codes
Before adding a new brand, you need to find the correct IR codes:
- Search online databases like RemoteCentral or Hifi-Remote
- Use IR code scanning apps to capture codes from physical remotes
- Ensure codes are in NEC protocol format (32-bit hexadecimal values)

### 2. Verify Code Format
All codes must follow the standard format:
- 32-bit hexadecimal values (8 digits with 0x prefix)
- Example: `0xE0E040BF`
- Must be power-off or power-toggle commands

### 3. Add Codes to CommandRepository
1. Open `lib/repository/command_repository.dart`
2. Locate the `_irCodes` Map
3. Add a new entry with the brand name as key and codes as values:

```dart
static const Map<String, List<int>> _irCodes = {
  // Existing brands...
  
  // Add your new brand here:
  'NewBrandName': [
    0x[HEX_CODE], // Primary power off code
    0x[HEX_CODE], // Alternative code (optional)
  ],
};
```

### 4. Follow Naming Conventions
- Use the official brand name (e.g., "Samsung" not "samsung" or "SAMSUNG")
- Maintain alphabetical order in the map for readability
- Use descriptive comments for each code if needed

### 5. Update Documentation
When adding new brands:
- Update the brand count in relevant documentation
- Add any special notes about the brand's IR implementation
- Ensure all codes are properly formatted

## Testing New Brands

### Unit Tests
The existing unit tests will automatically verify your new brand:
- Run `flutter test` to ensure all tests pass
- The `CommandRepository` tests validate brand count and code formats

### Manual Testing
If possible, test with actual hardware:
1. Build the app in debug mode: `flutter run`
2. Press the "Kill TVs" button
3. Verify TVs of the new brand turn off

## Best Practices

### Code Quality
- Keep the repository focused on power-off codes only
- Avoid adding unnecessary codes that increase app size
- Maintain const values for compile-time optimization

### Brand Selection
- Focus on major television brands for maximum impact
- Prioritize brands with significant market share
- Verify codes work with multiple models of the same brand

### Error Handling
All IR transmission errors are handled at the service layer:
- `IrUnavailableException` for missing hardware
- `TransmissionFailedException` for transmission errors
- UI displays appropriate error messages to users

## Common Issues and Solutions

### Code Format Problems
If tests fail due to code format:
- Ensure all codes are 32-bit hexadecimal values
- Verify the 0x prefix is present
- Check for typos in the hexadecimal digits

### Brand Not Working
If a brand doesn't respond to codes:
- Verify the codes are for power-off functions
- Check if the brand uses a different IR protocol
- Test with multiple models of the same brand

### Repository Issues
If the repository fails to compile:
- Check for trailing commas in the Map
- Ensure proper Dart syntax
- Verify all hexadecimal values are valid

## Example: Adding a New Brand
Here's a complete example of adding support for "ExampleBrand":

```dart
static const Map<String, List<int>> _irCodes = {
  // ... existing brands
  
  // Adding ExampleBrand
  'ExampleBrand': [
    0x12345678, // Primary power off code
    0x87654321, // Alternative power code
  ],
};
```

After adding this entry:
1. Run `flutter test` to verify the code
2. Build and test on a physical device if available

## Maintenance Guidelines

### Code Updates
When updating existing codes:
- Maintain backward compatibility when possible
- Document reasons for changes
- Test thoroughly after any modifications

### Repository Growth
Monitor the repository size:
- Keep the brand list focused on major manufacturers
- Consider grouping regional brands
- Periodically review code effectiveness

## Getting Help
For issues with specific brands or codes:
- Check the project's issue tracker
- Consult IR code databases
- Test with multiple devices to verify code reliability