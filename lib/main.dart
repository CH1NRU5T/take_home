// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, depend_on_referenced_packages
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'models/beer.dart';
import 'package:flutter/material.dart';
import 'package:take_home/services/network_helper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getList();
    loop();
    super.initState();
  }

  var list = [];
  bool _isLoading = false;
  String makeUrl(int entries) {
    return 'https://random-data-api.com/api/v2/beers?size=$entries&response_type=json';
  }

  int get getRandom {
    int r;
    Random rnd = Random();
    r = 2 + rnd.nextInt(100 - 2);
    return r;
  }

  int current = 10;
  void getList() async {
    setState(() {
      _isLoading = true;
    });
    var tempList = [];

    var response = await NetworkHelper.getRequest(url: makeUrl(getRandom));
    setState(() {
      _isLoading = false;
    });
    for (var obj in jsonDecode(response.body)) {
      tempList.add(Beer(
        brand: obj['brand'],
        name: obj['name'],
        alcohol: obj['alcohol'],
      ));
    }
    setState(() {
      list = tempList;
    });
  }

  void loop() async {
    Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (current == 0) {
        getList();
        setState(() {
          current = 10;
        });
      } else {
        setState(() {
          current--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 23, 24, 60),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            child: Text('$current'),
            onPressed: () {
              setState(() {
                current = 10;
              });
              getList();
            }),
        body: SafeArea(
          child: Center(
            child: _isLoading
                ? SpinKitSquareCircle(
                    color: Colors.orange[500],
                    size: 80,
                  )
                : ListView.builder(
                    itemCount: list.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext ctx, int index) {
                      return BeerContainer(beer: list[index]);
                    }),
          ),
        ),
      ),
    );
  }
}

class BeerContainer extends StatelessWidget {
  final Beer beer;
  BeerContainer({required this.beer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 11, horizontal: 10),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: beer.color,
        ),
        child: Text(
          overflow: TextOverflow.ellipsis,
          '${beer.name} by ${beer.brand} (${beer.alcohol} Alcohol)',
          softWrap: true,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
