import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linen_republic_admin/features/authentication/controller/bloc/bloc/auth_bloc.dart';
import 'package:linen_republic_admin/features/authentication/controller/repository/admin_services.dart';
import 'package:linen_republic_admin/features/authentication/view/admin/admin_login.dart';
import 'package:linen_republic_admin/features/orders/controller/orders/orders_bloc.dart';
import 'package:linen_republic_admin/features/orders/controller/services/order_services.dart';
import 'package:linen_republic_admin/features/products/controller/bloc/product/product_bloc.dart';
import 'package:linen_republic_admin/features/products/controller/repository/productservice.dart';
import 'package:linen_republic_admin/features/search/controller/bloc/search_bloc.dart';
import 'package:linen_republic_admin/utils/responsive/responsive.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.initScreenSize(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(AdminAuthenticationServices()),
        ),
        BlocProvider(
          create: (context) => ProductBloc(ProductAddServices()),
        ),
        BlocProvider(
          create: (context) => OrdersBloc(OrderServices()),
        ),
        BlocProvider(
          create: (context) => SearchBloc(ProductAddServices()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Linen Republic Admin',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        home: const AdminLogin(),
      ),
    );
  }
}
