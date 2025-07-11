import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triantrak/shared/network/local/Cach_helper.dart';

import 'cubit/SearchCubit.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onChanged;

  const SearchBarWidget({
    Key? key,
    required this.searchController,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          context.read<SearchInquiryCubit>().searchInquiries(
            query: value,
            token: CachHelper.getData(key: 'token'), // ← غيّرها لاحقًا
          );
        },
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(Icons.search_outlined),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
        ),
      ),
    );
  }
}
