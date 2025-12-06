import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.image,
    required this.price,
    required this.size,
    required this.color,
    required this.title,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    this.onDelete,
  });

  final String image;
  final String title;
  final double price;
  final String size;
  final String color;
  final int quantity;
  final void Function() onIncrement;
  final void Function() onDecrement;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: theme.surface,
        border: Border.all(color: theme.outline.withOpacity(0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              image,
              width: 80.r,
              height: 80.r,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.broken_image,
                size: 48.r,
                color: theme.onSurfaceVariant,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: theme.onSurface,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    color: theme.primary,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text(
                      'Size: $size',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: theme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Color: $color',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: theme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: onDecrement,
                    child: CircleAvatar(
                      radius: 12.r,
                      backgroundColor: theme.primary,
                      child: Icon(
                        Icons.remove,
                        size: 24.r,
                        color: theme.surface,
                      ),
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    '$quantity',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: theme.onSurface,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  GestureDetector(
                    onTap: onIncrement,
                    child: CircleAvatar(
                      radius: 12.r,
                      backgroundColor: theme.primary,
                      child: Icon(Icons.add, size: 24.r, color: theme.surface),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
