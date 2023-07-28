import 'dart:async';

import 'package:estimation_land_online_client/estimation_land_online_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

// Sets up a singleton client object that can be used to talk to the server from
// anywhere in our app. The client is generated from your server code.
// The client is set up to connect to a Serverpod running on a local server on
// the default port. You will need to modify this to connect to staging or
// production servers.
var client = Client('http://localhost:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serverpod Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Serverpod Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  String? _resultMessage;
  String? _errorMessage;
  final List<String> _storypoints = ['0.5', '1', '2', '3', '5', '8', '13', '?'];
  final _nameEditingContr = TextEditingController();
  final _topicEditingContr = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer t) {
      _sendServer('2');
    });
    super.initState();
  }

  String getString(List<Estimation> estimations) {
    String result = '';
    for (Estimation estimation in estimations) {
      if (estimation.name == '') {
        continue;
      }
      result +=
          '${estimation.name}     ${estimation.topic}     ${estimation.storypoint}\n';
    }
    return result;
  }

  void _sendServer(String storypoints) async {
    try {
      final r = await client.estimation.giveEstimation(Estimation(
        storypoint: storypoints,
        name: _nameEditingContr.text,
        topic: _topicEditingContr.text,
      ));
      setState(() {
        _resultMessage = getString(r);
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = '$e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                controller: _nameEditingContr,
                decoration: const InputDecoration(
                  hintText: 'Enter your name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                controller: _topicEditingContr,
                decoration: const InputDecoration(
                  hintText: 'Enter topic',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(spacing: 20, children: [
                for (String sp in _storypoints)
                  ElevatedButton(
                    onPressed: () => _sendServer(sp),
                    child: Text(sp),
                  ),
              ]),
            ),
            _ResultDisplay(
              resultMessage: _resultMessage,
              errorMessage: _errorMessage,
            ),
          ],
        ),
      ),
    );
  }
}

// _ResultDisplays shows the result of the call. Either the returned result from
// the `example.hello` endpoint method or an error message.
class _ResultDisplay extends StatelessWidget {
  final String? resultMessage;
  final String? errorMessage;

  const _ResultDisplay({
    this.resultMessage,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    String text;
    Color backgroundColor;
    if (errorMessage != null) {
      backgroundColor = Colors.red[300]!;
      text = errorMessage!;
    } else if (resultMessage != null) {
      backgroundColor = Colors.green[300]!;
      text = resultMessage!;
    } else {
      backgroundColor = Colors.grey[300]!;
      text = 'No server response yet.';
    }

    return Container(
      height: 280,
      color: backgroundColor,
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
