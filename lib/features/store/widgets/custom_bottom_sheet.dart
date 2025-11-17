import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:depi_final_project/features/store/widgets/customize_option.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key, required this.title, required this.options});

  final String title;
  final List options;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      height: MediaQuery.of(context).size.height * 0.52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: theme.surface,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.15,),
                Text(title, style: GoogleFonts.gabarito(textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24
                )),),
                IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.close))
              ],
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.52,
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      options[index],
                      SizedBox(height: 20,)
                    ],
                  );
                },)
            ),
          ],
        ),
      ),
    );
    
  }
}
