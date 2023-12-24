import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/side_menu.dart';
import '../widgets/drug_item.dart';
import '../providers/drugs_provider.dart';

class CategoryDrugsScreen extends StatelessWidget {
  static const routeName = '/category-drugs';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primary = Theme.of(context).colorScheme.primary;
    final secondary = Theme.of(context).colorScheme.secondary;
    final drugs = Provider.of<DrugsProvider>(context).drugs;
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: SideMenu(),
          ),
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Category Name',
                        style: TextStyle(
                          fontFamily: 'PollerOne',
                          color: primary,
                          fontSize: width * 0.016,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromRGBO(68, 191, 219, 1)
                                .withOpacity(0.2),
                            hintText: 'Search Drugs',
                            suffixIcon: const Icon(Icons.search),
                            border: InputBorder.none,
                            constraints: BoxConstraints(
                              maxWidth: width * 0.35,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: height * 0.9,
                  child: GridView.builder(
                    itemBuilder: (_, index) => DrugItem(
                      drugs[index].englishTradeName,
                      drugs[index].price,
                      drugs[index].imgUrl,
                    ),
                    itemCount: drugs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: width > 800
                          ? 4
                          : width > 400
                          ? 3
                          : 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
