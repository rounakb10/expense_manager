import 'package:expense_manager/Models/expense.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:theme_provider/theme_provider.dart';

class AddIncomeScreen extends StatefulWidget {
  @override
  _AddIncomeScreenState createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  @override
  Widget build(BuildContext context) {
    String exp;
    String name;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Income',
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    filled: true,
                    icon: Icon(
                      Icons.account_balance_wallet,
                    ),
                    hintText: 'Enter income name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    name = value;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    icon: Icon(
                      Icons.trending_up,
                    ),
                    hintText: 'Enter income amount',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    exp = int.parse(value).toString();
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(10),
                highlightColor: Colors.grey.shade800,
                onTap: () {
                  if (exp != null && name != null) {
                    final expense = Expense(exp, name, false);
                    addExpense(expense);
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  decoration: new BoxDecoration(
                    color: ThemeProvider.themeOf(context)
                        .data
                        .inputDecorationTheme
                        .fillColor,
                    borderRadius: new BorderRadius.circular(10),
                  ),
//                  color: Colors.grey,
                  height: 40,
                  width: 100,
                  child: Center(child: Text('Add')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addExpense(Expense expense) {
    Hive.box('expense').add(expense);
  }
}
