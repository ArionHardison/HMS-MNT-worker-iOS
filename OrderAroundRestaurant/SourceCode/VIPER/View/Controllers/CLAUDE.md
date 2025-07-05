# VIPER View Controllers

## Overview
This directory contains all the view controllers that make up the user interface of the Diet Manager Chef application. These controllers handle user interactions, display data, and coordinate with the VIPER architecture components.

## Controller Categories

### 1. Authentication Controllers
- **LoginViewController.swift** - User login interface
- **RegisterViewController.swift** - User registration
- **SignUpViewController.swift** - Sign up process
- **ForgotPasswordViewController.swift** - Password recovery
- **OTPController.swift** - OTP verification
- **VerificationViewController.swift** - Account verification
- **MobileViewController.swift** - Mobile number entry
- **ChangePwdViewController.swift** - Password change

### 2. Main Navigation Controllers
- **TabbarController.swift** - Main tab bar navigation
- **HomeViewController.swift** - Dashboard/home screen
- **SideBarTableViewController.swift** - Side menu navigation

### 3. Order Management Controllers
- **UpComingRequestViewController.swift** - Incoming order requests
- **UpcomingDetailViewController.swift** - Order details view
- **UpcomingOrderViewController.swift** - Upcoming orders list
- **OnGoingOrderViewController.swift** - Active orders
- **PastOrderViewController.swift** - Order history
- **OrderTrackingViewController.swift** - Live order tracking
- **CancelOrderViewController.swift** - Order cancellation
- **DeliveriesViewController.swift** - Delivery management
- **TakeAwayOrdersViewController.swift** - Take-away orders
- **FilterDeliveryViewController.swift** - Delivery filtering

### 4. Menu and Product Management
- **CategoryListViewController.swift** - Product categories
- **CreateCategoryViewController.swift** - Category creation
- **CategoryStatusViewController.swift** - Category status management
- **CreateProductViewController.swift** - Product creation
- **AddProductViewController.swift** - Product addition
- **DishesViewController.swift** - Dish management
- **RestaurantMenuViewController.swift** - Menu overview
- **SelectCusineViewController.swift** - Cuisine selection
- **AddonsListViewController.swift** - Add-ons management
- **CreateAddonsViewController.swift** - Add-on creation
- **CreateProductAddonsViewController.swift** - Product add-ons
- **SelectAddonsViewController.swift** - Add-on selection

### 5. User Management
- **ProfileTableViewController.swift** - User profile
- **EditRegisterViewController.swift** - Profile editing
- **UserDetiailsViewController.swift** - User details
- **CountryCodeViewController.swift** - Country selection

### 6. Business Operations
- **RevenueViewController.swift** - Revenue analytics
- **HistoryViewController.swift** - Transaction history
- **StatusViewController.swift** - Order status management
- **FilterViewController.swift** - Filtering options
- **EditTimingViewController.swift** - Operating hours

### 7. Specialized Controllers
- **LiveTaskViewController.swift** - Live task management
- **ImageGalleryViewController.swift** - Image gallery
- **TimePickerViewController.swift** - Time selection
- **PDFLoaderViewController.swift** - PDF document viewer
- **TermsConditionViewController.swift** - Terms and conditions
- **FoodSafetyViewController.swift** - Food safety information

### 8. Dietician-Specific Controllers (`Dietician/`)
- **LiveTrackViewController.swift** - Live tracking
- **OrderRequestDeatilVC.swift** - Order request details
- **PaymentViewController.swift** - Payment processing
- **TaskDetailViewController.swift** - Task details
- **WalletListViewController.swift** - Wallet management

## Common Patterns

### 1. VIPER Integration
```swift
class HomeViewController: UIViewController {
    var presenter: HomePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}
```

### 2. Table View Management
```swift
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getItemCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cell configuration
    }
}
```

### 3. User Input Handling
```swift
@IBAction func buttonTapped(_ sender: UIButton) {
    presenter?.handleButtonTap()
}
```

## Architecture Integration

### View Responsibilities
- Display data provided by Presenter
- Handle user interactions
- Update UI based on Presenter commands
- Manage view lifecycle

### Communication Flow
1. **User Input** → View captures interaction
2. **Delegation** → View delegates to Presenter
3. **Data Request** → Presenter requests data from Interactor
4. **Response** → Presenter formats data for View
5. **UI Update** → View updates interface

## Common UI Components

### 1. Custom Table View Cells
- Various specialized cells for different data types
- Custom XIB files for complex layouts
- Reusable cell patterns

### 2. Navigation Management
- Tab bar navigation
- Modal presentations
- Push/pop navigation stack

### 3. Form Handling
- Text field validation
- Form submission
- Error display

### 4. Data Display
- List views (UITableView)
- Collection views (UICollectionView)
- Custom views for specialized data

## Best Practices

### 1. View Controller Design
- Keep controllers focused on UI logic
- Delegate business logic to Presenter
- Use proper MVC/VIPER separation
- Implement proper view lifecycle management

### 2. User Experience
- Implement loading states
- Handle error conditions gracefully
- Provide user feedback
- Maintain responsive UI

### 3. Code Organization
- Use extensions for protocol conformance
- Organize IBOutlets and IBActions
- Group related functionality
- Add proper documentation

## Areas for Improvement

### 1. Code Quality
- **Consistency**: Standardize controller patterns
- **Validation**: Add input validation
- **Error Handling**: Improve error presentation
- **Testing**: Add UI tests

### 2. Modern iOS Features
- **Storyboard Segues**: Replace with programmatic navigation
- **Auto Layout**: Update to modern constraints
- **Accessibility**: Add accessibility support
- **Dark Mode**: Implement dark mode support

### 3. Performance
- **Memory Management**: Fix retain cycles
- **Lazy Loading**: Implement lazy loading
- **Caching**: Add view caching
- **Optimization**: Optimize table view performance

### 4. User Experience
- **Loading States**: Add proper loading indicators
- **Error States**: Implement error recovery
- **Offline Support**: Add offline capabilities
- **Animations**: Smooth transitions

## Common Issues and Solutions

### 1. Memory Leaks
- **Problem**: Retain cycles between controllers and presenters
- **Solution**: Use weak references and proper cleanup

### 2. UI Responsiveness
- **Problem**: Blocking UI with network calls
- **Solution**: Use async operations and loading states

### 3. Data Consistency
- **Problem**: Stale data in views
- **Solution**: Implement proper data refresh mechanisms

### 4. Navigation Issues
- **Problem**: Complex navigation flows
- **Solution**: Centralize navigation logic in Router

## Testing Strategy
1. **Unit Tests**: Test controller logic
2. **UI Tests**: Test user interactions
3. **Integration Tests**: Test with real data
4. **Accessibility Tests**: Test accessibility features