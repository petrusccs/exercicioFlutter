import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_credit/features/common/default_background/default_background.dart';
import 'package:mobile_credit/features/common/default_navigation/default_navigation.dart';
import 'package:mobile_credit/features/common/utils/app_colors.dart';
import 'package:mobile_credit/features/datasource.dart';

class CartPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var buttonWidth = MediaQuery.of(context).size.width - 16;
    return Scaffold(
        body: Stack(
      children: [
        DefaultBackground(color: AppColors.defaultBackgroundColor),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultNavigation(
                title: "Cart",
                isColorTitle: false,
                isBackButton: true
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ListView.builder(
                      itemCount: Datasource.cart.length,
                      itemBuilder: (context, index) {
                        return ItemCartCell(model: Datasource.cart[index]);
                      }),
                ),
              ),
              Container(
                    padding: const EdgeInsets.all(16),
                    width: buttonWidth,
                    child: CupertinoButton(
                      onPressed: () {

                      },
                      child: createButtonText(
                          data: "Checkout", color: Colors.white),
                      color: AppColors.primaryTextColor,
                    ),
                  ),
            ],
          ),
        )
      ],
    ));
  }

  Text createButtonText({String data, Color color}) {
    var textStyle =
        TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: color);
    return Text(data, style: textStyle);
  }
}

enum ItemCartTextSize { small, medium, large }

class ItemCartCell extends StatefulWidget {
  final ItemCart model;

  ItemCartCell({@required this.model});

  @override
  _ItemCartCellState createState() => _ItemCartCellState();
}

class _ItemCartCellState extends State<ItemCartCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _createText(data: widget.model.product.title, size: ItemCartTextSize.medium),
              SizedBox(
                height: 12,
              ),
              _createText(data: widget.model.product.subtitle, size: ItemCartTextSize.small),
              Row(
                children: [
                  _createText(
                      data: "\$${widget.model.product.price}", size: ItemCartTextSize.medium),
                  SizedBox(
                    width: 2,
                  ),
                  _createText(
                      data: widget.model.product.inStock ? "In Stock" : "Out of stock",
                      size: ItemCartTextSize.medium),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(icon: new Icon(Icons.add), onPressed: _increment,),
                  SizedBox(
                    width: 8,
                  ),
                  _createText(
                      data: "${widget.model.qtd}", size: ItemCartTextSize.medium),
                  SizedBox(
                    width: 8,
                  ),
                  IconButton(icon: new Icon(Icons.remove), onPressed: _decrement,),
                ],
              )
            ],
          ),
          SizedBox(width: 20),
          Container(
              height: 110,
              width: 110 * 1.3828125,
              child: Image.asset(widget.model.product.imageName)),
        ],
      ),
    );
  }

  _navigateToPayment({BuildContext context}) {
    //Navigator.of(context).push(
    //    MaterialPageRoute(builder: (context) => PaymentPage()));
  }

  _increment() {
    setState(() {
      widget.model.qtd++;
    });
  }

  _decrement() {
    setState(() {
      if(widget.model.qtd > 1){
         widget.model.qtd--;
      }
    });
  }

  _createText({String data, ItemCartTextSize size}) {
    TextStyle style;

    switch (size) {
      case ItemCartTextSize.small:
        style = TextStyle(fontSize: 13, color: AppColors.subtitleTextColor);
        break;
      case ItemCartTextSize.medium:
        style = TextStyle(
            fontSize: 14,
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.w500);
        break;
      case ItemCartTextSize.large:
        style = TextStyle(
            fontSize: 16,
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.bold);
        break;
    }

    return Text(data, style: style);
  }
}
