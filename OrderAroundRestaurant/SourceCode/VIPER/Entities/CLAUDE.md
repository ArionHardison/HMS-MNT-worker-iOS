# VIPER Entities - Data Models

## Overview
This directory contains all the data models and entity classes used throughout the application. These entities represent the structure of data exchanged with the backend API and used within the app's business logic.

## Entity Categories

### 1. Authentication Entities
- **LoginEntity.swift** - User login request/response
- **RegisterEntity.swift** - User registration data
- **LogoutEntity.swift** - Logout response
- **changePwdEntity.swift** - Password change operations

### 2. Order Management Entities
- **OrderEntity.swift** - Core order data structure
- **OrderDetailEntity.swift** - Detailed order information
- **OrderHistoryEntity.swift** - Historical order records
- **AcceptEntity.swift** - Order acceptance operations
- **DeliveryEntity.swift** - Delivery information and status

### 3. Product and Menu Entities
- **ProductEntity.swift** - Product information and details
- **GetProductEntity.swift** - Product retrieval responses
- **CategoryListEntity.swift** - Product categories
- **CreateCategoryEntity.swift** - Category creation data
- **RemoveCategoryEntity.swift** - Category removal operations
- **RemoveProductEntity.swift** - Product removal operations

### 4. Add-ons and Customization Entities
- **AddOnsListEntity.swift** - Available add-ons list
- **AddAddonsEntity.swift** - Add-on creation data
- **RemoveAddonsEntity.swift** - Add-on removal operations
- **SelectAddonsEntity.swift** - Add-on selection data

### 5. User and Profile Entities
- **UserData.swift** - User profile information
- **ProfileEntity.swift** - Profile management data
- **EditRegisterEntity.swift** - Profile editing operations
- **CountryEntity.swift** - Country and region data

### 6. Business and Analytics Entities
- **RevenueEntity.swift** - Revenue and earnings data
- **TransactionEntity.swift** - Transaction records
- **CusineListEntity.swift** - Cuisine categories

### 7. Utility and Support Entities
- **DeleteEntity.swift** - Generic deletion operations
- **CancelReasons.swift** - Order cancellation reasons
- **StripeTokenEntity.swift** - Payment processing data

## Entity Structure Pattern

### Common Properties
Most entities follow a consistent structure:
- `success`: Boolean indicating API call success
- `message`: Response message from server
- `data`: Main data payload
- `status_code`: HTTP status code

### Example Entity Structure
```swift
class OrderEntity: Mappable {
    var success: Bool?
    var message: String?
    var data: OrderData?
    var status_code: Int?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        data <- map["data"]
        status_code <- map["status_code"]
    }
}
```

## Data Mapping

### ObjectMapper Integration
- All entities conform to `Mappable` protocol
- Automatic JSON to object mapping
- Bidirectional mapping support
- Nested object mapping

### Mapping Conventions
- JSON snake_case to Swift camelCase
- Optional properties for nullable fields
- Array mapping for collections
- Custom transformations for complex types

## Usage Patterns

### 1. API Response Handling
```swift
// In Interactor
webService.retrieve(
    api: "/orders",
    params: params,
    modelClass: OrderEntity.self
) { error, data in
    if let orderEntity = data as? OrderEntity {
        // Use entity data
    }
}
```

### 2. Data Validation
```swift
// In business logic
guard let order = orderEntity.data,
      let orderId = order.id else {
    // Handle invalid data
    return
}
```

### 3. UI Data Binding
```swift
// In Presenter
func formatOrderData(_ entity: OrderEntity) -> OrderDisplayData {
    return OrderDisplayData(
        id: entity.data?.id ?? 0,
        status: entity.data?.status ?? "Unknown",
        total: entity.data?.total ?? 0.0
    )
}
```

## Best Practices

### 1. Entity Design
- Keep entities as plain data objects
- Use optional properties for nullable fields
- Implement proper mapping functions
- Add validation where necessary

### 2. Naming Conventions
- Use descriptive entity names
- Follow Swift naming conventions
- Maintain consistency across similar entities
- Use appropriate suffixes (Entity, Model, Data)

### 3. Error Handling
- Always check for nil values
- Validate required fields
- Handle mapping errors gracefully
- Provide default values where appropriate

## Areas for Improvement

### 1. Code Quality
- **Consistency**: Standardize entity structure
- **Validation**: Add proper data validation
- **Documentation**: Add property documentation
- **Testing**: Implement unit tests for entities

### 2. Modern Swift Features
- **Codable**: Migrate from ObjectMapper to Codable
- **Property Wrappers**: Use for common patterns
- **Result Types**: Implement proper error handling
- **Async/Await**: Update for modern concurrency

### 3. Data Integrity
- **Validation**: Add input validation
- **Transformation**: Implement data transformations
- **Caching**: Add caching mechanisms
- **Versioning**: Handle API version changes

### 4. Performance
- **Lazy Loading**: Implement lazy property loading
- **Memory Management**: Optimize object creation
- **Parsing**: Improve JSON parsing performance
- **Caching**: Cache frequently used entities

## Common Issues and Solutions

### 1. Mapping Failures
- **Problem**: JSON structure doesn't match entity
- **Solution**: Use optional properties and default values

### 2. Null Safety
- **Problem**: Unexpected nil values
- **Solution**: Proper optional handling and validation

### 3. Data Consistency
- **Problem**: Inconsistent data formats
- **Solution**: Implement data transformations and validation

### 4. Performance Issues
- **Problem**: Slow entity creation
- **Solution**: Optimize mapping and use lazy loading

## Testing Strategy
1. **Unit Tests**: Test entity mapping and validation
2. **Integration Tests**: Test with real API responses
3. **Mock Data**: Create test fixtures for entities
4. **Performance Tests**: Test parsing performance