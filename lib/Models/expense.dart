import 'package:hive/hive.dart';
part 'expense.g.dart';

@HiveType(typeId: 0)
class Expense {
  @HiveField(0)
  final String exp;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool isExpense;

  Expense(this.exp, this.name, this.isExpense);
}
