import 'package:depi_final_project/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/features/store/widgets/counter_btn.dart';
import 'package:depi_final_project/features/store/widgets/review_card.dart';
import 'package:depi_final_project/features/store/widgets/app_bar_icon.dart';
import 'package:depi_final_project/features/store/widgets/product_option.dart';
import 'package:depi_final_project/features/store/widgets/customize_option.dart';
import 'package:depi_final_project/features/store/widgets/custom_bottom_sheet.dart';  


class ProductPage extends StatelessWidget {

  final ProductModel product;
  const ProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final themeBrightness = Theme.of(context).brightness;
    // final product = ModalRoute.of(context)!.settings.arguments as ProductModel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10),
          child: AppBarIcon(
            icon:themeBrightness == Brightness.light? "assets/icons/arrowleft.png":"assets/icons/arrowleft_dark.png",
            onTap: () => Navigator.pop(context),
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
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: product.imageUrl.length,
                  itemBuilder: (context, index){
                    return Image.network(product.imageUrl[index]);
                  },
                  
                ),
              ),
          
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(product.name, style: GoogleFonts.gabarito(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),),
              ),
              SizedBox(height: 10,),
              Text("\$${product.price}", style: GoogleFonts.gabarito(textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff8E6CEF)
              )),),
          
              ProductOption(
                onTap: (){
                  showModalBottomSheet(
                    context: context, 
                    builder: (context){
                      return CustomBottomSheet(
                        title: "Size",
                        options: List.generate(product.sizes.length, (index){
                         return CustomizeOption(label: product.sizes[index], isSelected: product.selectedSize == product.sizes[index],);
                        }),
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
                    options: List.generate(product.colors.length, 
                    (index){
                      return CustomizeOption(label: product.colors[index], isSelected: false);
                    }));
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

              //TODO: get all values from database
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
                Text("213 reviews", style: TextStyle(
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
              Text("\$${product.price}", style: GoogleFonts.gabarito(textStyle: TextStyle(
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