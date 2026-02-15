# Auth GraphQL - Ferry Implementation Guide

This project demonstrates how to use Ferry GraphQL client in a Flutter application following clean architecture principles.

## 🚀 Ferry Setup

### Dependencies

```yaml
dependencies:
  ferry: latest
  ferry_flutter: latest
  gql_http_link: latest
  built_value: latest
  built_collection: latest

dev_dependencies:
  ferry_generator: latest
  build_runner: latest
  built_value_generator: latest
```

### Configuration Files

#### 1. `ferry_config.yaml`
```yaml
schema: lib/schema.graphql
queries_glob: lib/src/features/**/*.graphql
type_overrides:
  DateTime: DateTime
```

#### 2. `build.yaml`
```yaml
targets:
  $default:
    builders:
      ferry_generator|graphql_builder:
        enabled: true
        options:
          schema: auth_graphql|lib/schema.graphql
      ferry_generator|serializer_builder:
        enabled: true
        options:
          schema: auth_graphql|lib/schema.graphql
```

## 📁 Project Structure

```
lib/
├── schema.graphql                 # GraphQL schema
├── __generated__/                 # Generated serializers
│   ├── serializers.gql.dart
│   └── serializers.gql.g.dart
├── src/
│   ├── core/
│   │   ├── constants/
│   │   │   └── constants.dart     # API endpoints
│   │   ├── utils/
│   │   │   └── client_initializer.dart  # Ferry Client setup
│   │   └── locator.dart           # Dependency injection
│   └── features/
│       └── auth/
│           ├── data/
│           │   ├── params/
│           │   │   ├── token.graphql          # GraphQL query
│           │   │   └── __generated__/         # Generated code
│           │   ├── data_sources/
│           │   │   └── auth_remote_data_source.dart
│           │   └── repositories/
│           │       └── auth_repository_impl.dart
│           └── presentation/
│               └── pages/
│                   └── auth_page.dart
```

## 🔨 How to Use Ferry

### Step 1: Define GraphQL Schema

Create `lib/schema.graphql`:
```graphql
type Query {
  anonymousToken: TokenResponse
}

type TokenResponse {
  refreshToken: String!
  token: String!
}
```

### Step 2: Create GraphQL Queries

Create query files like `lib/src/features/auth/data/params/token.graphql`:
```graphql
query AnonymousToken {
    anonymousToken {
        refreshToken
        token
    }
}
```

### Step 3: Generate Code

Run the build runner to generate Ferry code:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Or use watch mode for development:
```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Step 4: Initialize Ferry Client

```dart
Client initClient(String path) {
  final link = HttpLink("$baseUrl$path");
  final cache = Cache();
  
  final client = Client(
    link: link,
    cache: cache,
    defaultFetchPolicies: {
      OperationType.query: FetchPolicy.CacheAndNetwork,
    },
  );
  
  return client;
}
```

### Step 5: Use in Data Sources

```dart
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Client client;

  AuthRemoteDataSourceImpl(this.client);

  @override
  Stream<OperationResponse<GAnonymousTokenData, GAnonymousTokenVars>> 
      getAnonymousToken() {
    final request = GAnonymousTokenReq();
    return client.request(request);
  }
}
```

### Step 6: Use in UI with Ferry Flutter Widgets

```dart
Operation(
  client: client,
  operationRequest: GAnonymousTokenReq(),
  builder: (context, response, error) {
    if (response?.loading ?? true) {
      return CircularProgressIndicator();
    }
    
    if (response!.hasErrors) {
      return Text('Error: ${response.graphqlErrors}');
    }
    
    return Text('Token: ${response.data?.anonymousToken?.token}');
  },
)
```

## 🎯 Key Features of Ferry

### 1. **Normalized Caching**
Ferry automatically caches responses and normalizes data by ID, reducing network requests.

### 2. **Type Safety**
All GraphQL operations are fully typed with generated Dart classes.

### 3. **Reactive Streams**
Ferry returns Dart Streams, making it easy to integrate with BLoC, Provider, or other state management.

### 4. **Fetch Policies**
```dart
FetchPolicy.CacheFirst      // Use cache, fallback to network
FetchPolicy.CacheAndNetwork // Return cache, then update with network
FetchPolicy.NetworkOnly     // Always fetch from network
FetchPolicy.NoCache        // Network only, don't cache
```

### 5. **Optimistic Updates**
```dart
client.request(request, optimisticResponse: optimisticData);
```

### 6. **Mutations**
```graphql
mutation Login($email: String!, $password: String!) {
  login(email: $email, password: $password) {
    token
    user {
      id
      name
    }
  }
}
```

```dart
final req = GLoginReq((b) => b
  ..vars.email = 'user@example.com'
  ..vars.password = 'password123'
);

client.request(req).listen((response) {
  // Handle response
});
```

## 🔧 Common Commands

```bash
# Get dependencies
flutter pub get

# Generate code
flutter pub run build_runner build --delete-conflicting-outputs

# Watch for changes
flutter pub run build_runner watch --delete-conflicting-outputs

# Clean generated files
flutter pub run build_runner clean

# Run the app
flutter run
```

## 📚 Additional Resources

- [Ferry Documentation](https://ferrygraphql.com/docs/)
- [Ferry GitHub](https://github.com/gql-dart/ferry)
- [GraphQL Spec](https://graphql.org/learn/)

## 🐛 Troubleshooting

### Issue: "Undefined name 'possibleTypesMap'"
**Solution**: Remove `possibleTypes` parameter if your schema doesn't have interfaces or unions.

### Issue: Generated files not updating
**Solution**: Run `flutter pub run build_runner clean` then rebuild.

### Issue: Import errors after generation
**Solution**: Run `flutter pub get` after code generation.

## 📝 Notes

- Always run `build_runner` after modifying GraphQL queries or schema
- Use `--delete-conflicting-outputs` flag to avoid conflicts
- Ferry generates code in `__generated__` folders next to your `.graphql` files
- The serializers are generated in `lib/__generated__/`

