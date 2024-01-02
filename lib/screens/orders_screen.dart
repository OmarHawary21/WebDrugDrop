import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

import '../models/orders_data.dart';
import '../widgets/side_menu.dart';
import '../providers/orders_provider.dart';

bool allOrders = true;
bool preparing = false;
bool onGoing = false;
bool delivered = false;

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders-screen';

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var media = MediaQuery.of(context);
    return Scaffold(
      body: SlideInLeft(
        duration: const Duration(milliseconds: 1000),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: SideMenu(),
            ),
            Expanded(
              flex: 6,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(media.size.width * 0.02),
                      alignment: AlignmentDirectional.topStart,
                      padding: EdgeInsets.only(top: media.size.height * 0.02),
                      height: media.size.height * 0.1,
                      child: Text(
                        'Orders',
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    StatusButtons(),
                    Divider(),
                    Container(
                      height: media.size.height * 0.75,
                      padding: EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: DataTableWidget(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatusButtons extends StatefulWidget {
  const StatusButtons({
    super.key,
  });

  @override
  State<StatusButtons> createState() => _StatusButtonsState();
}

class _StatusButtonsState extends State<StatusButtons> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    var media = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: allOrders ? theme.background : theme.primary,
          ),
          onPressed: () {
            setState(() {
              allOrders = true;
              preparing = false;
              onGoing = false;
              delivered = false;
            });
          },
          child: Text(
            'All orders',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextButton(
            style: TextButton.styleFrom(
              foregroundColor: preparing ? theme.background : theme.primary,
            ),
            onPressed: () {
              setState(() {
                preparing = true;
                allOrders = false;
                onGoing = false;
                delivered = false;
              });
            },
            child: Text(
              'Preparing',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            )),
        TextButton(
            style: TextButton.styleFrom(
              foregroundColor: onGoing ? theme.background : theme.primary,
            ),
            onPressed: () {
              setState(() {
                onGoing = true;
                allOrders = false;
                preparing = false;
                delivered = false;
              });
            },
            child: Text(
              'On going',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            )),
        TextButton(
            style: TextButton.styleFrom(
              foregroundColor: delivered ? theme.background : theme.primary,
            ),
            onPressed: () {
              setState(() {
                delivered = true;
                allOrders = false;
                preparing = false;
                onGoing = false;
              });
              //print('$delivered++++++++++++++++++++++');
            },
            child: Text(
              'Delivered',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            )),
      ],
    );
  }
}

List<String> status = <String>[
  'Preparing',
  'On Going',
  'Delivered',
];
List<Color> colors = [
  Colors.yellow,
  Colors.blue,
  Colors.green,
];

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = status.first;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;

    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      //elevation: 16,
      borderRadius: BorderRadius.circular(15),
      style: TextStyle(color: theme.primary),
      underline: Container(
        height: 2,
        color: theme.secondary,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
        Provider.of<Order>(context).sendOrderStatus(value!);
      },
      items: status.asMap().entries.map((entry) {
        int index = entry.key;
        String option = entry.value;
        Color color = colors[index];
        return DropdownMenuItem<String>(
          value: option,
          child: Text(
            option,
            style: TextStyle(color: color),
          ),
        );
      }).toList(),
    );
  }
}

class DataTableWidget extends StatefulWidget {
  const DataTableWidget({
    super.key,
  });

  @override
  State<DataTableWidget> createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    var media = MediaQuery.of(context);
    final orderData = Provider.of<OrdersProvider>(context);
    final orders = preparing
        ? orderData.preparingOrders
        : onGoing
            ? orderData.onGoingOrders
            : delivered
                ? orderData.deliveredOrders
                : orderData.allOrders;

    return DataTable(
      dataRowHeight: media.size.height * 0.1,
      headingTextStyle: TextStyle(
        color: theme.primary,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      dataTextStyle: TextStyle(
        color: theme.primary.withOpacity(0.8),
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: theme.secondary.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      columns: <DataColumn>[
        DataColumn(
          label: Text('#'),
          numeric: true,
          tooltip: 'number of order',
        ),
        DataColumn(label: Text('Name'), tooltip: 'Name of pharmacist'),
        DataColumn(
            label: Text('Number'),
            //numeric: true,
            tooltip: 'Phone number of pharmacist'),
        DataColumn(
          label: Text('Location'),
          tooltip: 'Location of pharmacy',
        ),
        DataColumn(label: Text('Date'), tooltip: 'Date of order'),
        DataColumn(
          label: Text('Price'),
          numeric: true,
          tooltip: 'Total price of order',
        ),
        DataColumn(
          label: Text('Payment'),
        ),
        DataColumn(
          label: Text('status'),
          tooltip: 'Status of order',
        ),
      ],
      rows: List<DataRow>.generate(
        orders.length,
        (i) {
          return DataRow(
            cells: <DataCell>[
              DataCell(Text(orders[i].id)),
              DataCell(Text(orders[i].name)),
              DataCell(Text(orders[i].phoneNumber)),
              DataCell(Text(orders[i].location)),
              DataCell(Text(orders[i].date.toString())),
              DataCell(Text(orders[i].price)),
              DataCell(TextButton(
                child: orders[i].isPaid
                    ? Text(
                        'Paid',
                        style:
                            TextStyle(color: Color.fromARGB(255, 7, 196, 14)),
                      )
                    : Text(
                        'not paid',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 245, 20, 4)),
                      ),
                onPressed: () {
                  setState(() {
                    orders[i].isPaid = true;
                  });
                  //use it to get data from backend
                  //   try {
                  //     await Provider.of<Order>(context, listen: false)
                  //         .togglePayStatus();
                  //   } catch (error) {
                  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //       content: Text(
                  //         'Could not set pay status!',
                  //         textAlign: TextAlign.center,
                  //       ),
                  //     ));
                  //   }
                },
              )),
              DataCell(DropdownButtonExample()),
            ],
          );
        },
      ),
    );
  }
}
