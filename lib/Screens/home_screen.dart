import 'package:expense_manager/Models/expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_manager/Widgets/small_card.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:toast/toast.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
//    Hive.openBox('expense');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expenses',
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
      ),
      // ignore: deprecated_member_use
      body: ValueListenableBuilder(
        valueListenable: Hive.box('expense').listenable(),
        builder: (BuildContext context, Box<dynamic> expenseBox, _) {
//          final expenseBox = Hive.box('expense');
          int size = expenseBox.length;

          int exp = 0;
          int inc = 0;

          for (int i = 0; i < size; i++) {
            final expense = expenseBox.get(i) as Expense;
            if (expense.isExpense)
              exp = exp + (int.parse(expense.exp));
            else
              inc = inc + (int.parse(expense.exp));
          }

          return safeArea(inc - exp, inc, exp);
//          if (snapshot.connectionState == ConnectionState.done) {
//            if (snapshot.hasError)
//              return safeArea(0, 0, 0);
//            else
//              return safeArea(inc - exp, inc, exp);
//          } else
//            return safeArea(2, 2, 2);
        },
      ),
    );
  }

  Widget safeArea(int balance, int income, int expenses) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 24,
            ),
            Text(
              '\tBalance',
              style: TextStyle(fontSize: 21),
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '\t₹ $balance',
                  style: TextStyle(fontSize: 30),
                ),
                IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    size: 25,
                  ),
                  onPressed: () {
                    Toast.show("Nope", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  },
                ),
              ],
            ),
            SizedBox(height: 100),
//            SmallCard(
//              str: 'Income',
//              icon: Icons.trending_up,
//              value: '\₹ $income',
//            ),
//            SizedBox(height: 40),
//            SmallCard(
//              str: 'Expenses',
//              icon: Icons.trending_down,
//              value: '\₹ $expenses',
//            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SmallCard(
                  str: 'Income',
                  icon: Icons.trending_up,
                  value: '\₹ $income',
                ),
                SizedBox(
                  width: 10,
                ),
                SmallCard(
                  str: 'Expenses',
                  icon: Icons.trending_down,
                  value: '\₹ $expenses',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
