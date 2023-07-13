import 'package:cityco/blocs/authentication/auth_bloc.dart';
import 'package:cityco/configurations/app_color.dart';
import 'package:cityco/configurations/app_constant.dart';
import 'package:cityco/screens/authentication_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;

  final bool homePage;
  final IconButton? leading_icon_Button;

  const BaseAppBar(
      {required this.appBar, required this.homePage, this.leading_icon_Button});

  @override
  Widget build(BuildContext context) {
    var _deviceSize = MediaQuery.of(context).size;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSignOut) {
          Navigator.pushReplacementNamed(
              context, AuthenticationScreen.routeName);
        }
      },
      child: AppBar(
        elevation: 0,
        leading: homePage
            ? Image.asset(
                "assets/images/logo.png",
                width: _deviceSize.width / 10,
                height: _deviceSize.height / 10,
              )
            : leading_icon_Button,
        backgroundColor: themeColor,
        centerTitle: true,
        title: Text(
          appName,
          style: GoogleFonts.aBeeZee(
              color: mainTextColor, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.account_circle_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              showSignOutAlertDialog(context);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sorry, not implemented yet')));
            },
          )
        ],
      ),
    );
  }

  Future<void> showSignOutAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text(
            'Do you want to Logout?',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            SimpleDialogOption(
              onPressed: () {
                context.read<AuthBloc>().add(SignOutUser());
                Navigator.pop(context);
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
