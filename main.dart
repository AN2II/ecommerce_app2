import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'services/api_service.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/orders_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, CartProvider>(
          create: (context) => CartProvider(
            ApiService(),
            Provider.of<AuthProvider>(context, listen: false),
          ),
          update: (context, auth, previous) => CartProvider(
            ApiService(),
            auth,
          ),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Milia Luxe Beldi',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            colorScheme: ColorScheme.light(
              primary: Color(0xFF1B4965),      // Bleu marine
              secondary: Color(0xFF5FA8D3),     // Bleu clair
              surface: Color(0xFFF5F5F0),       // Beige clair
              background: Color(0xFFE5E5E0),    // Beige
              error: Color(0xFFD62828),         // Rouge error
              onPrimary: Colors.white,
              onSecondary: Color(0xFF1B4965),   // Bleu marine
              onSurface: Color(0xFF1B4965),     // Bleu marine
              onBackground: Color(0xFF1B4965),   // Bleu marine
              onError: Colors.white,
              brightness: Brightness.light,
            ),
            scaffoldBackgroundColor: Color(0xFFE5E5E0),  // Beige
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              backgroundColor: Color(0xFF1B4965),  // Bleu marine
              elevation: 0,
              centerTitle: true,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
              iconTheme: IconThemeData(color: Colors.white),
            ),
            textTheme: TextTheme(
              bodyLarge: TextStyle(
                color: Color(0xFF1B4965),      // Bleu marine
                fontSize: 16,
                letterSpacing: 0.5,
              ),
              bodyMedium: TextStyle(
                color: Color(0xFF1B4965),      // Bleu marine
                fontSize: 14,
                letterSpacing: 0.25,
              ),
              titleLarge: TextStyle(
                color: Color(0xFF1B4965),      // Bleu marine
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.75,
              ),
              titleMedium: TextStyle(
                color: Color(0xFF1B4965),      // Bleu marine
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
              titleSmall: TextStyle(
                color: Color(0xFF1B4965),      // Bleu marine
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.25,
              ),
              labelLarge: TextStyle(
                color: Color(0xFF1B4965),      // Bleu marine
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.0,
              ),
            ),
            iconTheme: IconThemeData(
              color: Color(0xFF1B4965),        // Bleu marine
              size: 24,
            ),
            cardTheme: CardTheme(
              color: Color(0xFFF5F5F0),        // Beige clair
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1B4965),  // Bleu marine
                foregroundColor: Colors.white,
                elevation: 3,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Color(0xFF5FA8D3),  // Bleu clair
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
          ),
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFE5E5E0),      // Beige
                    Color(0xFFF0F0EA),      // Beige plus clair
                    Color(0xFFF5F5F0),      // Beige très clair
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
              child: child!,
            );
          },
          home: auth.isAuth ? HomeScreen() : LoginScreen(),
          routes: {
            LoginScreen.routeName: (ctx) => LoginScreen(),
            RegisterScreen.routeName: (ctx) => RegisterScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
          },
        ),
      ),
    );
  }
}
