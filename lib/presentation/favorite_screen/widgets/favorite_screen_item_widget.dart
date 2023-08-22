import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:peter_s_application2/core/app_export.dart';
import 'package:peter_s_application2/widgets/custom_outlined_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreenItemWidget extends StatelessWidget {
  final String quoteText;
  final String quoteAuthor;
  final String highlightText;
  final VoidCallback? onRemovePressed;

  FavoriteScreenItemWidget({
    Key? key,
    required this.quoteText,
    required this.quoteAuthor,
    required this.highlightText,
    this.onRemovePressed,
  }) : super(key: key);

  Future<void> saveFavoriteQuoteIds(List<String> favoriteQuotes) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/favorite_quotes.txt');
      final writer = file.openWrite();
      for (String quoteId in favoriteQuotes) {
        writer.write(quoteId);
        writer.write('\n');
      }
      await writer.close();
    } catch (e) {
      print(e);
    }
  }

  Future<void> removeFavoriteQuoteId(String quoteId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteQuotes = prefs.getStringList('favoriteQuotes') ?? [];
    favoriteQuotes.remove(quoteId);
    await prefs.setStringList('favoriteQuotes', favoriteQuotes);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 19, 20, 19),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '"$quoteText"',
            textAlign: TextAlign.left,
            style: CustomTextStyles.titleLargeOnPrimaryContainer.copyWith(color: Colors.black87),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            quoteAuthor,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: CustomTextStyles.titleLargeOnPrimaryContainer.copyWith(color: Colors.grey),
          ),
          CustomOutlinedButton(
            text: "Remove From Favorite",
            margin: EdgeInsets.only(top: 19),
            leftIcon: Container(
              margin: EdgeInsets.only(right: 4),
              child: CustomImageView(
                svgPath: ImageConstant.imgFavoritePrimary,
              ),
            ),
            buttonStyle: CustomButtonStyles.outlinePrimary.copyWith(
              fixedSize: MaterialStateProperty.all<Size>(
                Size(
                  double.maxFinite,
                  48,
                ),
              ),
            ),
            buttonTextStyle: CustomTextStyles.titleLargePrimary,
            onTap: () {
              onRemovePressed?.call();
              saveFavoriteQuoteIds([]); // Call the method to save the updated favorite quotes
            },
          ),
        ],
      ),
    );
  }
}