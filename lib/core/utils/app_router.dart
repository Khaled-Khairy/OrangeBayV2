import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:orange_bay/core/utils/connectivity_wrapper.dart';
import 'package:orange_bay/core/utils/shared_preferences.dart';
import 'package:orange_bay/core/widgets/card_verification_view.dart';
import 'package:orange_bay/features/add%20and%20refund/presentation/views/add_money_view.dart';
import 'package:orange_bay/features/add%20and%20refund/presentation/views/refund_view.dart';
import 'package:orange_bay/features/admin/presentation/views/admin_home_view.dart';
import 'package:orange_bay/features/admin/presentation/views/card_info_view.dart';
import 'package:orange_bay/features/card%20activation/presentation/views/card_activation_view.dart';
import 'package:orange_bay/features/login/presentation/views/login_view.dart';
import 'package:orange_bay/features/register/presentation/views/register_view.dart';
import 'package:orange_bay/features/replacement_card/presentation/views/replacment_card_view.dart';
import 'package:orange_bay/features/reservation/data/repos/reservation_repo_impl.dart';
import 'package:orange_bay/features/reservation/views/manager/reservation_cubit.dart';
import 'package:orange_bay/features/reservation/views/reservation_tickets_view.dart';
import 'package:orange_bay/features/reservation/views/reservation_view.dart';
import 'package:orange_bay/features/settings/presentation/views/settings_screen.dart';
import 'package:orange_bay/features/ticket/data/repos/ticket_repo_impl.dart';
import 'package:orange_bay/features/ticket/presentation/manager/ticket_cubit/ticket_cubit.dart';
import 'package:orange_bay/features/ticket/presentation/views/orders_view.dart';
import 'package:orange_bay/features/ticket/presentation/views/ticket_view.dart';
import 'package:orange_bay/features/tour_guide_profit/presentation/views/tour_guide_profit_view.dart';
import 'package:orange_bay/features/transactions_history/presentation/views/admin_transactions_history_view.dart';

abstract class AppRouter {
  static const String login = "/";
  static const String register = "/register";
  static const String ticket = "/ticket";
  static const String reservation = "/reservation";
  static const String reservationTickets = "/reservationTickets";
  static const String orders = "/orders";
  static const String admin = '/admin';
  static const String settings = '/settings';
  static const String cardActivation = '/cardActivation';
  static const String tourGuideProfit = "/tourGuideProfit";
  static const String adminTransactionsHistoryAuth =
      '/adminTransactionsHistoryAuth';
  static const String adminTransactionsHistoryView =
      '/adminTransactionsHistoryView';
  static const String cardActivationView = '/cardActivationView';
  static const String addMoneyAuth = '/addCardAuth';
  static const String addMoneyView = '/addCardView';
  static const String refundAuth = '/refundAuth';
  static const String refundView = '/refundView';
  static const String cardInfoAuth = '/cardInfoAuth';
  static const String cardInfoView = '/cardInfoView';
  static const String cashier = '/cashier';
  static const String cartItems = '/cartItems';
  static const String verifyPayment = '/verifyPayment';
  static const String transactionHistory = '/transactionHistory';
  static const String balance = '/balance';
  static const String replacementCard = '/replacementCard';
  static const String replacementCardAuth = '/replacementCardAuth';

