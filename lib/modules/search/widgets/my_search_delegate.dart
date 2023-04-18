import 'package:flutter/material.dart';
import 'package:nha_gia_re/core/theme/app_colors.dart';
import 'package:nha_gia_re/core/theme/text_styles.dart';
import 'package:nha_gia_re/modules/search/search_controller.dart';
import 'package:nha_gia_re/modules/search/screens/result_page.dart';
import 'package:nha_gia_re/modules/search/widgets/suggestion_list.dart';

// Defines the content of the search page in `showSearch()`.
// SearchDelegate has a member `query` which is the query string.
class MySearchDelegate extends SearchDelegate<String> {
  final SearchController controller;

  MySearchDelegate(this.controller);

  void closeDelegate(BuildContext context, String value) {
    // SearchDelegate.close() can return vlaues, similar to Navigator.pop().
    close(context, value);
  }

// custom search bar style
  // hint text
  @override
  String? get searchFieldLabel => controller.hintText;

  // text style in textfield
  @override
  TextStyle? get searchFieldStyle => AppTextStyles.roboto16regular;

  // appbar theme
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final InputBorder borderStyle = OutlineInputBorder(
      borderSide: BorderSide(width: 0, color: AppColors.white),
    );
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        iconTheme: theme.primaryIconTheme.copyWith(color: AppColors.black),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(10),
        filled: true,
        fillColor: AppColors.white,
        focusedBorder: borderStyle,
        enabledBorder: borderStyle,
      ),
    );
  }

  // Leading icon in search bar.
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        closeDelegate(context, "");
      },
    );
  }

  // Widget of result page.
  @override
  Widget buildResults(BuildContext context) {
    return ResultPage();
  }

  @override
  void showResults(BuildContext context) {
    /// add the query to history
    controller.addToHistory(query.trim());
    super.showResults(context);
  }

  // Suggestions list while typing (this.query).
  @override
  Widget buildSuggestions(BuildContext context) {
    controller.updateSuggestions(query);

    return SuggestionList(
      query: query,
      suggestions: controller.suggestions,
      onSelected: (String suggestion) {
        // event when tap in suggestion
        query = suggestion;
        controller.addToHistory(suggestion);
        showResults(context);
      },
      onDeleted: controller.deleteHistory,
    );
  }

  // Action buttons at the right of search bar.
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      if (query.isEmpty)
        IconButton(
          tooltip: 'Voice Search',
          icon: const Icon(Icons.mic),
          onPressed: () {
            query = 'TODO: implement voice input';
          },
        )
      else
        IconButton(
          tooltip: 'Clear',
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        )
    ];
  }
}
