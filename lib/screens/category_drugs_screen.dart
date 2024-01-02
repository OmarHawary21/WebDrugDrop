import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/side_menu.dart';
import '../widgets/drug_item.dart';
import '../providers/categories_provider.dart';

class CategoryDrugsScreen extends StatefulWidget {
  static const routeName = '/category-drugs';

  @override
  State<CategoryDrugsScreen> createState() => _CategoryDrugsScreenState();
}

class _CategoryDrugsScreenState extends State<CategoryDrugsScreen> {
  late final int id = ModalRoute.of(context)!.settings.arguments as int;
  bool _isInit = false;
  bool _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (!_isInit) {
      setState(() => _isLoading = true);
      await Provider.of<CategoriesProvider>(context).getCategoryDrugs(id);
      setState(() => _isLoading = false);
    }
    _isInit = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primary = Theme.of(context).colorScheme.primary;
    final secondary = Theme.of(context).colorScheme.secondary;
    final category = Provider.of<CategoriesProvider>(context).findById(id);
    final drugs = Provider.of<CategoriesProvider>(context).categoryDrugs;
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
                      Padding(
                        padding: EdgeInsets.only(left: width * 0.025),
                        child: Text(
                          category.englishName,
                          style: TextStyle(
                            fontFamily: 'PollerOne',
                            color: primary,
                            fontSize: width * 0.016,
                          ),
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
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : drugs.isEmpty
                          ? Center(
                              child: Text('No drugs in this category.', style: TextStyle(
                                color: primary,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),),
                            )
                          : GridView.builder(
                              itemBuilder: (_, index) => DrugItem(
                                drugs[index].id,
                                drugs[index].englishTradeName,
                                drugs[index].price,
                                drugs[index].imgUrl,
                              ),
                              itemCount: drugs.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
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
