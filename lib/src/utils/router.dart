import 'package:biteblitz/dashBoard.dart';
import 'package:biteblitz/src/features/account/views/Account_Screen.dart';
import 'package:biteblitz/src/features/account/views/contact_us.dart';
import 'package:biteblitz/src/features/account/views/feedback.dart';
import 'package:biteblitz/src/features/account/views/help_and_support.dart';
import 'package:biteblitz/src/features/account/views/live_chat_screen/live_chat_screen.dart';
import 'package:biteblitz/src/features/account/views/restaurant_info/edit_restaurant_information.dart';
import 'package:biteblitz/src/features/account/views/restaurant_info/restaurant_information.dart';
import 'package:biteblitz/src/features/account/views/settings/changePasswordScreen.dart';
import 'package:biteblitz/src/features/account/views/settings/delete_account.dart';
import 'package:biteblitz/src/features/account/views/settings/privacy_policy.dart';
import 'package:biteblitz/src/features/account/views/settings/settings.dart';
import 'package:biteblitz/src/features/account/views/settings/term_of_service.dart';
import 'package:biteblitz/src/features/analytics/views/analytics_screen.dart';
import 'package:biteblitz/src/features/analytics/views/customer_feedback_analysis.dart';
import 'package:biteblitz/src/features/analytics/views/growth_screen.dart';
import 'package:biteblitz/src/features/analytics/views/insights_screen.dart';
import 'package:biteblitz/src/features/auth/views/add_Bank_detail_Screen.dart';
import 'package:biteblitz/src/features/auth/views/add_fssai_Screen.dart';
import 'package:biteblitz/src/features/auth/views/add_gstIn_screen.dart';
import 'package:biteblitz/src/features/auth/views/add_pan_card_Screen.dart';
import 'package:biteblitz/src/features/auth/views/add_res_info_screen.dart';
import 'package:biteblitz/src/features/auth/views/login_screen.dart';
import 'package:biteblitz/src/features/auth/views/menu_images.dart';
import 'package:biteblitz/src/features/auth/views/pending_verification.dart';
import 'package:biteblitz/src/features/auth/views/register_screen.dart';
import 'package:biteblitz/src/features/auth/views/verification.dart';
import 'package:biteblitz/src/features/menu/views/add_new_item.dart';
import 'package:biteblitz/src/features/menu/views/item_added_successful.dart';
import 'package:biteblitz/src/features/menu/views/menu_items_detail.dart';
import 'package:biteblitz/src/features/menu/views/menu_screen.dart';
import 'package:biteblitz/src/features/orders/views/Orders_screen.dart';
import 'package:biteblitz/src/features/orders/views/newOrder_details_screen.dart';
import 'package:biteblitz/src/models/bankData.dart';
import 'package:biteblitz/src/models/menuItem%20Model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../common/views/splash.dart';
import '../features/bank_details/add_new_bank.dart';
import '../features/bank_details/bank_account_details.dart';
import '../features/bank_details/single_account_details.dart';

// Create keys for `root` & `section` navigator avoiding unnecessary rebuilds
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

class routeNames {
  static String splash = '/splash';
  static String welcome = '/welcome';
  static String dashboard = '/dashboard';

  static String menu = '/menu';
  static String viewMenu_Item = '/viewMenuItem';
  static String addNew_Item_in_Menu = '/addNewItem';
  static String item_added_successfully = '/addedSuccessfully';

  static String orders = '/orders';
  static String newOrder = '/newOrder';

  static String analytics = '/analytics';
  static String insights = '/insights';
  static String growth = '/growth';
  static String customer_feedback_analysis = '/customerFeedbackAnalysis';

  static String account = '/account';

  static String restaurant_info = '/restaurantInformation';
  static String edit_restaurant_info = '/EditRestaurantInformation';

  static String setting = '/settings';
  static String changePassword = '/changePassword';
  static String deleteAccount = '/deleteAccount';
  static String termOfService = '/termOfService';
  static String privacyPolicy = '/privacyPolicy';

  static String bank_Acc_details = '/BankDetail';
  static String bank_Acc_Info = '/AccountInfo';
  static String addNew_Bank = '/addBank';

  static String helpandSupport = '/help';
  static String contactUs = '/contactUs';
  static String feedback = '/feedback';
  static String liveChat = '/liveChat';

