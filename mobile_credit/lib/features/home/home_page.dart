import 'package:mobile_credit/features/cart/cart_page.dart';
import 'package:mobile_credit/features/common/default_background/default_background.dart';
import 'package:mobile_credit/features/common/default_navigation/default_navigation.dart';
import 'package:mobile_credit/features/common/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:mobile_credit/features/datasource.dart';
import 'package:mobile_credit/features/product/product_page.dart';

class HomePage extends StatelessWidget {
  
  build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DefaultBackground(color: AppColors.defaultBackgroundColor),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultNavigation(
                  title: "Featured",
                  isColorTitle: true,
                  isBackButton: false,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 21),
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: Datasource.products.map((model) {
                        return GestureDetector(
                          child: ProductGridCell(model: model),
                          onTap: () {
                            _navigateToProduct(model: model, context: context);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToCart(context: context);
        },
        child: Icon(Icons.add_shopping_cart),
        backgroundColor: AppColors.primaryTextColor,
      ),
    );
  }

  _navigateToCart({BuildContext context}) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => CartPage()));
  }
  _navigateToProduct({ProductModel model, BuildContext context}) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ProductPage(model: model,)));
  }
}

class ProductGridCell extends StatelessWidget {
  final ProductModel model;
  BuildContext context;

  ProductGridCell({this.model});

  build(BuildContext context) {
    this.context = context;
    return Container(
      // color: Colors.grey,
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
          width: 90,
          height: 90,
          child:Image.asset(model.imageName)),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                      width: 100,
                      child: createText(
                        data: model.title,
                        color: AppColors.secondaryTextColor,
                        isSmall: false),
                      ),   
                      createText(
                        data: "\$${model.price.toString()}",
                        color: AppColors.secondaryTextColor,
                        isSmall: false)]),
                    Row(children:[
                        createText(
                          data: model.subtitle,
                          color: AppColors.subtitleTextColor,
                          isSmall: true),
                        IconButton(icon: new Icon(Icons.add_shopping_cart), onPressed: (){ 
                          _addCart(product:model);
                          _showAlertAddCart();
                        }),
                      ]
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Text createText({String data, bool isSmall, Color color}) {
    var textStyle = TextStyle(
        fontSize: isSmall ? 12 : 17,
        color: color,
        fontWeight: isSmall ? FontWeight.w300 : FontWeight.bold);

    return Text(
      data,
      style: textStyle,
      textAlign: TextAlign.center,
    );
  }

  _addCart({ProductModel product}) {
    bool existe = false;
    for (var i = 0; i < Datasource.cart.length; i++) {
      if(Datasource.cart[i].product.cod == product.cod){
        Datasource.cart[i].qtd++;
        existe = true;
        break;
      }
    }
    if(!existe){
      Datasource.cart.add(ItemCart(product: product, qtd: 1));
    }
    
  }

  Future<void> _showAlertAddCart() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Carrinho'),
          content: Text("O item foi adicionado ao carrinho."),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}

