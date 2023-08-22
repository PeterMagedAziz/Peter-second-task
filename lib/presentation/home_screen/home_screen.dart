import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peter_s_application2/core/app_export.dart';
import 'package:peter_s_application2/widgets/custom_elevated_button.dart';
import '../favorite_screen/favorite_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? quoteText;
  String? quoteAuthor;
  bool isFavorite = false;
  List<String> favoriteQuotes = [];

  @override
  void initState() {
    super.initState();
    _getRandomQuote();
    loadFavoriteQuoteIds().then((ids) {
      setState(() {
        favoriteQuotes = ids;
      });
    });
  }

  Future<void> saveFavoriteQuoteIds(List<String> favoriteQuoteIds) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoriteQuoteIds', favoriteQuoteIds);
  }

  Future<List<String>> loadFavoriteQuoteIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteQuoteIds = prefs.getStringList('favoriteQuoteIds');
    return favoriteQuoteIds ?? [];
  }

  Future<void> _getRandomQuote() async {
    final response = await http.get(Uri.https('api.quotable.io', '/random'));
    if (response.statusCode == 200) {
      final quote = jsonDecode(response.body);
      setState(() {
        quoteText = quote['content'];
        quoteAuthor = quote['author'];
      });
    } else {
      print('Error getting quote');
    }
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      if (isFavorite) {
        if (!favoriteQuotes.contains('$quoteText|$quoteAuthor')) {
          favoriteQuotes.add('$quoteText|$quoteAuthor');
        }
      } else {
        favoriteQuotes.remove('$quoteText|$quoteAuthor'); // Remove the quote from the favorite quotes list
      }
    });
    saveFavoriteQuoteIds(favoriteQuotes);

    // Reset the favorite icon color to the original color after a short delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isFavorite = false;
      });
    });
  }

  void removeFromFavorites(String quote) {
    setState(() {
      favoriteQuotes.remove(quote);
    });
    saveFavoriteQuoteIds(favoriteQuotes).then((_) {
      loadFavoriteQuoteIds().then((ids) {
        setState(() {
          favoriteQuotes = ids;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Container(
          width: mediaQueryData.size.width,
          height: mediaQueryData.size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.5, 0),
              end: Alignment(0.5, 1),
              colors: [
                appTheme.deepPurpleA700,
                theme.colorScheme.primary,
              ],
            ),
          ),
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: getVerticalSize(76),
                  width: getHorizontalSize(363),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.only(right: 1),
                          padding: EdgeInsets.fromLTRB(34, 13, 34, 13),
                          decoration: AppDecoration.fill.copyWith(
                            borderRadius: BorderRadiusStyle.customBorderTL6,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: InkWell(
                              onTap: () async {
                                final removedQuote = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FavoriteScreen(
                                      onRemove: (quote) {
                                        setState(() {
                                          removeFromFavorites(quote);
                                          // favoriteQuotes.remove(quote);
                                        });
                                      },
                                      favoriteQuotes: favoriteQuotes,
                                      quoteText: quoteText!,
                                      quoteAuthor: quoteAuthor!,
                                    ),
                                  ),
                                );
                                if (removedQuote != null) {
                                  removeFromFavorites(removedQuote);
                                }
                              },
                              child: Text(
                                "Click Here To View Favorite Quotes",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: theme.textTheme.headlineMedium,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: getSize(32),
                          padding: EdgeInsets.fromLTRB(11, 3, 11, 3),
                          decoration: AppDecoration.txtFill.copyWith(
                            borderRadius: BorderRadiusStyle.txtCircleBorder16,
                          ),
                          child: Text(
                            favoriteQuotes.length.toString(),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: CustomTextStyles.titleLargeOnPrimary_1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                  padding: EdgeInsets.fromLTRB(20, 19, 20, 19),
                  decoration: AppDecoration.fill1.copyWith(
                    borderRadius: BorderRadiusStyle.customBorderBL6,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: getHorizontalSize(313),
                        child: Text(
                          '"${quoteText ?? ""}"', // Display the quote text
                          // textAlign: TextAlign.justify,
                          style: theme.textTheme.headlineMedium,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        quoteAuthor ?? "", // Display the quote author
                        textAlign: TextAlign.left,
                        style: theme.textTheme.titleLarge,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 19),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomElevatedButton(
                              text: "Generate Another Quote",
                              buttonStyle:
                              CustomButtonStyles.fillPrimary.copyWith(
                                fixedSize: MaterialStateProperty.all<Size>(
                                  Size(
                                    getHorizontalSize(203),
                                    getVerticalSize(48),
                                  ),
                                ),
                              ),
                              buttonTextStyle:
                              CustomTextStyles.titleLargeOnPrimary,
                              onTap: _getRandomQuote, // Call the method to fetch a new quote
                            ),
                            GestureDetector(
                              onTap: _toggleFavorite,
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                elevation: 0,
                                margin: EdgeInsets.all(0),
                                color: isFavorite
                                    ? Colors.yellow
                                    : theme.colorScheme.onPrimary,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: theme.colorScheme.primary,
                                    width: getHorizontalSize(2),
                                  ),
                                  borderRadius:
                                  BorderRadiusStyle.customBorderBR6,
                                ),
                                child: Container(
                                  height: getVerticalSize(48),
                                  width: getHorizontalSize(100),
                                  padding: EdgeInsets.fromLTRB(34, 8, 34, 8),
                                  decoration: AppDecoration.outline.copyWith(
                                    borderRadius:
                                    BorderRadiusStyle.customBorderBR6,
                                  ),
                                  child: Stack(
                                    children: [
                                      CustomImageView(
                                        svgPath: isFavorite
                                            ? ImageConstant.imgFavoriteFilled
                                            : ImageConstant.imgFavorite,
                                        height: getSize(32),
                                        width: getSize(32),
                                        alignment: Alignment.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
