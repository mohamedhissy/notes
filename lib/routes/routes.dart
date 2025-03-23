import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../core/resources/manager_strings.dart';
import '../features/home/presentation/view/add_notes.dart';
import '../features/home/presentation/view/note_view.dart';


class Routes {
  static const String splashScreen = '/splash_screen';
  static const String outBoardingView = '/out_boarding_view';
  static const String loginView = '/login_view';
  static const String registerView = '/register_view';
  static const String homeView = '/home_view';
  static const String profileView = '/profile_view';
  static const String detailsView = '/view_details';
  static const String settingView = '/setting_view';
  static const String cartView = '/cart_view';
  static const String brandView = '/view_details';
  static const String addNote = '/add_notes';
  static const String noteView = '/note-view';

}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
    //   case Routes.splashScreen:
    //     initSplash();
    //     return MaterialPageRoute(builder: (_) => const SplashScreen());
    //   case Routes.outBoardingView:
    //     return MaterialPageRoute(builder: (_) =>  OutBoardingView());
    //   case Routes.loginView:
    //     initAuth();
    //     return MaterialPageRoute(builder: (_) => const LoginView());
    //   case Routes.registerView:
    //     initAuth();
    //     return MaterialPageRoute(builder: (_) =>  RegisterView());
    //   case Routes.homeView:
    //     initHome();
    //     return MaterialPageRoute(builder: (_) => const HomeView());
    //   case Routes.profileView:
    //     initProfile();
    //     return MaterialPageRoute(builder: (_) =>  ProfileView());
    //   case Routes.detailsView:
    //     initDetailse();
    //     return MaterialPageRoute(builder: (_) =>  DetailsView());
      case Routes.noteView:
        return MaterialPageRoute(builder: (_) =>  NoteView());
    case Routes.addNote:
      return MaterialPageRoute(builder: (_) =>  AddNotes());
      default:
        return unDefineRoute();
    }
  }

  static Route<dynamic> unDefineRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text(ManagerStrings.notFoundRoute),
        ),
      ),
    );
  }
}

