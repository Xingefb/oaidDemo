import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_user_agent/flutter_user_agent.dart';
import 'package:imei_plugin/imei_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Android_ids',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Android_ids'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String deviceId;
  String androId;
  String imei;
  String androidModel;
  String version;

  String systemName;
  String systemVersion;
  String os;
  String webUserAgent;
  String oaid;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  @override
  void initState() {
    super.initState();
  }

  _showMsg() async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    MethodChannel channel = MethodChannel('com.ids.lib/oaid');

    imei = await ImeiPlugin.getImei();
    if (null == imei) {
      imei = 'not get ';
    }
    androId = androidInfo.androidId;
    androidModel = androidInfo.model;

    systemName = await FlutterUserAgent.getPropertyAsync('systemName');
    systemVersion = await FlutterUserAgent.getPropertyAsync('systemVersion');
    os = '$systemName $systemVersion' ?? '';
    webUserAgent = await FlutterUserAgent.getPropertyAsync('webViewUserAgent');
    oaid = await channel.invokeMethod('oaid');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('获取'),
        onPressed: () {
          _showMsg();
        },
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '点击获取android ID 和 imei',
              // style: Theme.of(context).textTheme.display4,
            ),
            Text(
              'imei = $imei',
              style: Theme.of(context).textTheme.subtitle,
            ),
            Text(
              'androdi id = $androId',
              style: Theme.of(context).textTheme.subtitle,
            ),
            Text(
              'model = $androidModel',
              style: Theme.of(context).textTheme.subtitle,
            ),
            Text(
              'os = $os',
              style: Theme.of(context).textTheme.subtitle,
            ),
            Text(
              'oaid= $oaid',
              style: Theme.of(context).textTheme.subtitle,
            ),
            Text(
              'ua = $webUserAgent',
              style: Theme.of(context).textTheme.subtitle,
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
