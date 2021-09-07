import 'dart:ui';

import 'package:expense_manager/Models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '\tTransactions',
          style: TextStyle(fontSize: 24),
        ),
        // centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
        child: ValueListenableBuilder(
          valueListenable: Hive.box('expense').listenable(),
          builder: (BuildContext context, Box<dynamic> expenseBox, _) {
            if ((expenseBox.length == 0) ||
                (getIncome(expenseBox) == 0 && getExpense(expenseBox) == 0))
              return Center(
                child: Text(
                  'Looks like it\'s empty\n\n\nAdd an income or expense\nusing the "+" Button below',
                  style: TextStyle(fontSize: 24, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              );
            return ListView.builder(
              padding: EdgeInsets.only(top: 4, bottom: 50),
              physics: BouncingScrollPhysics(),
              itemCount: expenseBox.length,
              itemBuilder: (context, index) {
                final expense =
                    expenseBox.get(expenseBox.length - index - 1) as Expense;
                if (int.parse(expense.exp) != 0)
                  return Card(
                    //elevation: 4,
                    //color: Colors.grey.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      leading: expense.isExpense
                          ? Icon(
                              Icons.trending_down,
                              color: Colors.red,
                            )
                          : Icon(
                              Icons.trending_up,
                              color: Colors.green,
                            ),
                      title: Text(
                        expense.name,
                        style: TextStyle(fontSize: 21),
                      ),
                      visualDensity: VisualDensity.comfortable,
                      subtitle: Text(
                        '₹' + expense.exp,
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: IconButton(
                        icon: Icon(CupertinoIcons.clear),
                        onPressed: () {
                          return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Delete ${expense.name}?'),
                                actions: <Widget>[
                                  MaterialButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      Hive.box('expense').putAt(
                                          expenseBox.length - index - 1,
                                          Expense(0.toString(), null, true));
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'OK',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  );
                else
                  return SizedBox();
              },
            );
          },
        ),
      ),
    );
  }

  int getIncome(Box expenseBox) {
    int inc = 0;
    for (int i = 0; i < expenseBox.length; i++) {
      final expense = expenseBox.get(i) as Expense;
      if (!expense.isExpense) inc = inc + (int.parse(expense.exp));
    }
    return inc;
  }

  int getExpense(Box expenseBox) {
    int exp = 0;
    for (int i = 0; i < expenseBox.length; i++) {
      final expense = expenseBox.get(i) as Expense;
      if (expense.isExpense) exp = exp + (int.parse(expense.exp));
    }
    return exp;
  }
}
