import 'package:depi_final_project/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.avatar, required this.name, required this.review, required this.daysAgo, required this.rating});

  final String avatar;
  final String name;
  final String review;
  final String daysAgo;
  final double rating;

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
                      image: DecorationImage(image: NetworkImage(avatar), fit: BoxFit.cover)
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

             StarRating(
              size: 20,
              rating: rating,
              color: AppColors.darkPrimary,
              allowHalfRating: true,
             )
            ],
          ),
          SizedBox(height: 20,),
          Text(review,
          style: TextStyle(fontSize: 12, color: Color.fromARGB(176, 119, 119, 119)),),
          SizedBox(height: 20,),
          Text("${daysAgo}", ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}