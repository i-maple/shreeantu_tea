import 'package:flutter/material.dart';
import 'package:shreeantu_tea/data/usecases/data_local.dart';
import 'package:velocity_x/velocity_x.dart';

class LedgerWidget extends StatelessWidget {
  const LedgerWidget({
    super.key,
    required this.future,
    required this.headers,
  });

  final Future future;
  final List<String> headers;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DataLocal.instance.getAllPurchases(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var datas = snapshot.data;
              List<List<String>> lists = [];
              for (Map<dynamic, dynamic> data in datas!) {
                lists.add(
                  [
                    ...data.values.map((e) => e.toString()),
                    (data['quantity'] * data['amount']).toString(),
                  ],
                );
              }
              return DataTable(
                columns: headers
                    .map(
                      (e) => DataColumn(
                        label: Text(e.toUpperCase()),
                        tooltip: e,
                      ),
                    )
                    .toList(),
                rows: lists
                    .map((e) => DataRow(
                          cells: e
                              .map(
                                (e) => DataCell(
                                  Text(e.toString()),
                                ),
                              )
                              .toList(),
                        ))
                    .toList(),
              ).scrollHorizontal().scrollVertical().p20();
            } else {
              return 'No Datas Yet'.text.make();
            }
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
