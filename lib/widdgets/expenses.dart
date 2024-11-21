//add expensese
import 'package:flutter/material.dart';
import '../models/expens.dart';
import 'expenses_list/expense_list.dart';
import '../../widdgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() => _ExpensesState();
}
class _ExpensesState extends State<Expenses> {
  double totalIncome=5000;
  double totalExpense=0;
  double balance=0;
  List <Expense> _registersExpenses=[
  ];
  void _addExpense(){
    showModalBottomSheet(isScrollControlled:true,context: context, builder: (context)=>NewExpense(AddExpense:_saveNewExpense));}
  void _saveNewExpense(Expense expense){
    setState(() {
      _registersExpenses.add(expense);
      totalExpense+=expense.amount;
      balance=totalIncome-totalExpense;
    });
  }
  void _removeExpense(Expense expense){
    final expenseIndex=_registersExpenses.indexOf(expense);
    setState(() {
      _registersExpenses.remove(expense);
      totalExpense-=expense.amount;
      balance=totalIncome-totalExpense;
    });
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(action:SnackBarAction(label: 'Undo', onPressed: (){
     setState(() {
       _registersExpenses.insert(expenseIndex, expense);
     });
   }),content:Text('Expense Deleted '),duration: Duration(seconds: 3),),);
  }

  @override
  Widget build(BuildContext context) {
    Widget Content= Center(child: Text('No found Expenses'));
    if(_registersExpenses.isNotEmpty){
       Content=ExpensesList( expenses:_registersExpenses, RemoveExpense: _removeExpense,);
    }
    return  Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor:Colors.white ,
        title: Text(' Expense Traker '),
        actions: [

          IconButton(onPressed: (){}, icon: Icon(Icons.notifications))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Container(  alignment: Alignment.center,margin: EdgeInsets.only(bottom: 16),height:150,width: 390,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.purple[100]),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Total Balance',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400)),
                  Text('\$  $balance ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Spacer(),
                  Row(
                    children: [
                      Container(child: Row(
                        children: [
                          Icon(Icons.arrow_circle_down,size: 40,),
                          SizedBox(width: 8,),
                          Text('Income \n$totalIncome\$',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400)),
                        ],
                      ),),
                      Spacer(),
                      Container(child: Row(
                        children: [
                          Icon(Icons.arrow_circle_up,size: 40,),
                          SizedBox(width: 8,),
                          Text('Expense \n$totalExpense\$',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400)),
                        ],
                      ),),
                    ],
                  )
                ],
            ),)
          ],
          ),
          Expanded(child: Content),
        ],
            ),
      ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple[100],
          onPressed:_addExpense,
          child: const Icon(Icons.add),
        ),
      //bottomNavigationBar: NavigationBar(destinations: ),
    );
  }
}
