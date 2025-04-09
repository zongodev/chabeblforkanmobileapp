import 'package:flutter/material.dart';
class CustomSearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onSearch;
  final void Function()? onTap;

  const CustomSearchBar({
    Key? key,
    required this.searchController,
    required this.onSearch,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 450,
      height: 60,
      child: TextField(
        textAlign: TextAlign.right,
        controller: searchController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          suffixIcon: InkWell(
            onTap: onTap,
            child: const Icon(Icons.close),
          ),
          hintText: '...بحث',
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),

        ),
        onChanged: onSearch,
      ),
    );
  }
}
