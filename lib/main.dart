// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }



import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'Screens/V2/Home/home_screen.dart';
import 'Screens/V2/Login/login_screen.dart';
import 'Screens/V2/Splash/splash_screen_v1.dart';
import 'constants.dart';
import 'shared/globals/data.dart';
import 'shared/services/inicio_service.dart';


Future<void> main() async {
//   //Remove this method to stop OneSignal Debugging
//   OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
//
//   OneSignal.initialize("b68b56b5-86aa-41b0-941c-ec13680666e9");
//
// // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
//   OneSignal.Notifications.requestPermission(true);
//

  WidgetsFlutterBinding.ensureInitialized();

  if (kReleaseMode) {
    await dotenv.load(fileName: "assets/environments/production.env");
  } else {
    await dotenv.load(fileName: "assets/environments/development.env");
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: const MyApp(isLoggedIn: true),
    ),
  );

}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    var appProvider = Provider.of<AppProvider>(context, listen: false);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Depilzone',
      theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                foregroundColor: Colors.white,
                backgroundColor: kDepilColor,
                shape: const StadiumBorder(),
                maximumSize: const Size(double.infinity, 56),
                minimumSize: const Size(double.infinity, 56)
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(

            errorStyle: TextStyle(
              color: kWarningColor,
            ),

            filled: true,
            //fillColor: kGray200Color,
            fillColor: Colors.white,
            hoverColor: Colors.white,
            // iconColor: kGray200Color,
            prefixIconColor: kGray400Color,
            contentPadding:  EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            border:  OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(
                  color: kGray200Color,
                  width: 2.5,
                  style: BorderStyle.solid,
                  strokeAlign: BorderSide.strokeAlignOutside
              ),
            ),
            enabledBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(
                    color: kGray200Color,
                    width: 2.5
                )
            ),
            focusedBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(
                  color: kGray300Color,
                  width: 2.5
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(
                  color: kWarningColor,
                  width: 2.5
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(
                  color: kWarningColor,
                  width: 2.5
              ),
            ),
          )
      ),
      // initialRoute: isLoggedIn ? '/home' : '/login',
      routes: {
        // '/login': (context) => BlocProvider(
        //   create: (context) => AuthBloc(),
        //   child: const LoginScreen(),
        // ),
        '/login': (context) => const LoginScreen(),
        // '/home': (context) =>  isLoggedIn ? const LoginScreen() : const LoginScreen(),
        '/home': (context) =>  const HomeScreen(),
        // '/qr': (context) => const ScannerQrScreen(),
        // '/waiting': (context) => const ClientListScreen(),
      },

      // home: ChangeNotifierProvider(
      //   create: (context) => AppData(),
      //   child: TaskScreen(),
      // )

      home: FutureBuilder(
        future: fetchDataAndUpdateNotifier(appProvider),
        builder: (context, snapshot){
          // log(context.watch<AppProvider>().usuario!.apellido);
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text('Press button to start.');
            case ConnectionState.active:
            case ConnectionState.waiting:
            // return Text('Data loaded successfully: ${appProvider.text}');
              return const SplashScreen();
            case ConnectionState.done:
            // Aquí puedes realizar acciones después de que el Future<void> se complete
              return appProvider.usuario != null ?  const HomeScreen() : const LoginScreen();
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const Text('Error:');
              }
          }
        },
      ),

      // home: const WelcomeScreen(),
    );
  }
}
