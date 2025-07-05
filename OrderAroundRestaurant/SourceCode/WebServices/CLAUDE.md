# Web Services Layer

## Overview
This directory contains the networking layer responsible for API communication, request/response handling, and data transformation. It provides a unified interface for all backend interactions.

## Components

### Core Files
- `WebService.swift` - Main networking service implementation
- `WebServiceConstants.swift` - API endpoints and networking constants

## Architecture

### WebService Class
- **Purpose**: Handles all HTTP requests and responses
- **Pattern**: Generic networking layer with ObjectMapper integration
- **Key Features**:
  - Generic request handling
  - Automatic JSON mapping
  - Authentication token management
  - Multipart form data support
  - Error handling

### Request Types
- **GET**: Data retrieval
- **POST**: Data creation/submission
- **PUT**: Data updates
- **DELETE**: Data removal
- **MULTIPART**: File uploads

## Key Features

### 1. Generic Request Handling
```swift
func retrieve<T: Mappable>(
    api: String,
    params: [String: Any],
    imageData: [String: Data]?,
    type: HttpType,
    modelClass: T.Type,
    token: Bool,
    completion: ((CustomError?, Data?) -> ())?
)
```

### 2. Authentication
- Bearer token authentication
- Automatic token inclusion in headers
- Token refresh handling

### 3. Request Configuration
- Base URL configuration
- Custom headers management
- Request timeout handling

### 4. Response Processing
- Automatic JSON parsing
- ObjectMapper integration
- Error response handling

### 5. File Upload Support
- Multipart form data
- Image upload capabilities
- Progress tracking

## API Integration

### Headers
- `X-Requested-With`: XMLHttpRequest
- `Authorization`: Bearer token
- `Content-Type`: application/json

### Base URL
- Configurable base URL for different environments
- Support for development/staging/production

### Error Handling
- Custom error types
- Network error management
- API error response parsing

## Usage Examples

### Basic API Call
```swift
let webService = WebService()
webService.retrieve(
    api: "/api/orders",
    params: ["status": "pending"],
    imageData: nil,
    type: .GET,
    modelClass: OrderEntity.self,
    token: true
) { error, data in
    // Handle response
}
```

### File Upload
```swift
let imageData = ["image": imageData]
webService.retrieve(
    api: "/api/upload",
    params: parameters,
    imageData: imageData,
    type: .POST,
    modelClass: UploadEntity.self,
    token: true
) { error, data in
    // Handle response
}
```

## Dependencies
- **Alamofire**: HTTP networking
- **ObjectMapper**: JSON mapping
- **Foundation**: Core networking

## Security Considerations
- Bearer token authentication
- HTTPS enforcement (should be enabled)
- Request/response logging (debug only)
- API key management

## Configuration
- Base URL configuration
- Timeout settings
- Request retry policies
- Cache policies

## Best Practices
1. Use appropriate HTTP methods
2. Include authentication tokens when required
3. Handle errors gracefully
4. Log requests/responses for debugging
5. Use proper timeout values
6. Implement request cancellation

## Areas for Improvement
1. **Modern Networking**: Migrate to URLSession with async/await
2. **Error Handling**: Implement proper error types and handling
3. **Request Cancellation**: Add support for cancelling requests
4. **Caching**: Implement proper caching strategies
5. **Security**: Remove hardcoded tokens and URLs
6. **Testing**: Add unit tests for networking layer
7. **Logging**: Implement proper logging with levels
8. **Configuration**: Use environment-based configuration
9. **Retry Logic**: Add automatic retry for failed requests
10. **Performance**: Implement request batching and optimization

## Common API Endpoints
- Authentication: `/api/auth/login`, `/api/auth/register`
- Orders: `/api/orders`, `/api/orders/{id}`
- Menu: `/api/menu`, `/api/categories`
- Profile: `/api/profile`
- Upload: `/api/upload`