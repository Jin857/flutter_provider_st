import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  final Function(String) onSubmitted;
  final Function(String) onChange;
  final String? hintText;
  const SearchInput({
    super.key,
    this.hintText,
    required this.onSubmitted,
    required this.onChange,
  });
  @override
  State<SearchInput> createState() => _SearchInput();
}

class _SearchInput extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: TextField(
        onChanged: widget.onChange,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.black),
          ),
          contentPadding: const EdgeInsets.only(right: 15),
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
        ),
        onSubmitted: widget.onSubmitted,
      ),
    );
  }
}
