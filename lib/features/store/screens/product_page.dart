import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/data/models/product_model.dart';
import 'package:depi_final_project/features/store/widgets/counter_btn.dart';
import 'package:depi_final_project/features/store/widgets/review_card.dart';
import 'package:depi_final_project/features/store/widgets/app_bar_icon.dart';
import 'package:depi_final_project/features/store/widgets/product_option.dart';
import 'package:depi_final_project/features/store/widgets/customize_option.dart';
import 'package:depi_final_project/features/store/widgets/custom_bottom_sheet.dart';


class ProductPage extends StatelessWidget {
  const ProductPage({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final themeBrightness = Theme.of(context).brightness;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10),
          child: AppBarIcon(
            icon:themeBrightness == Brightness.light? "assets/icons/arrowleft.png":"assets/icons/arrowleft_dark.png",
            onTap: (){},
          ),
        ),

        actions: [
          Padding(
          padding: const EdgeInsets.only(top: 10, right: 10),
          child: AppBarIcon(
            icon: themeBrightness == Brightness.light? "assets/icons/heart.png":"assets/icons/heart_dark.png",
            onTap: (){},
          ),
        ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: product.imageUrl.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: product.imageUrl.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Image.network(product.imageUrl[index], fit: BoxFit.cover),
                        );
                      },
                    )
                  : const Center(child: Text('No images available')),
              ),
          
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(product.name, style: GoogleFonts.gabarito(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),),
              ),
              SizedBox(height: 10,),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '\$${product.price.toStringAsFixed(2)}',
                      style: GoogleFonts.gabarito(textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.figmaPrimary
                      )),
                    ),
                    if (product.oldPrice != null) ...[
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: '\$${product.oldPrice!.toStringAsFixed(2)}',
                        style: GoogleFonts.gabarito(textStyle: TextStyle(
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        )),
                      ),
                    ],
                  ],
                ),
              ),
          
              ProductOption(
                onTap: (){
                  showModalBottomSheet(
                    context: context, 
                    builder: (context){
                      return CustomBottomSheet(
                        title: "Size",
                        options: [
                          CustomizeOption(
                            label: "S",
                            isSelected: true),
                          CustomizeOption(
                            label: "M",
                            isSelected: false),
                          CustomizeOption(
                            label: "L",
                            isSelected: false),
                          CustomizeOption(
                            label: "XL",
                            isSelected: false),
                          CustomizeOption(
                            label: "2XL",
                            isSelected: false),
                          CustomizeOption(
                            label: "3XL",
                            isSelected: false),
                        ],
                      );
                    });
                },
                label: "Size",
                options: [
                  Text("S", style: GoogleFonts.gabarito(textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  )),),
                  SizedBox(width: 30,),
                  Image.asset(themeBrightness == Brightness.light? "assets/icons/arrowdown.png":"assets/icons/arrowdown_dark.png")
                ],
              ),
              ProductOption(
                onTap: (){
                  showModalBottomSheet(context: context, 
                  builder: (context){
                    return CustomBottomSheet(title: "Color", 
                    options: [
                      CustomizeOption(
                        label: "light green", 
                        isSelected: true,
                        selection: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Color(0xffb4b690),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 2, color: Colors.white)
                          ),
                        ),
                        ),
                      CustomizeOption(
                        label: "Orange", 
                        isSelected: false,
                        selection: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppColors.orange,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 2, color: Colors.white)
                          ),
                        ),
                        ),
                      CustomizeOption(
                        label: "black", 
                        isSelected: false,
                        selection: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppColors.black,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 2, color: Colors.white)
                          ),
                        ),
                        ),
                      CustomizeOption(
                        label: "blue", 
                        isSelected: false,
                        selection: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 2, color: Colors.white)
                          ),
                        ),
                        ),
                      CustomizeOption(
                        label: "Red", 
                        isSelected: false,
                        selection: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 2, color: Colors.white)
                          ),
                        ),
                        ),
                      CustomizeOption(
                        label: "Yellow", 
                        isSelected: false,
                        selection: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 2, color: Colors.white)
                          ),
                        ),
                        ),
                    ]);
                  });
                },
                label: "Color",
                options: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xffb4b690)
                    ),
                  ),
                  SizedBox(width: 30,),
                  Image.asset(themeBrightness == Brightness.light? "assets/icons/arrowdown.png":"assets/icons/arrowdown_dark.png")
                ],
              ),
              ProductOption(
                label: "Quantity",
                options: [
                 CounterBtn(
                  onTap: (){},
                  icon: "+"),
                  SizedBox(width: 20,),

                  //TODO: replace with dynamic value
                  Text("1", style: TextStyle(fontSize: 16),),
                  SizedBox(width: 20,),
                 CounterBtn(
                  onTap: (){},
                  icon: "--"),
                ],
              ),

              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  product.description,
                  style: TextStyle(fontSize: 16, color: Color.fromARGB(176, 119, 119, 119)),
                ),
              ),
              SizedBox(height: 20,),
              Text("Shipping & Returns", style: GoogleFonts.gabarito(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),),
                SizedBox(height: 10,),
              Text("Free standard shipping and free 60-day returns", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color.fromARGB(176, 119, 119, 119)
                ),),

                SizedBox(height: 30,),

                Text("Reviews", style: GoogleFonts.gabarito(
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  )
                ),),
                Text("${product.rating} Rating", style: GoogleFonts.gabarito(
                  textStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  )
                ),),
                SizedBox(height: 20,),
                Text("${product.stock} reviews", style: TextStyle(
                  color: Color.fromARGB(176, 119, 119, 119)
                ),),
                SizedBox(height: 20,),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  //TODO: Convert to listview builder
                  child: ListView(
                    children: [
                      ReviewCard(
                    avatar: "assets/images/avatar1.png",
                    name: "Samantha",
                    review: "Great quality jacket, very comfortable and fits well. The material is durable and perfect for everyday wear.",
                    daysAgo: 12,
                    rating: 4,
                  ),
                  ReviewCard(
                    avatar: "assets/images/avatar2.png",
                    name: "Alex Morgan",
                    review: "I love this",
                    daysAgo: 8,
                    rating:5 ,
                  ),
                    ],
                  ),
                ),
                SizedBox(height: 200,)
            ],
          ),
        ),
      ),

      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width * 0.9,
        child: FloatingActionButton.extended(onPressed: (){},
        label: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$${product.price.toStringAsFixed(2)}', style: GoogleFonts.gabarito(textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white
              )),),
              Text("Add to bag", style: GoogleFonts.gabarito(textStyle: TextStyle(
                fontSize: 16,
                color: Colors.white
              )),)
            ],
          ),
        )),
      ),
       
       
       );
        
    
  }
}
