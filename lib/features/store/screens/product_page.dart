import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:depi_final_project/core/theme/colors.dart';
import 'package:depi_final_project/core/routes/app_routes.dart';
import 'package:depi_final_project/data/models/cart_product.dart';
import 'package:depi_final_project/data/models/product_model.dart';
import 'package:depi_final_project/data/models/product_model.dart';
import 'package:depi_final_project/features/store/cubit/cart_cubit.dart';
import 'package:depi_final_project/features/store/cubit/cart_state.dart';
import 'package:depi_final_project/core/widgets/progress_hud_widget.dart';
import 'package:depi_final_project/features/store/widgets/counter_btn.dart';
import 'package:depi_final_project/features/store/widgets/review_card.dart';
import 'package:depi_final_project/features/store/widgets/app_bar_icon.dart';
import 'package:depi_final_project/features/store/widgets/product_option.dart';
import 'package:depi_final_project/features/store/widgets/customize_option.dart';
import 'package:depi_final_project/features/store/widgets/custom_bottom_sheet.dart';


class ProductPage extends StatefulWidget {

  final ProductModel product;
   const ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int selectedSize = 0;
  int selectedColor = 0;
  int count = 1;



  @override
  Widget build(BuildContext context) {
    final themeBrightness = Theme.of(context).brightness;

    final cubit = context.read<CartCubit>();

    return ProgressHUDWidget(
      isLoading: context.watch<CartCubit>().state is CartLoading,
      child: Scaffold(
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

      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
      
        if(state is CartError){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }

          if(state is CartSuccess){
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product added successfully", style: TextStyle(color: Colors.white),), backgroundColor: Colors.green,));
            Navigator.pushNamed(context, AppRoutes.cart);
          }

          
        },
        builder: (context, state){
       return Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.product.imageUrl.length,
                    itemBuilder: (context, index){
                      return Image.network(widget.product.imageUrl[index]);
                    },
                    
                  ),
                ),
            
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(widget.product.name, style: GoogleFonts.gabarito(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),),
                ),
                SizedBox(height: 10,),
                Text("\$${widget.product.price}", style: GoogleFonts.gabarito(textStyle: TextStyle(
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
                          options: List.generate(widget.product.sizes.length, (index){
                           return CustomizeOption(
                            label: widget.product.sizes[index], 
                            isSelected: selectedSize == index,
                            onTap: (){
                              setState(() {
                                selectedSize = index;
                                Navigator.pop(context);
                              });
                            },);
                          }),
                        );
                      });
                  },
                  label: "Size",
                  options: [
                    Text(widget.product.sizes[selectedSize], style: GoogleFonts.gabarito(textStyle: TextStyle(
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
                      options: List.generate(widget.product.colors.length, 
                      (index){
                        return CustomizeOption(
                          label: widget.product.colors[index], 
                          isSelected: selectedColor == index,
                          onTap: (){
                            setState(() {
                              selectedColor = index;
                              Navigator.pop(context);
                            });
                          },
                      selection:  
                      Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        // color: Color(int.parse(widget.product.colors[index]))
                      ),
                    ),
                    );
                      }));
                    });
                  },
                  label: "Color",
                  options: [
                    Text(widget.product.colors[selectedColor]),
                    // Container(
                    //   width: 20,
                    //   height: 20,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(100),
                    //     // color: Color(int.parse(widget.product.colors[selectedColor])) //first value until user selection TODO: change to user selection
                    //   ),
                    // ),
                    SizedBox(width: 30,),
                    Image.asset(themeBrightness == Brightness.light? "assets/icons/arrowdown.png":"assets/icons/arrowdown_dark.png")
                  ],
                ),
                ProductOption(
                  label: "Quantity",
                  options: [
                   CounterBtn(
                    onTap: (){
                      setState(() {
                       if(count < widget.product.stock) count++;
                      });
                    },
                    icon: "+"),
                    SizedBox(width: 20,),
        
                    Text("$count", style: TextStyle(fontSize: 16),),
                    SizedBox(width: 20,),
                   CounterBtn(
                    onTap: (){
                      setState(() {
                       if(count > 1) count--;
                      });
                    },
                    icon: "--"),
                  ],
                ),
        
                //TODO: get all values from database
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.product.description,
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
                  Text("${widget.product.rating} Rating", style: GoogleFonts.gabarito(
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
        );}
      ),

      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width * 0.9,
        child: FloatingActionButton.extended(onPressed: (){
          cubit.addProductToCart(CartProduct(
            productId: widget.product.id, 
            selectedSize: widget.product.sizes[selectedSize], 
            selectedColor: widget.product.colors[selectedColor], 
            quantity: count));
        },
        label: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("\$${widget.product.price}", style: GoogleFonts.gabarito(textStyle: TextStyle(
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
      ),
    );
    
  }
}
