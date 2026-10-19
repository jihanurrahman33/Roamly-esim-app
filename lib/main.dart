import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'data/repositories/destination_repository.dart';
import 'data/repositories/esim_repository.dart';
import 'data/repositories/loyalty_repository.dart';
import 'data/repositories/order_repository.dart';
import 'presentation/blocs/esim/esim_bloc.dart';
import 'presentation/blocs/esim/esim_event.dart';
import 'presentation/blocs/home/home_bloc.dart';
import 'presentation/blocs/home/home_event.dart';
import 'presentation/blocs/loyalty/loyalty_bloc.dart';
import 'presentation/blocs/loyalty/loyalty_event.dart';
import 'presentation/blocs/orders/orders_bloc.dart';
import 'presentation/blocs/orders/orders_event.dart';
import 'presentation/screens/main_shell_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const RoamlyApp());
}

class RoamlyApp extends StatelessWidget {
  const RoamlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => DestinationRepository()),
        RepositoryProvider(create: (_) => EsimRepository()),
        RepositoryProvider(create: (_) => OrderRepository()),
        RepositoryProvider(create: (_) => LoyaltyRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (ctx) => HomeBloc(
              destinationRepository: ctx.read<DestinationRepository>(),
            )..add(LoadHomeEvent()),
          ),
          BlocProvider(
            create: (ctx) => EsimBloc(
              esimRepository: ctx.read<EsimRepository>(),
            )..add(LoadEsimsEvent()),
          ),
          BlocProvider(
            create: (ctx) => OrdersBloc(
              orderRepository: ctx.read<OrderRepository>(),
            )..add(LoadOrdersEvent()),
          ),
          BlocProvider(
            create: (ctx) => LoyaltyBloc(
              loyaltyRepository: ctx.read<LoyaltyRepository>(),
            )..add(LoadLoyaltyEvent()),
          ),
        ],
        child: MaterialApp(
          title: 'Roamly eSIM',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: const MainShellScreen(),
        ),
      ),
    );
  }
}
