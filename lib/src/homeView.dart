import 'package:flutter/material.dart';

import '../main.dart';
import 'findNewView.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    Valueer.size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: FindNewView(),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.settings),
                          iconSize: 32.0,
                          onPressed: null,
                        ),
                        IconButton(
                          icon: Icon(Icons.menu),
                          iconSize: 32.0,
                          onPressed: null,
                        ),
                        IconButton(
                          icon: Icon(Icons.message_outlined),
                          iconSize: 32.0,
                          onPressed: null,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
