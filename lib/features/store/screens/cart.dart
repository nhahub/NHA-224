import 'package:depi_final_project/features/store/widgets/app_bar_icon.dart';
import 'package:depi_final_project/features/store/widgets/cart_item.dart';
import 'package:depi_final_project/features/store/widgets/coupon_card.dart';
import 'package:depi_final_project/features/store/widgets/price_detail.dart';
import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
   Cart({super.key});

  final List<CartItem> cartItems = [
    CartItem(
      title: "Men's Harrington Jacket",
      price: 148,
      size: "- M",
      color: "- Lemon", 
      image: 'assets/images/image1.png',
    )
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10),
          child: AppBarIcon(
            icon: "assets/icons/arrowleft.png",
            onTap: (){},
          ),
        ),
      ),
      body: cartItems.isEmpty? 
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/bag.png"),
            SizedBox(height: 20,),
            Text("Your cart is empty", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: (){},
             style: ElevatedButton.styleFrom(
              backgroundColor: theme.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24)
             ),
             child: Text("Explore category", style: TextStyle(fontSize: 16),),
             )
          ],
        ),
      )
      :
      Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.topRight,
              child: Text("Remove all", 
              style: TextStyle(fontSize: 16,
              fontWeight: FontWeight.w600),),
            ),
            SizedBox(height: 10,),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, i){
                  return cartItems[i];
                },
                
              ),
            ),
        
            Column(
              children: [
                PriceDetail(
                  title: "Subtotal",
                  price: 200,
                ),
                PriceDetail(
                  title: "shipping cost",
                  price: 8,
                ),
                PriceDetail(
                  title: "Tax",
                  price: 0,
                ),
                PriceDetail(
                  title: "Total",
                  price: 208,
                  isPriceBolded: true,
                ),

                CouponCard(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                  onPressed: (){}, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primary,
                    foregroundColor: theme.secondary,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16)
                  ),
                  child: Text("Checkout", style: TextStyle(fontSize: 16),)),
                )
              ],
            ),
          ],
        ),
      ),

      
    );
  }
}