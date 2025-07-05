# HMS-MNT-worker-iOS - Diet Manager Chef App

## Overview
This is a legacy iOS application built for restaurant workers/chefs to manage orders, menu items, and deliveries. The app follows VIPER architecture pattern and uses various third-party libraries for networking, UI components, and Firebase integration.

## App Information
- **Display Name**: Chef - DietManager
- **Target**: iOS (iPhone/iPad)
- **Architecture**: VIPER (View, Interactor, Presenter, Entity, Router)
- **Language**: Swift
- **Deployment**: Portrait-only orientation (iPhone), Universal (iPad)

## Key Features
- Order management (incoming, ongoing, completed)
- Menu and category management
- Real-time chat with customers
- Live order tracking with Google Maps
- Push notifications for new orders
- Revenue tracking and analytics
- Multi-language support
- Camera integration for food photos
- Payment processing integration

## Dependencies (CocoaPods)
- **Networking**: Alamofire, AlamofireObjectMapper, SwiftyJSON
- **UI**: Charts, SDWebImage, NVActivityIndicatorView, EasyTipView
- **Maps**: GoogleMaps, GooglePlaces
- **Firebase**: Core, Database, Messaging
- **UI Components**: TextFieldEffects, UnsplashPhotoPicker
- **Navigation**: KWDrawerController
- **Keyboard**: IQKeyboardManagerSwift
- **Analytics**: Fabric, Crashlytics

## Project Structure
```
HMS-MNT-worker-iOS/
├── OrderAroundRestaurant/           # Main app target
│   ├── SourceCode/                  # Application source code
│   │   ├── AppDelegate/             # App lifecycle management
│   │   ├── Constants/               # Shared constants and utilities
│   │   ├── VIPER/                   # VIPER architecture components
│   │   └── WebServices/             # API communication layer
│   ├── Resources/                   # Assets, fonts, images
│   └── Supporting Files/            # Plist files, configurations
├── Pods/                           # Third-party dependencies
└── Tests/                          # Unit and UI tests
```

## Architecture Pattern: VIPER
- **View**: UI components, ViewControllers, XIBs
- **Interactor**: Business logic, API calls
- **Presenter**: View logic, data formatting
- **Entity**: Data models, response objects
- **Router**: Navigation, module creation

## Development Notes
- Uses legacy Swift version (needs updating)
- Contains hardcoded API keys (security concern)
- Mixed naming conventions throughout codebase
- Extensive use of third-party libraries
- Firebase integration for real-time features

## Build Commands
```bash
# Install dependencies
pod install

# Open workspace (not .xcodeproj)
open DietManagerChef.xcworkspace

# Build for device
xcodebuild -workspace DietManagerChef.xcworkspace -scheme DietManagerChef -configuration Release
```

## Security Considerations
- API keys exposed in source code
- Network security allows arbitrary loads
- Location permissions requested
- Camera and photo library access

## Recommended Improvements
1. Update to latest Swift version
2. Implement proper API key management
3. Add SwiftLint for code quality
4. Implement unit tests
5. Update deprecated APIs
6. Add proper error handling
7. Implement proper MVVM or clean architecture
8. Add accessibility support