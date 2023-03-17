import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './theme.dart';
import './widgets/chart.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      home: const MyHomePage(),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //LIST OF TRANSACTIONS [Added Few Dummy Transactions]
  final List<Transaction> _userTransactions = [
    Transaction(id: 1, value: 100.00, name: 'Cookies', time: DateTime.now()),
    Transaction(
        id: 2,
        value: 1230.00,
        name: 'Bournvita',
        time: DateTime.now().subtract(const Duration(days: 3))),
    Transaction(
        id: 3,
        value: 140.00,
        name: 'Biryani',
        time: DateTime.now().subtract(const Duration(days: 5))),
    Transaction(
        id: 4,
        value: 130.00,
        name: 'Pants',
        time: DateTime.now().subtract(const Duration(days: 2))),
    Transaction(
        id: 5,
        value: 500.00,
        name: 'Battery',
        time: DateTime.now().subtract(const Duration(days: 6))),
    Transaction(
        id: 6,
        value: 50.00,
        name: 'Cable',
        time: DateTime.now().subtract(const Duration(days: 1))),
    Transaction(
        id: 7,
        value: 400.00,
        name: 'Hotstar',
        time: DateTime.now().subtract(const Duration(days: 4))),
    Transaction(
        id: 8,
        value: 900.00,
        name: 'Jio Recharge',
        time: DateTime.now().subtract(const Duration(days: 3))),
    Transaction(
        id: 9,
        value: 440.00,
        name: 'Wifi Recharge',
        time: DateTime.now().subtract(const Duration(days: 5))),
  ];

  //METHOD TO ADD NEW TRANSACTION
  void _addNewTransaction(String txTitle, double txAmount, DateTime txTime) {
    final newTx = Transaction(
        id: txTime.day, value: txAmount, name: txTitle, time: txTime);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  //METHOD TO UPDATE UI WHEN TRANSACTION GETS DELETED FROM TRANSACTION LIST
  void _updateTransactions() {
    setState(() {
      _userTransactions;
    });
  }

  //METHOD TO SHOW A MODAL OF NEW TRANSACTION
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (_) {
          return NewTransaction(newTxn: _addNewTransaction);
        });
  }

  //METHOD TO FILTER RECENT TRANSACTIONS WITHIN 7 DAYS FROM TRANSACTIONS LIST
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.time.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final thm = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final appBar = AppBar(
      centerTitle: true,
      backgroundColor:
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Colors.black12
              : Colors.white10,
      toolbarHeight: 50,
      title: Text(
        'Personal Expenses',
        style:
            TextStyle(color: thm.primaryContainer, fontWeight: FontWeight.w600),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 30),
          child: IconButton(
            onPressed: () {
              _startAddNewTransaction(context);
            },
            icon: const Icon(Icons.add_circle_outline_outlined),
            color: thm.secondary.withOpacity(0.7),
          ),
        )
      ],
    );

    //ACTUAL HEIGHT CALCULATION & FOR WEB DEDUCTION OF URL BAR {Alternatively SafeArea Works}
    final actualHeight = size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom -
        (kIsWeb ? 10 : 0);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: thm.background,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          padding: size.width < 820
              ? EdgeInsets.fromLTRB(size.width * 0.03, 10, size.width * 0.03, 0)
              : EdgeInsets.fromLTRB(size.width * 0.2, 10, size.width * 0.2, 0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            // CHART CARD
            SizedBox(
              height: actualHeight * 0.35,
              child: Chart(recentTransactions: _recentTransactions),
            ),
            // TRANSACTIONS LIST CARD
            SizedBox(
              height: actualHeight * 0.65,
              child: TransactionList(
                  transactions: _userTransactions,
                  isUpdated: _updateTransactions),
            ),
          ]),
        ),
      ),
    );
  }
}
