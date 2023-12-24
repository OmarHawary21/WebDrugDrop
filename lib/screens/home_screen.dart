import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';

import 'category_drugs_screen.dart';
import '../widgets/side_menu.dart';
import '../widgets/drug_item.dart';
import '../providers/drugs_provider.dart';
import '../providers/categories_provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _form = GlobalKey<FormState>();

  late String searchInput;

  @override
  void didChangeDependencies() {
    Provider.of<DrugsProvider>(context).fetchDrugsEnglish();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final primary = Theme.of(context).colorScheme.primary;
    final secondary = Theme.of(context).colorScheme.secondary;
    final drugs = Provider.of<DrugsProvider>(context).drugs;
    final categories = Provider.of<CategoriesProvider>(context).categories;
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
                          'Categories',
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
                  SizedBox(
                    height: height * 0.2,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context)
                              .pushNamed(CategoryDrugsScreen.routeName),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: secondary,
                            child: Text(categories[index]['name']!),
                          ),
                        ),
                      ),
                      itemCount: categories.length,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Best Sellers',
                      style: TextStyle(
                        fontFamily: 'PollerOne',
                        color: primary,
                        fontSize: width * 0.016,
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: height * 0.65,
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
      ),
    );
  }
}
