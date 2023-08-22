import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:peter_s_application2/core/app_export.dart';
import 'package:peter_s_application2/presentation/favorite_screen/widgets/favorite_screen_item_widget.dart';
import 'package:peter_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:peter_s_application2/widgets/app_bar/appbar_title.dart';
import 'package:peter_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:peter_s_application2/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class FavoriteScreen extends StatefulWidget {
  String quoteText;
  String quoteAuthor;
  final Function(String) onRemove;
  final List<String> favoriteQuotes;

  FavoriteScreen({
    Key? key,
    required this.favoriteQuotes,
    required this.quoteText,
    required this.quoteAuthor,
    required this.onRemove,
  }) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  ValueNotifier<String> searchQuery = ValueNotifier<String>('');

  TextEditingController searchController = TextEditingController();

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


  void removeFromFavorites(String quote) {
    setState(() {
      widget.favoriteQuotes.remove(quote);
    });
    saveFavoriteQuoteIds(widget.favoriteQuotes);
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
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
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: getHorizontalSize(353),
                  margin: getMargin(left: 20, top: 20, right: 20),
                  padding: getPadding(top: 14, bottom: 14),
                  decoration: AppDecoration.fill.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder6,
                  ),
                  child: CustomAppBar(
                    height: getVerticalSize(32),
                    centerTitle: true,
                    title: Row(
                      children: [
                        AppbarImage(
                          height: getSize(32),
                          width: getSize(32),
                          svgPath: ImageConstant.imgArrowleft,
                          onTap: () {
                            onTapArrowleft(context);
                          },
                        ),
                        AppbarTitle(
                          text: "Back To Home Screen",
                          margin: getMargin(left: 3, top: 1, bottom: 1),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Container(
                      padding: getPadding(
                        left: 20,
                        top: 10,
                        right: 20,
                        bottom: 10,
                      ),
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: getVerticalSize(10),
                          );
                        },
                        itemCount: widget.favoriteQuotes.length + 1, // Add 1 for the search field
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return CustomTextFormField(
                              controller: searchController,
                              contentPadding: getPadding(
                                left: 12,
                                top: 18,
                                right: 12,
                                bottom: 18,
                              ),
                              textStyle: theme.textTheme.titleLarge!,
                              hintText: "Type Something Here To Search..",
                              hintStyle: theme.textTheme.titleLarge!,
                              filled: true,
                              fillColor: theme.colorScheme.onPrimary,
                              onChanged: (value) {
                                searchQuery.value = value;
                              },
                            );
                          } else {
                            final filteredQuotes = widget.favoriteQuotes.where((quote) =>
                                quote.toLowerCase().contains(searchQuery.value.toLowerCase())).toList();
                            if (index <= filteredQuotes.length) {
                              final quote = filteredQuotes[index - 1].split('|');
                              return FavoriteScreenItemWidget(
                                quoteText: quote[0],
                                highlightText: searchQuery.value,
                                quoteAuthor: quote[1],
                                  onRemovePressed: () {
                                  setState(() {
                                    widget.onRemove(filteredQuotes[index - 1]);
                                  });
                                  },
                              );
                            } else {
                              return SizedBox.shrink();
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onTapArrowleft(BuildContext context) {
    Navigator.pop(context);
  }
}
