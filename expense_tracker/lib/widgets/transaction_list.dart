import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
class TransactionList extends StatelessWidget {
  @override
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      child: transactions.isEmpty ? Column(
        children: [
          //Text('No transactions added yet!'),
          SizedBox(
            height: 10
          ),
          Container(
            child: Image.asset('assets/images/nopay.png',
            fit: BoxFit.cover,
            ),
          )
          
        ],
      ):
      ListView.builder(
        itemBuilder: (ctx, index){
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
            child: ListTile(
              leading: CircleAvatar(radius: 30,
                backgroundColor: Theme.of(context).errorColor,
                foregroundColor: Theme.of(context).accentColor,
                child: Padding(
                    padding: EdgeInsets.all(7),
                    child: FittedBox(child: Text('\u{20B9}' + transactions[index].amount.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    ))),
              ),
              title: Text(transactions[index].title,
                style: TextStyle(
                  color: Theme.of(context).errorColor,
                  fontWeight: FontWeight.bold
                ),
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(transactions[index].date,
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Color(0xffea5455),// It is red by default can set if wanted
                onPressed: (){
                       deleteTx(transactions[index].id);
                },
              ),
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );

  }
}