  static String login = '/login';
  static String registration = '/registration';
  static String verification = '/verification';
  static String addResInfo = '/addRestaurantInformation';
  static String addPan = '/addPan';
  static String addBank_during_registraton = '/bankDetails';
  static String addMenuImages_during_register = '/MenuImages';
  static String addFssai = '/fssai';
  static String addGSTin = '/GSTIN';
  static String pendingVerification = '/pendingVerification';
}

final GoRouter router = GoRouter(
  initialLocation: routeNames.splash ,
  routes: [
    GoRoute(
      name: routeNames.dashboard,
      path: routeNames.dashboard,
      builder: (BuildContext context, GoRouterState state) {
        return dashboard();
      },
    ),
    GoRoute(
      name: routeNames.splash,
      path: routeNames.splash,
      builder: (BuildContext context, GoRouterState state) {
        return SplashScreen();
      },
    ),

    ///region auth screens
    GoRoute(
      name: routeNames.login,
      path: routeNames.login,
      builder: (BuildContext context, GoRouterState state) {
        return login_screen();
      },
    ),
    GoRoute(
      name: routeNames.registration,
      path: routeNames.registration,
      builder: (BuildContext context, GoRouterState state) {
        return register_screen();
      },
    ),

    GoRoute(
      name: routeNames.verification,
      path: routeNames.verification,
      builder: (BuildContext context, GoRouterState state) {
        return const verification();
      },
    ),

    GoRoute(
      name: routeNames.addResInfo,
      path: routeNames.addResInfo,
      builder: (BuildContext context, GoRouterState state) {
        return const add_res_Info_Screen();
      },
    ),
    GoRoute(
      name: routeNames.addPan,
      path: routeNames.addPan,
      builder: (BuildContext context, GoRouterState state) {
        return const add_panCard_Screen();
      },
    ),

    GoRoute(
      name: routeNames.addBank_during_registraton,
      path: routeNames.addBank_during_registraton,
      builder: (BuildContext context, GoRouterState state) {
        return add_bankDetails_Screen();
      },
    ),

    GoRoute(
      name: routeNames.addMenuImages_during_register,
      path: routeNames.addMenuImages_during_register,
      builder: (BuildContext context, GoRouterState state) {
        return add_menuImages_Screen();
      },
    ),

    GoRoute(
      name: routeNames.addFssai,
      path: routeNames.addFssai,
      builder: (BuildContext context, GoRouterState state) {
        return add_fssai_Screen();
      },
    ),

    GoRoute(
      name: routeNames.addGSTin,
      path: routeNames.addGSTin,
      builder: (BuildContext context, GoRouterState state) {
        return add_gstIN_screen();
      },
    ),

    GoRoute(
      name: routeNames.pendingVerification,
      path: routeNames.pendingVerification,
      builder: (BuildContext context, GoRouterState state) {
        return pending_verification();
      },
    ),

    ///endregion

    /// region orders tab
    GoRoute(
      name: routeNames.orders,
      path: routeNames.orders,
      builder: (BuildContext context, GoRouterState state) {
        return orders_screen();
      },
    ),

    GoRoute(
      name: routeNames.newOrder,
      path: routeNames.newOrder,
      builder: (BuildContext context, GoRouterState state) {
        return new_order_Screen();
      },
    ),

    /// endregion

    /// region menu tab
    GoRoute(
      name: routeNames.menu,
      path: routeNames.menu,
      builder: (BuildContext context, GoRouterState state) {
        return menu_screen();
      },
    ),

    GoRoute(
      name: routeNames.addNew_Item_in_Menu,
      path: routeNames.addNew_Item_in_Menu,
      builder: (BuildContext context, GoRouterState state) {
        final item = state.extra as MenuItemModel?;

        return add_new_item_screen(menuItem: item,);
      },
    ),

    GoRoute(
      name: routeNames.item_added_successfully,
      path: routeNames.item_added_successfully,
      builder: (BuildContext context, GoRouterState state) {
        return item_added_successfully();
      },
    ),

    GoRoute(
      name: routeNames.viewMenu_Item,
      path: routeNames.viewMenu_Item,
      builder: (BuildContext context, GoRouterState state) {
        // Extract the user model object from extra
        final item = state.extra as MenuItemModel;
        return item_DetailsPage(item: item,);
      },
    ),

    ///endregion

    ///region analystics tab
    GoRoute(
      name: routeNames.analytics,
      path: routeNames.analytics,
      builder: (BuildContext context, GoRouterState state) {
        return analytics_screen();
      },
    ),

    GoRoute(
      name: routeNames.insights,
      path: routeNames.insights,
      builder: (BuildContext context, GoRouterState state) {
        return insights_screen();
      },
    ),

    GoRoute(
      name: routeNames.growth,
      path: routeNames.growth,
      builder: (BuildContext context, GoRouterState state) {
        return growth_screen();
      },
    ),

    GoRoute(
      name: routeNames.customer_feedback_analysis,
      path: routeNames.customer_feedback_analysis,
      builder: (BuildContext context, GoRouterState state) {
        return customer_feedback_analysis_screen();
      },
    ),

    ///endregion

    /// region account tab
    GoRoute(
      name: routeNames.account,
      path: routeNames.account,
      builder: (BuildContext context, GoRouterState state) {
        return account_screen();
      },
    ),

    GoRoute(
      name: routeNames.restaurant_info,
      path: routeNames.restaurant_info,
      builder: (BuildContext context, GoRouterState state) {
        return restaurant_information_screen();
      },
    ),

    GoRoute(
      name: routeNames.edit_restaurant_info,
      path: routeNames.edit_restaurant_info,
      builder: (BuildContext context, GoRouterState state) {
        return edit_restaurant_information_screen();
      },
    ),

    GoRoute(
      name: routeNames.setting,
      path: routeNames.setting,
      builder: (BuildContext context, GoRouterState state) {
        return settings_screen();
      },
    ),

    GoRoute(
      name: routeNames.changePassword,
      path: routeNames.changePassword,
      builder: (BuildContext context, GoRouterState state) {
        return change_passwod_screen();
      },
    ),

    GoRoute(
      name: routeNames.deleteAccount,
      path: routeNames.deleteAccount,
      builder: (BuildContext context, GoRouterState state) {
        return delete_account_screen();
      },
    ),

    GoRoute(
      name: routeNames.termOfService,
      path: routeNames.termOfService,
      builder: (BuildContext context, GoRouterState state) {
        return term_of_service();
      },
    ),

    GoRoute(
      name: routeNames.privacyPolicy,
      path: routeNames.privacyPolicy,
      builder: (BuildContext context, GoRouterState state) {
        return privacy_policy();
      },
    ),

    GoRoute(
      name: routeNames.bank_Acc_details,
      path: routeNames.bank_Acc_details,
      builder: (BuildContext context, GoRouterState state) {
        return bank_account_details_screen();
      },
    ),

    GoRoute(
      name: routeNames.bank_Acc_Info,
      path: routeNames.bank_Acc_Info,
      builder: (BuildContext context, GoRouterState state) {
        final bank = state.extra as BankDataModel;

        return single_account_detail_screen(bank: bank);
      },
    ),

    GoRoute(
      name: routeNames.addNew_Bank,
      path: routeNames.addNew_Bank,
      builder: (BuildContext context, GoRouterState state) {
        return add_new_bank_screen();
      },
    ),

    GoRoute(
      name: routeNames.helpandSupport,
      path: routeNames.helpandSupport,
      builder: (BuildContext context, GoRouterState state) {
        return helpSupportScreen();
      },
    ),

    GoRoute(
      name: routeNames.contactUs,
      path: routeNames.contactUs,
      builder: (BuildContext context, GoRouterState state) {
        return contact_us_screen();
      },
    ),

    GoRoute(
      name: routeNames.feedback,
      path: routeNames.feedback,
      builder: (BuildContext context, GoRouterState state) {
        return feedback_screen();
      },
    ),

    GoRoute(
      name: routeNames.liveChat,
      path: routeNames.liveChat,
      builder: (BuildContext context, GoRouterState state) {
        return live_chatHelp_screen();
      },
    ),

    ///endregion
    // StatefulShellRoute.indexedStack  (
    //   builder: (context, state, navigationShell) {
    //     // Return the widget that implements the custom shell (e.g a BottomNavigationBar).
    //     // The [StatefulNavigationShell] is passed to be able to navigate to other branches in a stateful way.
    //     return dashboard(navigationShell);
    //   },
    //   branches: [
    //     // The route branch for the 1º Tab
    //     StatefulShellBranch(
    //       navigatorKey: _sectionNavigatorKey,
    //       // Add this branch routes
    //       // each routes with its sub routes if available e.g feed/uuid/details
    //       routes: <RouteBase>[
    //         ///Orders Tab
    //         GoRoute(
    //           path: '/orders',
    //           builder: (context, state) => orders_screen(),
    //           routes: <RouteBase>[
    //             GoRoute(
    //               path: 'newOrder',
    //               builder: (context, state) => new_order_Screen(),
    //             )
    //           ],
    //         ),
    //       ],
    //     ),
    //
    //     // The route branch for 2º Tab
    //     StatefulShellBranch(routes: <RouteBase>[
    //       // Add this branch routes
    //       // each routes with its sub routes if available e.g shope/uuid/details
    //
    //       ///Menu Tab
    //       GoRoute(path: '/menu', builder: (context, state) => menu_screen(), routes: <RouteBase>[
    //         GoRoute(
    //           path: 'addNewItem',
    //           builder: (context, state) => add_new_item_screen(),
    //         ),
    //         GoRoute(
    //           path: 'itemAdded',
    //           builder: (context, state) => item_added_successfully(),
    //         ),
    //       ]),
    //     ]), // The route branch for 3º Tab
    //     StatefulShellBranch(routes: <RouteBase>[
    //       ///Analytics Tab
    //       GoRoute(path: '/analytics', builder: (context, state) => const analytics_screen(), routes: <RouteBase>[
    //         GoRoute(
    //           path: 'insights',
    //           builder: (context, state) => const insights_screen(),
    //         ),
    //         GoRoute(
    //           path: 'growth',
    //           builder: (context, state) => const growth_screen(),
    //         ),
    //         GoRoute(
    //           path: 'customer',
    //           builder: (context, state) => const customer_feedback_analysis_screen(),
    //         ),
    //       ]),
    //     ]),
    //
    //     StatefulShellBranch(routes: <RouteBase>[
    //       ///Account Tab
    //       GoRoute(
    //         path: '/account',
    //         builder: (context, state) => const account_screen(),
    //         routes: <RouteBase>[
    //           GoRoute(
    //             path: 'setting',
    //             builder: (context, state) => const settings_screen(),
    //             routes: <RouteBase>[
    //               GoRoute(
    //                 path: 'delete_account',
    //                 builder: (context, state) => const delete_account_screen(),
    //               )
    //             ],
    //           )
    //         ],
    //       ),
    //     ]),
    //   ],
    // ),

    GoRoute(
      path: '/dashboar',
      builder: (context, state) => const dashboard(),
      routes: <RouteBase>[
        GoRoute(
          path: 'orders',
          builder: (context, state) => orders_screen(),
        ),
        GoRoute(
          path: 'menu',
          builder: (context, state) => menu_screen(),
        ),
        GoRoute(
          path: 'analytics',
          builder: (context, state) => const analytics_screen(),
        ),
        GoRoute(
          path: 'account',
          builder: (context, state) => const account_screen(),
        ),
      ],
    ),

    // ///Orders Tab
    // GoRoute(
    //   path: '/orders',
    //   builder: (context, state) => orders_screen(),
    //   routes: <RouteBase>[
    //     GoRoute(
    //       path: 'newOrder',
    //       builder: (context, state) => new_order_Screen(),
    //     ),
    //   ],
    // ),
    //
    // ///Menu Tab
    // GoRoute(path: '/menu', builder: (context, state) => menu_screen(), routes: <RouteBase>[
    //   GoRoute(
    //     path: 'addNewItem',
    //     builder: (context, state) => add_new_item_screen(),
    //   ),
    //   GoRoute(
    //     path: 'itemAdded',
    //     builder: (context, state) => item_added_successfully(),
    //   ),
    // ]),
    //
    // ///Analytics Tab
    // GoRoute(path: '/analytics', builder: (context, state) => const analytics_screen(), routes: <RouteBase>[
    //   GoRoute(
    //     path: 'insights',
    //     builder: (context, state) => const insights_screen(),
    //   ),
    //   GoRoute(
    //     path: 'growth',
    //     builder: (context, state) => const growth_screen(),
    //   ),
    //   GoRoute(
    //     path: 'customer',
    //     builder: (context, state) => const customer_feedback_analysis_screen(),
    //   ),
    // ]),
    //
    // // /Account Tab
    // GoRoute(
    //   path: '/account',
    //   builder: (context, state) => const account_screen(),
    //   routes: <RouteBase>[
    //     GoRoute(
    //       path: 'setting',
    //       builder: (context, state) => const settings_screen(),
    //       routes: <RouteBase>[
    //         GoRoute(
    //           path: 'delete_account',
    //           builder: (context, state) => const delete_account_screen(),
    //         )
    //       ],
    //     )
    //   ],
    // ),
  ],
);
