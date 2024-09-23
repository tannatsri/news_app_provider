import 'package:flutter/material.dart';
import 'package:news_app/base/provider/network_provider.dart';
import 'package:news_app/base/provider/storage_provider.dart';
import 'package:news_app/base/provider/theme_provider.dart';
import 'package:news_app/common/base_components/base_button_widget.dart';
import 'package:news_app/common/base_components/base_image_widget.dart';
import 'package:news_app/common/base_components/base_text_widget.dart';
import 'package:news_app/common/base_components/text_image_span_widget.dart';
import 'package:news_app/common/extension/string.dart';
import 'package:news_app/common/extension/widget.dart';
import 'package:provider/provider.dart';

import '../../base/view/base_view.dart';
import '../../common/base_components/base_app_bar.dart';
import '../detail_page/detail_page_view.dart';
import 'home_page_view_controller.dart';
import 'home_page_view_repository.dart';

class HomePage extends IView<HomePageViewController> {
  const HomePage({super.key});

  @override
  HomePageViewController createViewController(
    BuildContext context,
    NetworkAssistantProvider apiProvider,
    StorageAssistantProvider storageProvider,
  ) {
    return HomePageViewController(
      apiProvider: apiProvider,
      storageProvider: storageProvider,
    );
  }

  @override
  Widget buildView(BuildContext context, ThemeProvider themeProvider) {
    return Consumer<HomePageViewController>(
      builder: (context, viewController, _) {
        if (viewController.state.isLoading == true) {
          return Scaffold(
            backgroundColor: HexColor(
              themeProvider
                  .getThemeBasedColor(BaseColorEnum.primaryBackgroundColor),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (viewController.state.data != null) {
          final responseData = viewController.state.data as NewsResponseData?;
          return Scaffold(
            backgroundColor: HexColor(themeProvider
                .getThemeBasedColor(BaseColorEnum.primaryBackgroundColor)),
            appBar: BaseAppBar(
              themeProvider: themeProvider,
              showBack: false,
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                await viewController.refreshData();
              },
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: responseData?.articles?.length ?? 0,
                itemBuilder: (context, index) {
                  if (responseData?.articles?[index].urlToImage?.isNotEmpty !=
                      true) {
                    return const SizedBox.shrink();
                  }
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            articleData: responseData?.articles?[index],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: HexColor(themeProvider.getThemeBasedColor(
                          BaseColorEnum.primaryComponentBackgroundColor)),
                      elevation: 0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (responseData
                                  ?.articles?[index].urlToImage?.isNotEmpty ==
                              true)
                            Hero(
                              tag: responseData?.articles?[index].urlToImage ??
                                  "",
                              child: BaseImageWidget(
                                data: BaseImageData(
                                  png:
                                      responseData?.articles?[index].urlToImage,
                                  height: 90,
                                  width: 130,
                                ),
                              ),
                            ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextImageSpanWidget(
                                  data: TextImageSpanWidgetData(
                                    alignment: "top-left",
                                    list: [
                                      if ((responseData
                                                  ?.articles?[index].author)
                                              .isNullOrEmpty() ==
                                          false)
                                        TextImageSpanWidgetItemData(
                                          type: "text",
                                          title: BaseTextData(
                                            text:
                                                "${responseData?.articles?[index].author} | ",
                                            color: themeProvider
                                                .getThemeBasedColor(
                                                    BaseColorEnum
                                                        .secondaryTextBgColor),
                                            font: "overline",
                                          ),
                                        ),
                                      if ((responseData?.articles?[index]
                                                  .publishedAt)
                                              .isNullOrEmpty() ==
                                          false)
                                        TextImageSpanWidgetItemData(
                                          type: "text",
                                          title: BaseTextData(
                                            text:
                                                "${(responseData?.articles?[index].publishedAt ?? "").toHumanReadable()} ",
                                            color: themeProvider
                                                .getThemeBasedColor(
                                                BaseColorEnum
                                                    .tertiaryTextBgColor),
                                            font: "overline2",
                                          ),
                                        ),
                                    ],
                                  ),
                                  onClickListener: null,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                if ((responseData?.articles?[index].title)
                                        .isNullOrEmpty() ==
                                    false)
                                  BaseTextWidget(
                                    data: BaseTextData(
                                      text:
                                          responseData?.articles?[index].title,
                                      color: themeProvider.getThemeBasedColor(
                                          BaseColorEnum.primaryTextBgColor),
                                      font: "caption",
                                      maxLine: 2,
                                    ),
                                  ),
                                const SizedBox(
                                  height: 4,
                                ),
                                if ((responseData?.articles?[index].description)
                                        .isNullOrEmpty() ==
                                    false)
                                  BaseTextWidget(
                                    data: BaseTextData(
                                      text: responseData
                                          ?.articles?[index].description,
                                      color: themeProvider.getThemeBasedColor(
                                          BaseColorEnum.primaryTextBgColor),
                                      font: "overline",
                                      maxLine: 1,
                                    ),
                                  ),
                                const SizedBox(
                                  height: 4,
                                ),
                                if ((responseData
                                            ?.articles?[index].source?.name)
                                        .isNullOrEmpty() ==
                                    false)
                                  TextImageSpanWidget(
                                    data: TextImageSpanWidgetData(
                                      alignment: "top-left",
                                      list: [
                                        TextImageSpanWidgetItemData(
                                          type: "text",
                                          title: BaseTextData(
                                            text:
                                                "Source: ${(responseData?.articles?[index].source?.name)} ",
                                            color: themeProvider
                                                .getThemeBasedColor(
                                                BaseColorEnum
                                                    .secondaryTextBgColor),
                                            font: "overline2",
                                          ),
                                        )
                                      ],
                                    ),
                                    onClickListener: null,
                                  ),
                              ],
                            ),
                          )
                        ],
                      ).padding(
                        data: PaddingData(left: 8, right: 8, bottom: 8, top: 8),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BaseImageWidget(
                    data: BaseImageData(
                      png:
                          "https://indcdn.indmoney.com/cdn/images/fe/error_icon_ind_garage.png",
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const SizedBox(height: 40),
                  BaseTextWidget(
                    data: BaseTextData(
                      text: "Something went wrong!. Please try again later",
                      color: themeProvider
                          .getThemeBasedColor(
                          BaseColorEnum
                              .secondaryTextBgColor),
                      font: "caption",
                    ),
                  ),
                  const SizedBox(height: 16),
                  BaseButtonWidget(
                    data: BaseButtonData(
                      bgColor: "#089959",
                      title: BaseTextData(
                        text: "  Retry Again  ",
                        color: "#ffffff",
                        font: "body",
                      ),
                    ),
                    onClickListener: (cta) {
                      viewController.fetchInitialData(isRetry: true);
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
