import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTxn; //NEW TRANSACTION RECEIVED FROM MAIN.DART

  const NewTransaction({super.key, required this.newTxn});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  //TEXTFIELD BUILDER
  Widget textFieldBuilder(
      {required TextEditingController controller,
      required ColorScheme theme,
      required String labelText}) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: theme.onSurface.withAlpha(20),
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  //METHOD TO OPENCALENDER
  Future<void> _opencalender(BuildContext ctx) async {
    final DateTime? picked = await showDatePicker(
      context: ctx,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  //METHOD TO SUBMIT DATA
  void submitData() {
    final enteredTitle = _titleController.text;

    final enteredAmount = double.parse(_amountController.text);

    if (enteredAmount < 0 || enteredTitle.isEmpty) {
      return;
    }
    widget.newTxn(enteredTitle, enteredAmount, _selectedDate);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var thm = Theme.of(context).colorScheme;
    var size = MediaQuery.of(context).size;
    return
        //BASE CONTAINER
        Container(
      height: size.height <= 430 ? size.height * 0.8 : size.height * 0.6,
      padding: size.width > 820
          ? EdgeInsets.symmetric(horizontal: size.width * 0.2, vertical: 10)
          : null,
      child:
          // ADD TRANSACTION FORM CARD
          Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 0.0,
        color: thm.surface,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 30, 15, 5),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              textFieldBuilder(
                  controller: _titleController, theme: thm, labelText: 'Title'),
              SizedBox(
                height: size.height * 0.02,
              ),
              textFieldBuilder(
                  controller: _amountController,
                  theme: thm,
                  labelText: 'Amount'),
              SizedBox(
                height: size.height * 0.02,
              ),
              //CHOOSE CALENDER WIDGET
              FittedBox(
                child: Row(
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        _opencalender(context);
                      },
                      icon: const Icon(Icons.calendar_today_outlined),
                      label: const Text("Choose Date:"),
                    ),
                    InkWell(
                      onTap: () {
                        _opencalender(context);
                      },
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Selected'
                            : DateFormat.yMMMd()
                                .format(_selectedDate!)
                                .toString(),
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              //ADD TRANSACTION BUTTON
              ElevatedButton(
                onPressed: submitData,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0)),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 9.0),
                ),
                child: Text("Add Transaction".toUpperCase()),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
