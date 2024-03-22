import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shreeantu_tea/data/usecases/data_local.dart';
import 'package:shreeantu_tea/model/farmers_model.dart';
import 'package:shreeantu_tea/utils/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class FarmersList extends StatelessWidget {
  const FarmersList({super.key});

  openFarmerPopup(BuildContext context, Farmer farmer) async {
    final List<Map> map =
        await DataLocal.instance.getIndividualFarmerDetail(farmer);
    final List payments = await DataLocal.instance.getPaymentsToFarmer(farmer);
    double pay = 0;
    for (var element in payments) {
      pay += element['amount'];
    }
    double total = 0;
    for (var element in map) {
      total += element['total'];
    }
    if (context.mounted) {
      await showDialog(
          context: context,
          builder: (context) {
            return Dialog.fullscreen(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        label: 'Go Back'.text.make(),
                      ).px8(),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const FaIcon(FontAwesomeIcons.fileExcel),
                        label: 'Export'.text.make(),
                      ),
                    ],
                  ).pOnly(top: 8, bottom: 32),
                  farmer.name.text.size(20).bold.make().py16().centered(),
                  ('Phone: ${farmer.phone ?? ''}')
                      .text
                      .semiBold
                      .size(16)
                      .make()
                      .pOnly(bottom: 32)
                      .centered(),
                  Table(
                    border: TableBorder.all(
                      color: AppColors.primaryContainer,
                      width: 2,
                    ),
                    children: [
                      TableRow(
                        children: [
                          'Date'.text.size(18).center.bold.make().p8(),
                          'Quantity'.text.center.size(18).bold.make().p8(),
                          'Amount'.text.bold.center.size(18).make().p8(),
                          'Quality Grade'.text.bold.size(18).center.make().p8(),
                          'Total'.text.bold.size(18).center.make().p8(),
                        ],
                      ),
                      ...map.map(
                        (e) => TableRow(
                          children: e.values
                              .map(
                                (e) => e
                                    .toString()
                                    .text
                                    .center
                                    .size(16)
                                    .make()
                                    .p8(),
                              )
                              .toList(),
                        ),
                      ),
                      TableRow(
                        children: [
                          ''.text.size(16).center.bold.make().p8(),
                          ''.text.center.size(16).bold.make().p8(),
                          ''.text.bold.center.size(16).make().p8(),
                          ''.text.bold.size(16).center.make().p8(),
                          'Paid: $pay'.text.bold.size(16).center.make().p8(),
                        ],
                      ),
                      TableRow(
                        children: [
                          ''.text.size(16).center.bold.make().p8(),
                          ''.text.center.size(16).bold.make().p8(),
                          ''.text.bold.center.size(16).make().p8(),
                          ''.text.bold.size(16).center.make().p8(),
                          'Remaining: ${total - pay}'
                              .text
                              .bold
                              .size(16)
                              .center
                              .make()
                              .p8(),
                        ],
                      ),
                      TableRow(
                        children: [
                          ''.text.size(16).center.bold.make().p8(),
                          ''.text.center.size(16).bold.make().p8(),
                          ''.text.bold.center.size(16).make().p8(),
                          ''.text.bold.size(16).center.make().p8(),
                          'Total: $total'.text.bold.size(16).center.make().p8(),
                        ],
                      ),
                    ],
                  ).scrollVertical(),
                ],
              ).p20(),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        'Click on the farmer whose detail you want to see'
            .text
            .bold
            .size(20)
            .make()
            .py20(),
        FutureBuilder(
            future: DataLocal.instance.getAllFarmers(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  var data = snapshot.data;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          onTap: () async => await openFarmerPopup(
                            context,
                            data[index]!,
                          ),
                          leading: (index + 1).text.bold.size(16).make(),
                          title: data[index]!.name.text.bold.size(16).make(),
                          subtitle: data[index]!
                              .uid
                              .toString()
                              .text
                              .bold
                              .size(16)
                              .make(),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded),
                        ),
                      );
                    },
                  );
                }
              }
              return const CircularProgressIndicator().centered();
            })).p24(),
      ],
    );
  }
}
