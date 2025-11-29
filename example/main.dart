import 'package:flutter/material.dart';
import 'package:flutter_api_helpers/flutter_api_helpers.dart';
import 'package:dio/dio.dart';

void main() {
  // Set custom error messages at app startup
  ErrorHandler.setCustomMessages(
    CustomErrorMessages(
      errorNoInternet: "No Internet",
      errorNoInternetMessage: "Please check your internet connection.",
      errorServerProblem: "Server Issue",
      errorServerProblemMessage: "Our servers are experiencing issues.",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API Helpers Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ApiHelpersDemo(),
    );
  }
}

class ApiHelpersDemo extends StatefulWidget {
  @override
  _ApiHelpersDemoState createState() => _ApiHelpersDemoState();
}

class _ApiHelpersDemoState extends State<ApiHelpersDemo> {
  late final Dio dio;
  Result<List<User>, UiError>? result;

  @override
  void initState() {
    super.initState();
    // Initialize Dio with custom configuration
    dio = DioFactory.createDio(
      DioConfig(
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
        enableLogging: true,
      ),
    );
  }

  Future<void> fetchUsers() async {
    setState(() {
      result = null;
    });

    try {
      // This will likely fail for demo purposes
      await dio.get('https://httpstat.us/500');
      // Simulate parsing users
      final users = <User>[
        User(id: 1, name: 'John Doe', email: 'john@example.com'),
        User(id: 2, name: 'Jane Smith', email: 'jane@example.com'),
      ];
      setState(() {
        result = Result.success(users);
      });
    } catch (e) {
      final error = ErrorHandler.handle(e);
      setState(() {
        result = Result.failure(error);
      });
    }
  }

  Future<void> simulateNetworkError() async {
    setState(() {
      result = null;
    });

    try {
      // This will timeout
      await dio.get('https://httpstat.us/200?sleep=20000');
    } catch (e) {
      final error = ErrorHandler.handle(e);
      setState(() {
        result = Result.failure(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Helpers Demo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: fetchUsers,
              child: Text('Fetch Users (Server Error)'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: simulateNetworkError,
              child: Text('Simulate Timeout'),
            ),
            SizedBox(height: 32),
            Expanded(
              child: _buildResultWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultWidget() {
    if (result == null) {
      return Center(
        child: Text(
          'Press a button to test API error handling',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    return result!.when(
      success: (users) => _buildUsersList(users),
      failure: (error) => _buildErrorWidget(error),
    );
  }

  Widget _buildUsersList(List<User> users) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          title: Text(user.name),
          subtitle: Text(user.email),
          leading: CircleAvatar(
            child: Text(user.id.toString()),
          ),
        );
      },
    );
  }

  Widget _buildErrorWidget(UiError error) {
    return Column(
      children: [
        // Show as full-screen widget
        Expanded(
          child: error.asWidget(
            onRetry: () => fetchUsers(),
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => error.showAsDialog(
                  context,
                  onRetry: () => fetchUsers(),
                ),
                child: Text('Show as Dialog'),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () => error.showAsSnackBar(
                  context,
                  onRetry: () => fetchUsers(),
                ),
                child: Text('Show as SnackBar'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Example User model
class User {
  final int id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}