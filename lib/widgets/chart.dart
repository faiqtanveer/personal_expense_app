import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './chartbar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart({super.key, required this.recentTransactions});

  //GETTER TO MAKE A LIST OF PAST 7 DAYS TRANSACTIONS (IS REVERSED TO SHOW CURRENT DAY AT LAST)
  List<Map<String, Object>> get groupedTransactionValues {
    var x = (List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].time.day == weekDay.day &&
            recentTransactions[i].time.month == weekDay.month &&
            recentTransactions[i].time.year == weekDay.year) {
          totalSum += recentTransactions[i].value;
        }
      }
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    }));

    return (x.reversed.toList());
  }

  //GETTER FOR TOTAL SPENDING FOR BAR HEIGHT CALCULATION
  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return recentTransactions.isEmpty
        ?
        //SHOWS IF NO TRANSACTION FOUND INSTEAD OF CHART
        Container(
            alignment: Alignment.bottomCenter,
            height: size.height / 3.8,
            child: const Text(
              "No Transactions Found",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
          )
        : //SHOWS CHART
        Container(
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionValues.map((data) {
                //PASS DATA TO CHARTBAR WIDGET THROUGH CONSTRUCTOR
                return ChartBar(
                    label: data['day'] as String,
                    spendingAmount: data['amount'] as double,
                    spendingPctOfTotal:
                        (data['amount'] as double) / totalSpending);
              }).toList(),
            ),
          );
  }
}
