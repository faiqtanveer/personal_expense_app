import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final double txnValue;
  final String txnName;
  final DateTime txnTime;

  const TransactionItem(
      {super.key,
      required this.txnValue,
      required this.txnName,
      required this.txnTime});

  @override
  Widget build(BuildContext context) {
    final thm = Theme.of(context).colorScheme;
    return Card(
      color: thm.tertiaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 0.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                '₹${txnValue.toStringAsFixed(2)}',
                style: TextStyle(
                    color: thm.onTertiaryContainer.withOpacity(0.7),
                    fontSize: 15,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                // color: Color.fromARGB(255, 252, 205, 63)),
                color: txnValue >= 500
                    ? Colors.red[300]
                    : (txnValue <= 100 ? Colors.green[300] : Colors.blue[300]),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    txnName,
                    style: TextStyle(
                        fontSize: 15.0, color: Colors.black.withOpacity(0.6)),
                  ),
                  Text(
                    DateFormat.yMMMd().add_jms().format(txnTime),
                    style: TextStyle(
                        fontSize: 10.0, color: Colors.black.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
