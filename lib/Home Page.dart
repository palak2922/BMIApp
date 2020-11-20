import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_appnew/Constants.dart';
import 'package:flutter_appnew/Tab_Data.dart';




class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}



class Constants{
  static const String Signout = 'sign out';
  static const String Menu = 'menu';
  static const String Home = 'home';

  static const List<String> choices = [
    'sign out',
    'menu',
    'home',
  ];

}


class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {



  TabController tabController;


  @override
  void initState() {
    tabController = new TabController(length: 4, vsync: this);
    super.initState();
  }


  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }






  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: AppBar(
            backgroundColor: Colors.green,
            title: Center(
              child: Text(
              'FLASHAT',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
            ),
            leading:
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    minRadius: 20,
                    child: Image.asset('img/PD.png', fit: BoxFit.fill,),
                  ),
                ],
              ),

            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0, right: 20,),
                child: Row(
                  children: [
                    Icon(Icons.search, size: 30,),
                    PopupMenuButton<String>(
                      onSelected: choiceAction,
                      itemBuilder: (BuildContext context){
                        return Constants.choices.map((String choice){
                          return PopupMenuItem(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      },
                    ),
                  ],
                ),
              ),
            ],
            bottom: TabBar(
              controller: tabController,
              indicatorColor: CupertinoColors.white,
              indicatorWeight: 5,
              tabs: <Widget>[
                Tab(
                  child: Row(
                    children: [
                      Text('PERSONAL', style: kTabBarTextStyle,),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: [
                      Text('BUSINESS', style: kTabBarTextStyle,),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: [
                      Text('HUDDLES', style: kTabBarTextStyle,),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    children: [
                      Text('CALLS', style: kTabBarTextStyle,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        body: TabBarView(
          controller: tabController,
          children: [

            TabData(),
            TabData(),
            TabData(),
            TabData(),

          ],
        ),
      ),
    );
  }

  void choiceAction(String action){
  }
}



