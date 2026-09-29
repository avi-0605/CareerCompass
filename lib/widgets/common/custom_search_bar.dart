import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final VoidCallback? onFilterTap;
  final TextEditingController? controller;

  const CustomSearchBar({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.onFilterTap,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          const Icon(Icons.search, color: Color(0xFF64748B)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                filled: false,
              ),
            ),
          ),
          if (onFilterTap != null) ...[
            Container(
              height: 24,
              width: 1,
              color: const Color(0xFFE2E8F0),
            ),
            IconButton(
              icon: const Icon(Icons.tune, color: Color(0xFF2563EB)),
              onPressed: onFilterTap,
            ),
          ],
        ],
      ),
    );
  }
}
