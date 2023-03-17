import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  //CALLS _updateTransactions METHOD OF MAIN.DART
  final Function isUpdated;

  const TransactionList(
      {super.key, required this.transactions, required this.isUpdated});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: MediaQuery.of(context).size.height / 1.7,
      child: widget.transactions.isEmpty
          ? //SHOW ROBOT LOTTIE ANIMATION WHEN THERE ARE NO TRANSACTIONS INSTEAD ON LIST
          Lottie.asset('assets/robot.json')
          : MediaQuery.removePadding(
              context: context,
              removeTop: true,
              //GENERATE LISTS WHEN REQUIRED
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.transactions.length,
                itemBuilder: (ctx, index) {
                  final item = widget.transactions[index].id.toString();
                  return Dismissible(
                      key: Key(item),
                      onDismissed: (direction) {
                        // DELETES THE TRANSACTION
                        setState(() {
                          widget.transactions.removeAt(index);
                          widget.isUpdated();
                        });

                        //TO SHOW SNACKBAR WHEN TRANSACTION GET DELETED
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: const Duration(milliseconds: 500),
                            content: Text(
                                '${widget.transactions[index].name} is deleted.')));
                      },
                      // SHOWS A RED BACKGROUND WHEN ITEM GETS DELETED WITH SWIPE
                      background: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.red[400],
                        ),
                      ),
                      child:
                          //TRANSACTION CARD
                          TransactionItem(
                        txnName: widget.transactions[index].name,
                        txnTime: widget.transactions[index].time,
                        txnValue: widget.transactions[index].value,
                      ));
                },
              ),
            ),
    );
  }
}
