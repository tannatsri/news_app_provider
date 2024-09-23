import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/base/provider/network_provider.dart';
import 'package:news_app/base/provider/storage_provider.dart';
import 'package:news_app/base/provider/theme_provider.dart';
import 'package:news_app/common/extension/string.dart';
import 'package:news_app/common/extension/widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../base/view/base_view.dart';
import '../../common/base_components/base_app_bar.dart';
import '../../common/base_components/base_image_widget.dart';
import '../../common/base_components/base_text_widget.dart';
import '../../common/base_components/text_image_span_widget.dart';
import '../home_page/home_page_view_repository.dart';
import 'detail_page_view_controller.dart';

class DetailPage extends IView<DetailPageViewController> {
  final NewsArticle? articleData;

  const DetailPage({
    required this.articleData,
    super.key,
  });

  @override
  DetailPageViewController createViewController(
    BuildContext context,
    NetworkAssistantProvider apiProvider,
    StorageAssistantProvider storageProvider,
  ) {
    return DetailPageViewController(
      apiProvider: apiProvider,
      storageProvider: storageProvider,
    );
  }

  @override
  Widget buildView(BuildContext context, ThemeProvider themeProvider) {
    return Consumer<DetailPageViewController>(
      builder: (context, viewController, _) {
        if (viewController.state.isLoading == true) {
          return Scaffold(
            backgroundColor: HexColor(themeProvider.getThemeBasedColor(BaseColorEnum.primaryBackgroundColor)),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (viewController.state.data != null) {
          return Scaffold(
            backgroundColor: HexColor(themeProvider.getThemeBasedColor(BaseColorEnum.primaryBackgroundColor)),
            appBar: BaseAppBar(themeProvider: themeProvider),
            body: ListView(
              children: [
                Hero(
                  tag: articleData?.urlToImage ?? "",
                  child: BaseImageWidget(
                    data: BaseImageData(
                      png: articleData?.urlToImage,
                      aspectRatio: 1.8,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                if ((articleData?.title).isNullOrEmpty() == false)
                  TextImageSpanWidget(
                    data: TextImageSpanWidgetData(
                      alignment: "top-left",
                      list: [
                        TextImageSpanWidgetItemData(
                          type: "text",
                          title: BaseTextData(
                            text: articleData?.title,
                            color: themeProvider.getThemeBasedColor(BaseColorEnum.primaryTextBgColor),
                            font: "h3",
                          ),
                        ),
                      ],
                    ),
                    onClickListener: null,
                  ).padding(
                    data: PaddingData(left: 16, right: 16, bottom: 0, top: 0),
                  ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextImageSpanWidget(
                        data: TextImageSpanWidgetData(
                          alignment: "top-left",
                          list: [
                            if ((articleData?.author).isNullOrEmpty() == false)
                              TextImageSpanWidgetItemData(
                                type: "text",
                                title: BaseTextData(
                                  text: "Author: ",
                                  color: themeProvider
                                      .getThemeBasedColor(
                                      BaseColorEnum
                                          .secondaryTextBgColor),
                                  font: "caption",
                                ),
                              ),
                            if ((articleData?.author).isNullOrEmpty() == false)
                              TextImageSpanWidgetItemData(
                                type: "text",
                                title: BaseTextData(
                                  text: "${(articleData?.author ?? "")} ",
                                  color: themeProvider
                                      .getThemeBasedColor(
                                      BaseColorEnum
                                          .primaryTextBgColor),
                                  font: "caption",
                                ),
                              ),
                          ],
                        ),
                        onClickListener: null,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    TextImageSpanWidget(
                      data: TextImageSpanWidgetData(
                        alignment: "top-left",
                        list: [
                          if ((articleData?.publishedAt).isNullOrEmpty() ==
                              false)
                            TextImageSpanWidgetItemData(
                              type: "text",
                              title: BaseTextData(
                                text: "Last Updated: ",
                                color: themeProvider
                                    .getThemeBasedColor(
                                    BaseColorEnum
                                        .secondaryTextBgColor),
                                font: "overline",
                              ),
                            ),
                          if ((articleData?.publishedAt).isNullOrEmpty() ==
                              false)
                            TextImageSpanWidgetItemData(
                              type: "text",
                              title: BaseTextData(
                                text:
                                    "${(articleData?.publishedAt ?? "").toHumanReadable()} ",
                                color: themeProvider
                                    .getThemeBasedColor(
                                    BaseColorEnum
                                        .secondaryTextBgColor),
                                font: "overline2",
                              ),
                            ),
                        ],
                      ),
                      onClickListener: null,
                    ),
                  ],
                ).padding(
                  data: PaddingData(left: 16, right: 16, bottom: 0, top: 0),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextImageSpanWidget(
                  data: TextImageSpanWidgetData(
                    alignment: "top-left",
                    list: [
                      if ((articleData?.content).isNullOrEmpty() == false)
                        TextImageSpanWidgetItemData(
                          type: "text",
                          title: BaseTextData(
                            text: articleData?.content,
                            color: themeProvider
                                .getThemeBasedColor(
                                BaseColorEnum
                                    .primaryTextBgColor),
                            font: "caption",
                          ),
                        ),
                    ],
                  ),
                  onClickListener: null,
                ).padding(
                  data: PaddingData(left: 16, right: 16, bottom: 0, top: 0),
                ),
                const SizedBox(
                  height: 12,
                ),
                if ((articleData?.url).isNullOrEmpty() == false)
                  TextImageSpanWidget(
                    data: TextImageSpanWidgetData(
                      alignment: "top-left",
                      list: [
                        TextImageSpanWidgetItemData(
                          type: "text-cta",
                          title: BaseTextData(
                            text: "Read More >",
                            color: "#017aff",
                            font: "caption",
                          ),
                        ),
                      ],
                    ),
                    onClickListener: (cta) {
                      launchUrl(Uri.parse(articleData?.url ?? ""));
                    },
                  ).padding(
                    data: PaddingData(left: 16, right: 16, bottom: 0, top: 0),
                  ),
              ],
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
                      height: 200,
                      width: 200,
                    ),
                  ),
                  const SizedBox(height: 20),
                  BaseTextWidget(
                    data: BaseTextData(
                      text: "Something went wrong!. Please try again later",
                      color: themeProvider
                          .getThemeBasedColor(
                          BaseColorEnum
                              .secondaryTextBgColor),
                      font: "caption",
                    ),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
