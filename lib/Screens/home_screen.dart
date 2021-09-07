import 'package:expense_manager/Models/expense.dart';
import 'package:flutter/material.dart';
// import 'package:expense_manager/Widgets/small_card.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:toast/toast.dart';

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
          '\tExpenses',
          style: TextStyle(fontSize: 24),
        ),
        //centerTitle: true,
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
    final List<ChartData> chartData = [
      ChartData('Expenses', expenses, Colors.red),
      ChartData('Income', income, Colors.greenAccent),
    ];
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextWithNumber(num: balance, name: 'Balance'),
            SizedBox(height: 24),
            Divider(),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWithNumber(num: income, name: 'Income'),
                SizedBox(width: MediaQuery.of(context).size.width / 3),
                TextWithNumber(num: expenses, name: 'Expense'),
              ],
            ),
            SizedBox(height: 24),
            Divider(),
            SizedBox(height: 30),
            chart(chartData, income, expenses)
          ],
        ),
      ),
    );
  }

  Widget chart(var chartData, var income, var expenses) {
    if (income == 0 && expenses == 0)
      return SizedBox(
        height: 0,
      );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: SfCircularChart(
            legend: Legend(
              isVisible: true,
              overflowMode: LegendItemOverflowMode.wrap,
            ),
            series: <CircularSeries>[
              PieSeries<ChartData, String>(
                dataSource: chartData,
                pointColorMapper: (ChartData data, _) => data.color,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                radius: '110%',
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                ),
                animationDuration: 500,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TextWithNumber extends StatelessWidget {
  final int num;
  final String name;

  TextWithNumber({this.num, this.name});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
        ),
        Text(
          '\t$name',
          style: TextStyle(fontSize: 21),
        ),
        SizedBox(
          height: 18,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '\t₹ $num',
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final int y;
  final Color color;
}
