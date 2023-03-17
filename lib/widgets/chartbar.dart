import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  const ChartBar(
      {super.key,
      required this.label,
      required this.spendingAmount,
      required this.spendingPctOfTotal});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(builder: (ctx, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //CHARTBAR
            SizedBox(
              height: constraints.maxHeight * 0.85,
              width: constraints.maxWidth * 0.7,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  //BASE CONTAINER OF CHARTBAR
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ),
                  //TOP CONTAINER WHICH CHANGES HEIGHT ACCORDING TO spending percentage of total
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 3.5, horizontal: 3.5),
                    child: FractionallySizedBox(
                      heightFactor: spendingPctOfTotal,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: const Color.fromARGB(255, 94, 181, 251),
                        ),
                      ),
                    ),
                  ),
                  //SHOW AMOUNT SPENT ON EACH DAY VERTICALLY
                  Center(
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: FittedBox(
                          child: Text(
                        '₹${spendingAmount.toStringAsFixed(0)}',
                        textScaleFactor: 0.85,
                      )),
                    ),
                  ),
                ],
              ),
            ),
            //CHARTBAR DAYS TEXT
            Text(
              label,
              textScaleFactor: 0.80,
            )
          ],
        );
      }),
    );
  }
}
