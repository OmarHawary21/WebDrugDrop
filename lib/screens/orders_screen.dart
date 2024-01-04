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

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders-screen';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<OrdersProvider>(context, listen: false)
          .fetchOrders()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();

    super.didChangeDependencies();
  }

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
              child:
                  // _isLoading
                  //     ? Center(
                  //         child: CircularProgressIndicator(),
                  //       )
                  //     :
                  SingleChildScrollView(
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
                    Divider(color: Colors.grey),
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
  'pending',
  'on going',
  'done',
];

List<Color> colors = [
  Colors.purple,
  Colors.blue,
  Colors.green,
];

class DropdownButtonExample extends StatefulWidget {
  String dropdownValue;
  int id;
  DropdownButtonExample(this.dropdownValue, this.id);
  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  late String selectedOption;
  @override
  void initState() {
    // TODO: implement initState
    selectedOption = widget.dropdownValue ?? 'Pending';
    super.initState();
  }

  void _showDialog(BuildContext context, String content, String value, int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Center(
          child: Text(
            'Attention',
            style: TextStyle(color: Theme.of(context).colorScheme.background),
          ),
        ),
        content: Text(content),
        actions: [
          ElevatedButton(
            onPressed: () async {
              setState(() {
                selectedOption = value;
                Navigator.pop(context);
              });
              try {
                await Provider.of<OrdersProvider>(context, listen: false)
                    .updateOrderStatus(id, value);
              } catch (error) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    'Could not change order status! Try again',
                    textAlign: TextAlign.center,
                  ),
                ));
              }
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('NO'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('${widget.dropdownValue}');
    print(selectedOption);

    var theme = Theme.of(context).colorScheme;

    return DropdownButton<String>(
      value: widget.dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      //elevation: 16,
      borderRadius: BorderRadius.circular(15),
      style: TextStyle(color: theme.primary),
      underline: Container(
        height: 2,
        color: theme.secondary,
      ),
      onChanged: (value) {
        // This is called when the user selects an item.
        _showDialog(context, 'Are you sure to change the state of order?',
            value.toString(), widget.id);
      },
      dropdownColor: Theme.of(context).scaffoldBackgroundColor,
      items: status.asMap().entries.map((entry) {
        int index = entry.key;
        String option = entry.value;
        Color color = colors[index];
        return DropdownMenuItem<String>(
          value: option,
          child: Text(
            option,
            style: TextStyle(
              color: color,
            ),
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
  //show dialog for quantity
  void _showDialog(BuildContext context, String content, bool payment, int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Center(
          child: Text(
            'Attention',
            style: TextStyle(color: Theme.of(context).colorScheme.background),
          ),
        ),
        content: Text(content),
        actions: [
          ElevatedButton(
            onPressed: () async {
              setState(() {
                payment = true;
              });
              //use it to get data from backend
              try {
                await Provider.of<OrdersProvider>(context, listen: false)
                    .updateOrderPayment(id, payment);
              } catch (error) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    error.toString(),
                    textAlign: TextAlign.center,
                  ),
                ));
              }
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('NO'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    var media = MediaQuery.of(context);
    final orderData = Provider.of<OrdersProvider>(context);
    final allOrders = orderData.allOrders;
    final preparingOrders = orderData.preparingOrders;
    final onGoingOrders = orderData.onGoingOrders;
    final deliveredOrders = orderData.deliveredOrders;
    print('$allOrders');

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
      rows: onGoing
          ? List<DataRow>.generate(
              onGoingOrders.length,
              (i) {
                return DataRow(
                  cells: <DataCell>[
                    DataCell(Text((onGoingOrders[i].id).toString())),
                    DataCell(Text(onGoingOrders[i].name)),
                    DataCell(Text(onGoingOrders[i].phoneNumber)),
                    DataCell(Text(onGoingOrders[i].location)),
                    DataCell(Text(onGoingOrders[i].date)),
                    DataCell(Text(onGoingOrders[i].price.toString())),
                    DataCell(TextButton(
                      child: onGoingOrders[i].isPaid
                          ? Text(
                              'Paid',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 7, 196, 14)),
                            )
                          : Text(
                              'not paid',
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 245, 20, 4)),
                            ),
                      onPressed: () {
                        if (!onGoingOrders[i].isPaid) {
                          _showDialog(
                            context,
                            'Are you sure you want to change it to paid',
                            onGoingOrders[i].isPaid,
                            onGoingOrders[i].id,
                          );
                        }
                      },
                    )),

                    // DataCell(Text(orders[i].state)),

                    DataCell(DropdownButtonExample(
                        onGoingOrders[i].state, onGoingOrders[i].id)),
                  ],
                );
              },
            )
          : preparing
              ? List<DataRow>.generate(
                  preparingOrders.length,
                  (i) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(Text((preparingOrders[i].id).toString())),
                        DataCell(Text(preparingOrders[i].name)),
                        DataCell(Text(preparingOrders[i].phoneNumber)),
                        DataCell(Text(preparingOrders[i].location)),
                        DataCell(Text(preparingOrders[i].date)),
                        DataCell(Text(preparingOrders[i].price.toString())),
                        DataCell(TextButton(
                          child: preparingOrders[i].isPaid
                              ? Text(
                                  'Paid',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 7, 196, 14)),
                                )
                              : Text(
                                  'not paid',
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 245, 20, 4)),
                                ),
                          onPressed: () {
                            if (!preparingOrders[i].isPaid) {
                              _showDialog(
                                context,
                                'Are you sure you want to change it to paid',
                                preparingOrders[i].isPaid,
                                preparingOrders[i].id,
                              );
                            }
                          },
                        )),

                        // DataCell(Text(orders[i].state)),

                        DataCell(DropdownButtonExample(
                            allOrders[i].state, allOrders[i].id)),
                      ],
                    );
                  },
                )
              : List<DataRow>.generate(
                  allOrders.length,
                  (i) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(Text((allOrders[i].id).toString())),
                        DataCell(Text(allOrders[i].name)),
                        DataCell(Text(allOrders[i].phoneNumber)),
                        DataCell(Text(allOrders[i].location)),
                        DataCell(Text(allOrders[i].date)),
                        DataCell(Text(allOrders[i].price.toString())),
                        DataCell(TextButton(
                          child: allOrders[i].isPaid
                              ? Text(
                                  'Paid',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 7, 196, 14)),
                                )
                              : Text(
                                  'not paid',
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 245, 20, 4)),
                                ),
                          onPressed: () {
                            if (!allOrders[i].isPaid) {
                              _showDialog(
                                  context,
                                  'Are you sure you want to change it to paid',
                                  allOrders[i].isPaid,
                                  allOrders[i].id);
                            }
                          },
                        )),

                        // DataCell(Text(orders[i].state)),

                        DataCell(DropdownButtonExample(
                            allOrders[i].state, allOrders[i].id)),
                      ],
                    );
                  },
                ),
    );
    //print(orders[0].state);
  }
}
