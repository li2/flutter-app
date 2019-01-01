import 'package:flutter/material.dart';
import 'package:flutter_app/codelabs/04_mdc_for_flutter/supplemental/asymmetric_view.dart';
import 'package:intl/intl.dart';

import 'model/products_repository.dart';
import 'model/product.dart';

enum ProductLayout { Grid, Asymmetric }

class HomePage extends StatefulWidget {
  final Category category;

  const HomePage({this.category: Category.all});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool _isGridLayout = true;

  @override
  Widget build(BuildContext context) {
    return _buildProductsWidget();
  }

  Widget _buildProductsWidget() {
    if (_isGridLayout) {
      return _buildGridLayout();
    } else {
      return _buildAsymmetricLayout();
    }
  }

  Widget _buildAsymmetricLayout() {
    return AsymmetricView(products: ProductsRepository.loadProducts(widget.category));
  }

  Widget _buildGridLayout() {
    return GridView.count(
      // Cross axis in Flutter means the non-scrolling axis.
      // The scrolling direction is called the main axis.
      // So, if you have vertical scrolling, like GridView does by default, then the cross axis is horizontal.
      crossAxisCount: 2,
      padding: EdgeInsets.all(16),
      childAspectRatio: 8.0/9.0,
      children: _buildGridCards(context),
    );
  }

  List<Card> _buildGridCards(BuildContext context) {
    // todo weiyi Rx?
    List<Product> products = ProductsRepository.loadProducts(widget.category);

    if (products == null || products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).toString());

    return products.map((product) { // todo weiyi create all cards at same time? lazy?
      return Card(
        clipBehavior: Clip.antiAlias,
        // TODO: Adjust card heights (103)
        elevation: 0.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 11,
              // todo weiyi here display image from a package, which i think should be a hardcoding image lib. Picasso?
              child: Image.asset(
                product.assetName,
                package: product.assetPackage,
                // Adjust the box size to zoom and remove the extra whitespace around image.
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  // Align labels to the bottom and center
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Handle overflowing labels
                    Text(
                      product == null ? '' : product.name,
                      style: theme.textTheme.button,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      product == null ? '' : formatter.format(product.price),
                      style: theme.textTheme.caption,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
