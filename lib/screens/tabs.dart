import '../screens/charts.dart';
import 'package:flutter/material.dart';
import '../widdgets/expenses.dart';
class TabScreen extends StatefulWidget {
  const TabScreen({super.key});
  @override
  State<TabScreen> createState() => _TabScreenState();
}
class _TabScreenState extends State<TabScreen> {
  int _selectedPageIndex=0;
  void _selectPage(int index){
    setState(() {
      _selectedPageIndex=index;

    });
  }
  @override
  Widget build(BuildContext context) {
    Widget activePage= Expenses();
    if(_selectedPageIndex==1){
      activePage=ChartsScreen();
    }
    return Scaffold(
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(selectedItemColor: Colors.purple,
        currentIndex: _selectedPageIndex,items: [
        BottomNavigationBarItem(icon:Icon(Icons.attach_money),label: 'Expenses'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart),label: 'Charts')
      ],
      onTap: _selectPage,),
    );
  }
}
