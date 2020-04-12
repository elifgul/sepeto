import 'package:flutter/material.dart';
import 'package:sepeto/colors.dart';
import 'package:sepeto/search_widget.dart';

import 'model/product.dart';
import 'model/products_repository.dart';
import 'no_item_found.dart';

class HomePage extends StatefulWidget {
  final Category category;

  const HomePage({this.category: Category.ALL});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GestureDetector> _buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(widget.category);

    if (products == null || products.isEmpty) {
      return const <GestureDetector>[];
    }
    final ThemeData theme = Theme.of(context);
    return products.map((product) {
      return GestureDetector(
          onTap: () {print(product.name);},
          child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 10 / 8,
                    child: Image.asset(
                      product.assetPackage + '/' + product.assetName,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            product == null ? '' : product.name,
                            style: theme.textTheme.button,
                            softWrap: false,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    bool show = true;
    Set<Product> _selectedItems = {};
    List<Product> products = ProductsRepository.loadProducts(widget.category);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(children: [
          SingleChildScrollView(
            child: Column(children: <Widget>[
              if (show == true)
                SearchWidget<Product>(
                  dataList: products,
                  hideSearchBoxWhenItemSelected: false,
                  listContainerHeight: MediaQuery.of(context).size.height / 4,
                  queryBuilder: (query, list) {
                    return list
                        .where((item) => item.name
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                        .toList();
                  },
                  popupListItemBuilder: (item) {
                    return PopupListItemWidget(item);
                  },
                  selectedItemBuilder: (selectedItem, deleteSelectedItem) {
                    return SelectedItemWidget(selectedItem, deleteSelectedItem);
                  },
                  // widget customization
                  noItemsFoundWidget: NoItemFound(),
                  textFieldBuilder: (controller, focusNode) {
                    return MyTextField(controller, focusNode);
                  },
                  onItemSelected: (item) {
                    setState(() {
                      _selectedItems.add(item);
                    });
                  },
                ),
            ]),
          ),
          Expanded(
            child: Center(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                padding: EdgeInsets.all(16.0),
                children: _buildGridCards(context),
              ),
            ),
          )
        ]));
  }
}

class SelectedItemWidget extends StatelessWidget {
  const SelectedItemWidget(this.selectedItem, this.deleteSelectedItem);

  final Product selectedItem;
  final VoidCallback deleteSelectedItem;

  @override
  Widget build(BuildContext context) {
    if (selectedItem == null)
      return SizedBox(
        height: 0,
      );
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 4,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: 8,
              ),
              child: Text(
                selectedItem.name,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete_outline, size: 22),
            color: orange900,
            onPressed: deleteSelectedItem,
          ),
        ],
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField(this.controller, this.focusNode);

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: orange100,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          suffixIcon: Icon(Icons.search),
          border: InputBorder.none,
          hintText: "Ne satın almak istersiniz?",
          contentPadding: const EdgeInsets.only(
            left: 16,
            right: 20,
            top: 14,
            bottom: 14,
          ),
        ),
      ),
    );
  }
}

class PopupListItemWidget extends StatelessWidget {
  const PopupListItemWidget(this.item);

  final Product item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Text(
        item.name,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
