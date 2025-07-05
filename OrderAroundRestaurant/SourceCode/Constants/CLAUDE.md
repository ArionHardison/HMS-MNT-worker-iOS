# Constants and Utilities

## Overview
This directory contains shared constants, utilities, extensions, and supporting files used throughout the application. These components provide common functionality and maintain consistency across the app.

## Directory Structure

### Constants (`Constants/`)
- **Purpose**: Application-wide constants and configuration
- **Key Files**:
  - `Constants.swift` - Global constants and enums
  - `AppData.swift` - Application data management
  - `Global.swift` - Global utilities and functions
  - `String.swift` - String constants and localization keys

### Extensions
- **Purpose**: Extend existing Swift/iOS types with custom functionality

#### UI Extensions
- `Button.swift` - UIButton customizations
- `Colors.swift` - Color constants and utilities
- `Font.swift` - Font management and styles
- `Image.swift` - Image processing utilities
- `View.swift` - UIView extensions and utilities
- `TextField.swift` - UITextField customizations

#### System Extensions
- `Device.swift` - Device type detection and utilities
- `Common.swift` - Common extension methods
- `ViewExtension.swift` - Additional view utilities

#### Controller Extensions
- `ViewControllerExtension.swift` - UIViewController extensions
- `TableViewExtension.swift` - UITableView utilities

### Utilities (`Utility/`)
- **Purpose**: Helper classes and utility functions
- **Key Files**:
  - `Utility.swift` - General utility functions
  - `SingleTonClass.swift` - Singleton pattern implementations

### Supporting Components

#### Alert System (`Alert/`)
- `Alert.swift` - Custom alert implementations
- `ToastView.swift` - Toast notification system
- `Toast.swift` - Toast utilities

#### Form Components (`SupportingFiles/`)
- `TextFieldEffects.swift` - Custom text field animations
- `HoshiTextField.swift` - Animated text field implementation

#### Data Management
- `Cache.swift` - Caching mechanisms
- `UserDefaultsKeys.swift` - UserDefaults key constants
- `LocaliseManager.swift` - Localization management

#### Third-Party Integrations
- `CapsPageMenu/` - Custom page menu implementation
- `Rating/` - Star rating components
- `Chart/` - Chart customizations and formatters

#### Input Handling
- `KeyboardHandler.swift` - Keyboard management
- `Country.swift` - Country code and selection

## Key Features

### 1. Theming and Styling
- Consistent color scheme management
- Custom font loading and application
- Reusable UI component styles

### 2. Localization
- Multi-language support infrastructure
- Centralized string management
- Dynamic language switching

### 3. Device Management
- Screen size detection
- Device type identification
- Responsive design support

### 4. Error Handling
- Custom error types
- User-friendly error messages
- Centralized error management

### 5. Data Persistence
- UserDefaults wrapper
- Caching strategies
- Data validation

## Usage Examples

### Color Usage
```swift
// Using custom colors
view.backgroundColor = Colors.primary
label.textColor = Colors.textGray
```

### Font Usage
```swift
// Applying custom fonts
label.font = Font.nunito(.medium, size: 16)
```

### Device Detection
```swift
// Checking device type
if Device.isIPhoneX {
    // Handle iPhone X specific layout
}
```

### Localization
```swift
// Using localized strings
label.text = String.localized("welcome_message")
```

## Best Practices
1. All constants should be defined in appropriate files
2. Use extensions to enhance existing types
3. Maintain consistent naming conventions
4. Document complex utility functions
5. Keep extensions focused on single responsibilities

## Areas for Improvement
1. Consolidate scattered constants
2. Implement proper theming system
3. Add proper documentation
4. Modernize Swift patterns
5. Implement proper error handling
6. Add unit tests for utilities
7. Remove unused code and dependencies