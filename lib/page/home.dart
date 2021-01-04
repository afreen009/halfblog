import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_signin_example/provider/google_sign_in.dart';
import 'package:google_signin_example/tabs/videosPage.dart';
import 'package:provider/provider.dart';
import '../services/theme_changer.dart';
import '../tabs/home_tab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(user.displayName.toString()),
        titleSpacing: 8.0,
        actions: <Widget>[
          InkWell(
            child: CircleAvatar(backgroundColor: Colors.amber, child: FaIcon(FontAwesomeIcons.lightbulb)),
            onTap: themeChanger.toggle,
          ),
          InkWell(
            child: CircleAvatar(backgroundColor: Colors.red, child: FaIcon(FontAwesomeIcons.powerOff)),
            onTap: (){
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            }
          )
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: <Widget>[
          HomeTab(),
          VideoPlayerApp()
          // CategoriesTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Articles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Videos',
          ),
        ],
      ),
    );
  }
}