  static final GoRouter router = GoRouter(
    initialLocation: PreferenceUtils.getString(PrefKeys.accessToken).isNotEmpty
        ? admin
        : login,
    routes: <RouteBase>[
      GoRoute(
        path: login,
        builder: (BuildContext context, GoRouterState state) =>
            const ConnectivityWrapper(child: LoginView()),
      ),
      GoRoute(
        path: register,
        builder: (BuildContext context, GoRouterState state) =>
            const ConnectivityWrapper(child: RegisterView()),
      ),
      GoRoute(
        path: settings,
        builder: (BuildContext context, GoRouterState state) =>
            const SettingsScreen(),
      ),
      GoRoute(
        path: admin,
        builder: (BuildContext context, GoRouterState state) =>
            const ConnectivityWrapper(child: AdminHomeView()),
      ),
      GoRoute(
        path: ticket,
        builder: (BuildContext context, GoRouterState state) => BlocProvider(
          create: (context) => TicketCubit(TicketRepoImpl()),
          child: const TicketView(),
        ),
      ),
      GoRoute(
          path: reservation,
          builder: (BuildContext context, GoRouterState state) {
            return BlocProvider(
              create: (context) {
                return ReservationCubit(ReservationRepoImpl());
              },
              child: const ReservationView(),
            );
          }),
      GoRoute(
        path: reservationTickets,
        builder: (BuildContext context, GoRouterState state) =>
            ReservationTickets(
          orderId: state.extra as String,
        ),
      ),
      GoRoute(
        path: orders,
        builder: (BuildContext context, GoRouterState state) {
          return OrdersView(
            orderID: state.extra as int,
          );
        },
      ),
      GoRoute(
        path: tourGuideProfit,
        builder: (BuildContext context, GoRouterState state) =>
            const TourGuideProfitView(),
      ),
      GoRoute(
        path: cardActivation,
        builder: (BuildContext context, GoRouterState state) =>
            const CardVerificationView(
          textMsg: "مرر البطاقه ",
          newScreen: AppRouter.cardActivationView,
        ),
      ),
      GoRoute(
        path: adminTransactionsHistoryAuth,
        builder: (BuildContext context, GoRouterState state) =>
            const CardVerificationView(
          textMsg: 'مرر البطاقه',
          newScreen: AppRouter.adminTransactionsHistoryView,
        ),
      ),
      GoRoute(
        path: adminTransactionsHistoryView,
        builder: (BuildContext context, GoRouterState state) =>
            const AdminTransactionsHistoryView(),
      ),
      GoRoute(
        path: replacementCardAuth,
        builder: (BuildContext context, GoRouterState state) =>
            const CardVerificationView(
          textMsg: 'مرر البطاقه الجديده',
          newScreen: AppRouter.admin,
        ),
      ),
      GoRoute(
        path: replacementCard,
        builder: (BuildContext context, GoRouterState state) =>
            const ReplacementCardView(),
      ),
      GoRoute(
        path: cardActivationView,
        builder: (BuildContext context, GoRouterState state) {
          final String uid = state.extra as String;
          return CardActivationView(uid: uid);
        },
      ),
      GoRoute(
        path: addMoneyAuth,
        builder: (BuildContext context, GoRouterState state) =>
            const CardVerificationView(
          textMsg: "مرر البطاقه ",
          newScreen: AppRouter.addMoneyView,
        ),
      ),
      GoRoute(
        path: addMoneyView,
        builder: (BuildContext context, GoRouterState state) =>
            const AddMoneyView(),
      ),
      GoRoute(
        path: refundAuth,
        builder: (BuildContext context, GoRouterState state) =>
            const CardVerificationView(
          textMsg: "مرر البطاقه ",
          newScreen: AppRouter.refundView,
        ),
      ),
      GoRoute(
        path: refundView,
        builder: (BuildContext context, GoRouterState state) =>
            const RefundView(),
      ),
      GoRoute(
        path: cardInfoAuth,
        builder: (BuildContext context, GoRouterState state) =>
            const CardVerificationView(
          textMsg: "مرر البطاقه ",
          newScreen: AppRouter.cardInfoView,
        ),
      ),
      GoRoute(
        path: cardInfoView,
        builder: (BuildContext context, GoRouterState state) =>
            const CardInfoView(),
      ),
      GoRoute(
        path: verifyPayment,
        builder: (BuildContext context, GoRouterState state) =>
            const CardVerificationView(
          textMsg: 'قم بتمرير الكارت',
          newScreen: AppRouter.cashier,
        ),
      ),
    ],
  );
}
