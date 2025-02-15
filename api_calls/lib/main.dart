import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 30, 23, 40)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'API CALLS'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List data = [];
  List id = [];
  List rover = [];
  String url =
      "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&page=2&api_key=xMZrxsMhjwJ0zufDcQq6KpfuDBunWJ3DaChvyiGi";
  bool isLoaded = false;

  Future getData() async {
    var response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    var myData = responseData["photos"];
    int i;
    debugPrint(myData.toString());
    for (i = 0; i < myData.length; i++) {
      data.add(myData[i]["img_src"]);
      id.add(myData[i]["id"]);
      rover.add(myData[i]["rover"]["name"]);
    }
    setState(() {
      //isLoaded = true;
    });

    debugPrint(data.toString());
  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Colors.amber,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return isLoaded
                ? Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        width: double.infinity,
                        // color: Colors.amber,
                        child: Image.network(data[index]),
                      ),
                      TextButton(
                          onPressed: () {
                            var sk = SnackBar(
                              content: Text(rover[index].toString()),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(sk);
                          },
                          child: Text("details")),
                    ],
                  )
                : Lottie.network(
                    "https://lottie.host/9fb2ee60-46a6-46c8-9a83-7655a281c6ff/G8JjHqW9rJ.lottie");
          }),
    );

    // floatingActionButton:
    // FloatingActionButton(
    //   onPressed: _incrementCounter,
    //   tooltip: 'Increment',
    //   child: const Icon(Icons.add),
    // ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
