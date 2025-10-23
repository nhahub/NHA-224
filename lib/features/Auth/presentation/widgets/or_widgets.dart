import 'package:depi_final_project/core/theme/text_style.dart';
import 'package:depi_final_project/features/Auth/presentation/widgets/expended_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ExpandedDivider(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Text(
            "or register with",
            style: AppTextStyles.font17BlackRegular.copyWith(
              color: Colors.grey.shade700,
            ),
          ),
        ),
        ExpandedDivider(),
      ],
    );
  }
}
