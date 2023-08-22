import 'package:flutter/material.dart';
import 'package:peter_s_application2/core/app_export.dart';
import 'package:peter_s_application2/widgets/app_bar/appbar_image.dart';
import 'package:peter_s_application2/widgets/app_bar/appbar_title.dart';
import 'package:peter_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:peter_s_application2/widgets/custom_outlined_button.dart';
import 'package:peter_s_application2/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class FavoriteScreenWhileUsingSearchScreen extends StatelessWidget {
  final VoidCallback? onRemovePressed;

  FavoriteScreenWhileUsingSearchScreen({Key? key, this.onRemovePressed})
      : super(key: key);

  TextEditingController opportunityController = TextEditingController();
  String searchResult = '';

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
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
                theme.colorScheme.primary
              ])),
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
                        borderRadius: BorderRadiusStyle.roundedBorder6),
                    child: CustomAppBar(
                        height: getVerticalSize(32),
                        centerTitle: true,
                        title: Row(children: [
                          AppbarImage(
                              height: getSize(32),
                              width: getSize(32),
                              svgPath: ImageConstant.imgArrowleft,
                              onTap: () {
                                onTapArrowleft1(context);
                              }),
                          AppbarTitle(
                              text: "Back To Home Screen",
                              margin: getMargin(left: 3, top: 1, bottom: 1))
                        ]))),
                Container(
                  padding: getPadding(left: 20, top: 10, right: 20, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        controller: opportunityController,
                        contentPadding:
                            getPadding(left: 18, top: 18, bottom: 18),
                        textStyle:
                            CustomTextStyles.titleLargeOnPrimaryContainer,
                        hintText: "opportunity",
                        hintStyle:
                            CustomTextStyles.titleLargeOnPrimaryContainer,
                        suffix: Container(
                            margin: getMargin(
                                left: 30, top: 18, right: 18, bottom: 18),
                            child: CustomImageView(
                                svgPath: ImageConstant.imgClose)),
                        suffixConstraints:
                            BoxConstraints(maxHeight: getVerticalSize(30)),
                        filled: true,
                        fillColor: theme.colorScheme.onPrimary,
                        onChanged: (value) {
                          searchResult = value;
                        },
                      ),
                      Container(
                        margin: getMargin(top: 10, bottom: 5),
                        padding: getPadding(
                            left: 20, top: 19, right: 20, bottom: 19),
                        decoration: AppDecoration.fill1.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder6),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: getHorizontalSize(313),
                                child: Text(
                                    "“While we stop to think, we often miss our opportunity.”",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                    style: theme.textTheme.headlineMedium)),
                            Text("Publilius Syrus",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: theme.textTheme.titleLarge),
                            CustomOutlinedButton(
                              text: "Remove From Favorite",
                              margin: getMargin(top: 17),
                              leftIcon: Container(
                                  margin: getMargin(right: 4),
                                  child: CustomImageView(
                                      svgPath:
                                          ImageConstant.imgFavoritePrimary)),
                              buttonStyle: CustomButtonStyles.outlinePrimary
                                  .copyWith(
                                      fixedSize:
                                          MaterialStateProperty.all<Size>(Size(
                                              double.maxFinite,
                                              getVerticalSize(48)))),
                              buttonTextStyle:
                                  CustomTextStyles.titleLargePrimary,
                              onTap: onRemovePressed,
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

  onTapArrowleft1(BuildContext context) {
    Navigator.pop(context);
  }
}
