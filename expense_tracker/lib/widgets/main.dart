import '../widgets/chart.dart';
import '../widgets/new_transaction.dart';
import '../widgets/transaction_list.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.red,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(title: TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 18 ,
            fontWeight: FontWeight.bold,
          )) ,
          appBarTheme: AppBarTheme(textTheme: ThemeData.light().textTheme.copyWith(title: TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )))
      ),
      title: 'Paisa hi Paisa',
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //final titleController = TextEditingController();

  //final amountController = TextEditingController();

  final List<Transaction> _userTransaction = [];

  List<Transaction> get _recentTransactions{
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
          DateTime.now().subtract(
        Duration(days: 7),
      )
      );
    }
    ).toList();
  }


  void _addNewTransactions(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
      title: title,
      amount: amount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransaction.add(newTx);
    });
  }
  void _deleteTransaction(String id)
  {
    setState(() {
      _userTransaction.removeWhere((tx){
         return tx.id == id;
      });
    });
  }

  void _startAddNewTransactionProcess(BuildContext ctx)
  {
    showModalBottomSheet(context: ctx, builder: (_){
      return GestureDetector(
        onTap: () {},
        child: NewTransaction(_addNewTransactions),
        behavior: HitTestBehavior.opaque,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text('Paisa Hi Paisa',
         style: TextStyle(
           fontFamily: 'Open Sans',
           fontSize: 20
         ),
         ),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Chart(_recentTransactions),
              TransactionList(_userTransaction,_deleteTransaction)
            ],
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransactionProcess(context),
      ),
    );
  }
}

