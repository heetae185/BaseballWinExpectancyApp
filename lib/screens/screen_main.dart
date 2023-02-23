import 'package:baseball_win_expectancy/screens/screen_baseball.dart';
import 'package:baseball_win_expectancy/screens/screen_detail.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Baseball Win Expectancy'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(45),
            child: Container(
              color: Colors.white,
              child: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Color(0xFF898989),
                controller: _tabController,
                // indicatorColor: Color(0xFF9CC06F),
                indicatorColor: Colors.green,
                // indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  SizedBox(
                    height: 45,
                    child: Tab(
                      child: Align(
                        alignment: Alignment(0.3, 0.5),
                        child: Text(
                          '상황 설정하기',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 45,
                    child: Tab(
                      child: Align(
                        alignment: Alignment(-0.3, 0.5),
                        child: Text(
                          '자세히 보기',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
      body: TabBarView(
        controller: _tabController,
        children: [
          BaseballScreen(),
          DetailScreen(),
        ],
      ),
    );
  }
}
