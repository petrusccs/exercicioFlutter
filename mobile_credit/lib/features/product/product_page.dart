import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_credit/features/cart/cart_page.dart';
import 'package:mobile_credit/features/common/default_navigation/default_navigation.dart';
import 'package:mobile_credit/features/common/utils/app_colors.dart';
import 'package:mobile_credit/features/datasource.dart';

class ProductPage extends StatelessWidget {

  final ProductModel model;
  
  ProductPage({this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultNavigation(
                  title: "Detail",
                  isColorTitle: false,
                  isBackButton: true,
                ),
                _detailProductWidget(context: context),
              ]
          ),
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

  _detailProductWidget({BuildContext context}) {
    var buttonWidth = MediaQuery.of(context).size.width - 40;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 180,
              height: 180,
          child:Image.asset(model.imageName)),
          SizedBox(
              height: 16,
            ),
            Text(model.title,
                style: TextStyle(
                    fontSize: 26,
                    color: AppColors.primaryTextColor,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 16,
            ),
            _createText(
                data: "${model.price}",
                size: ItemCartTextSize.medium),
            _createText(
                data: "${model.subtitle}",
                size: ItemCartTextSize.small),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: buttonWidth,
                  child: CupertinoButton(
                    onPressed: () {
                       _addCart();
                       _showAddCartDialog(context);
                    },
                    child: createButtonText(
                        data: "Adicionar", color: Colors.white),
                    color: AppColors.primaryTextColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 65,
            ),
          ],
        ),
      ),
    );
  }

  _navigateToCart({BuildContext context}) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => CartPage()));
  }

  Text createButtonText({String data, Color color}) {
    var textStyle =
        TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: color);
    return Text(data, style: textStyle);
  }
  
  _addCart() {
    bool existe = false;
    for (var i = 0; i < Datasource.cart.length; i++) {
      if(Datasource.cart[i].product.cod == model.cod){
        Datasource.cart[i].qtd++;
        existe = true;
        break;
      }
    }
    if(!existe){
      Datasource.cart.add(ItemCart(product: model, qtd: 1));
    }
  }

  _createText({String data, ItemCartTextSize size}) {
    TextStyle style;

    switch (size) {
      case ItemCartTextSize.medium:
        style = TextStyle(
            fontSize: 24,
            color: AppColors.secondaryTextColor,
            fontWeight: FontWeight.w500);
        break;
      case ItemCartTextSize.large:
        style = TextStyle(
            fontSize: 32,
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.bold);
        break;
      default:
        break;
    }

    return Text(data, style: style);
  }

  Future<void> _showAddCartDialog(BuildContext context) async {
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
