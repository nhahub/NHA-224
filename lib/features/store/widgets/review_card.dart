import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.avatar, required this.name, required this.review, required this.daysAgo, required this.rating});

  final String avatar;
  final String name;
  final String review;
  final int daysAgo;
  final int rating;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: theme.secondary,
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(image: AssetImage(avatar), fit: BoxFit.cover)
                    ),
                  ),
                  SizedBox(width: 10,),
                    Text(name, style: GoogleFonts.gabarito(
                      textStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold
                      )
                    ),)
                ],
              ),

              Row(children: List.generate(5, (i){
                return Icon(Icons.star, size: 12, color: i < rating ? theme.primary : theme.secondary,);
              }),)
            ],
          ),
          SizedBox(height: 20,),
          Text(review,
          style: TextStyle(fontSize: 12, color: Color.fromARGB(176, 119, 119, 119)),),
          SizedBox(height: 20,),
          Text("${daysAgo}days", ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}