import 'package:flutter/material.dart';
import 'package:pbl5/models/user/user.dart';
import 'package:pbl5/routes.dart';

class SearchItem extends StatelessWidget {
  final User item;
  final String? searchText;

  const SearchItem({
    Key? key,
    required this.item,
    this.searchText,
  }) : super(key: key);

  TextSpan _highlightText(String text, String? highlight) {
    if (highlight == null || highlight.isEmpty) {
      return TextSpan(text: text, style: TextStyle(color: Colors.black));
    }

    String pattern = highlight.toLowerCase();
    RegExp regExp = RegExp(pattern, caseSensitive: false);

    List<TextSpan> spans = [];
    text.splitMapJoin(
      regExp,
      onMatch: (match) {
        spans.add(TextSpan(
          text: match.group(0),
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink),
        ));
        return match.group(0)!;
      },
      onNonMatch: (nonMatch) {
        spans.add(
            TextSpan(text: nonMatch, style: TextStyle(color: Colors.black)));
        return nonMatch;
      },
    );

    return TextSpan(children: spans);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(
          Routes.userDetail,
          arguments: item.id ?? '',
        );
      },
      leading: item.avatar == null
          ? CircleAvatar(
              child: Icon(Icons.person),
            )
          : CircleAvatar(
              backgroundImage: NetworkImage(item.avatar!),
            ),
      title: RichText(
        text: _highlightText(
            (item.lastName ?? '') + " " + (item.firstName ?? ''), searchText),
      ),
      subtitle: RichText(
        text: _highlightText(item.email ?? '', searchText),
      ),
    );
  }
}
