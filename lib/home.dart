import 'package:flutter/material.dart';
import 'package:residemenu/residemenu.dart';
import 'package:toughest/detail.dart';
import 'package:share/share.dart';
import 'package:toughest/textStyle.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'package:flutter/gestures.dart';
// import 'package:firebase_admob/firebase_admob.dart';
// import 'appid.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:carousel_pro/carousel_pro.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return new HomeState();
  }
}

//This class helps to create links, that we are using in about dialog.
class _LinkTextSpan extends TextSpan {
  _LinkTextSpan({TextStyle style, String url, String text})
      : super(
            style: style,
            text: text ?? url,
            recognizer: new TapGestureRecognizer()
              ..onTap = () {
                urlLauncher.launch(url);
              });
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  MenuController _menuController;
  var data;


  /// to build a reside menu drawer build by library
  Widget buildItem(String msg, VoidCallback method) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        child: ResideMenuItem(
          title: msg,
          icon: const Icon(Icons.home, color: Colors.grey),
          right: const Icon(Icons.arrow_forward, color: Colors.grey),
        ),
        onTap: () => method,
      ),
    );
  }

  _sharer() {
    Share.share(" TOUGHEST - Test your knowledge.\n" +
        "The app that will make you an amazing candidate for any job.\n"
        "Are you ready?\n"
        "Download it now\n"
        "https://play.google.com/store/apps/details?id=tricky.questions");
  }

  _launchgmail() async {
  const url = 'mailto:indiancoder001@gmail.com?subject=Feedback&body=Feedback for Toughest';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
     super.initState();
    //notification configs.
    // messaging.configure(
    //     onLaunch: (Map<String, dynamic> event) {},
    //     onMessage: (Map<String, dynamic> event) {},
    //     onResume: (Map<String, dynamic> event) {});

    //menucontroller for residemenu drawer.
    _menuController = new MenuController(vsync: this);

    // FirebaseAdMob.instance.initialize(appId: Appid.ADMOB_APP_ID);
    // bannerAd = createBannerAd()
    //   ..load()
    //   ..show();

  }

  @override
  void dispose() {
    // bannerAd?.dispose();
    super.dispose();
  }

///shows the about dialog.
  showAbout(BuildContext context) {
    final TextStyle bodyStyle =
        new TextStyle(fontSize: 15.0, color: Colors.black);

    return showAboutDialog(
        context: context,
        applicationIcon: Center(
          child: Image(
            height: 150.0,
            width: 200.0,
            fit: BoxFit.fitWidth,
            image: AssetImage("assets/images/icon.jpg"),
          ),
        ),
        children: <Widget>[
          new Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: new RichText(
                  textAlign: TextAlign.start,
                  text: new TextSpan(children: <TextSpan>[
                    new TextSpan(
                        style: bodyStyle,
                        text: 'Bienvenido'
                            "\n\n"),
                    new TextSpan(
                      style: bodyStyle,
                      text: 'Rosanyela Hurtado Rico' + "\n\n",
                    ),
                  ]))),
        ]);
  }

  ///Lis-t of interview questions.
  Widget getListItems(Color color, IconData icon, String title) {
    return GestureDetector(
        child: Container(
          color: color,
          height: 300.0,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 100.0,
                color: Colors.white,
              ),
              Text(
                title,
                style: Style.headerstyle,
              )
            ],
          )),
        ),
        onTap: () async {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Detail(
                    title: title,
                  )));
        });
  }

///creating a carousel using carousel pro library.
  final myCraousal = Carousel(
    dotSize: 5.0,
    dotIncreaseSize: 2.0,
    borderRadius: true,
    radius: Radius.circular(10.0),
    animationCurve: Curves.easeInOut,
    animationDuration: Duration(seconds: 2),
    images: [
      AssetImage('assets/images/card1.png'),
      AssetImage('assets/images/card3.png'),
      AssetImage('assets/images/card4.png'),
      AssetImage('assets/images/card2.png'),
    ],
  );

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    //to use reside menu library we have to return a residemenu scafford.
    return new ResideMenu.scaffold(
      // direction: ScrollDirection.LEFT,
      decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover)),
      controller: _menuController,
      leftScaffold: new MenuScaffold(
        header: new ConstrainedBox(
          constraints: new BoxConstraints(maxHeight: 80.0, maxWidth: 100.0),
          child: new CircleAvatar(
            backgroundImage: new AssetImage('assets/images/icon.jpg'),
            radius: 30.0,
          ),
        ),
        children: <Widget>[
          ///I have to make these drawer list widgets manually cause it is containing different methods.
          new Material(
            color: Colors.transparent,
            child: new InkWell(
              child: ResideMenuItem(
                title: 'Comparte',
                 titleStyle: TextStyle(color: Colors.black),
                icon: const Icon(Icons.share, color: Colors.black),
              ),
              onTap: () => _sharer(),
            ),
          ),
          new Material(
            color: Colors.transparent,
            child: new InkWell(
              child: ResideMenuItem(
                title: 'Sugerencias',
                titleStyle: TextStyle(color: Colors.black),
                icon: const Icon(Icons.info, color: Colors.black),
              ),
              onTap: () => _launchgmail(),
            ),
          ),
        ],
      ),
      child: new Scaffold(
        appBar: new AppBar(
          elevation: 10.0,
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: new GestureDetector(
            child: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onTap: () {
              _menuController.openMenu(true);
            },
          ),
          title: new Text(
            'VOTACIÓN',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 20.0,
                ),
                onPressed: () => showAbout(context))
          ],
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 5.0),
              height: height / 2.5,
              child: myCraousal,
            ),
            getListItems(Color(0xFFF44336), Icons.camera_alt, 'Registra Resultados'),
            getListItems(Color(0xFFFBC02D), Icons.wc, 'Buscar Participantes'),
            getListItems(Color(0xFF13B0A5), Icons.info_outline, 'Consultar Mesa'),
          ],
        ),
      ),
    );
  }
}
