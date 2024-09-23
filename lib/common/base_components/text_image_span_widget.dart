
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/extension/string.dart';

import '../extension/widget.dart';
import 'base_button_widget.dart';
import 'base_image_widget.dart';
import 'base_text_widget.dart';

class TextImageSpanWidget extends StatelessWidget {
  const TextImageSpanWidget({
    required this.data,
    required this.onClickListener,
    super.key,
  });
  final TextImageSpanWidgetData? data;
  final OnClickCtaListener? onClickListener;

  List<InlineSpan> spanBuilder(
      List<TextImageSpanWidgetItemData>? list, BuildContext context) {
    List<InlineSpan> itemList = [];
    list?.forEach(
      (element) {
        if (element.type.isEquals("text", ignoreCase: true)) {
          if (element.title != null) {
            itemList.add(getTitleSpan(element.title, context));
          }
        } else if (element.type.isEquals("text-cta", ignoreCase: true)) {
          itemList.add(
            getTextCtaSpan(
              element.button,
              element.title,
              context,
            ),
          );
        } else if (element.type.isEquals("image", ignoreCase: true)) {
          if (element.logo != null) {
            itemList.add(getLogoSpan(element.logo, context));
          }
        } else if (element.type.isEquals("image-cta", ignoreCase: true)) {
          itemList.add(
            getLogoCtaSpan(
              element.button,
              element.logo,
              context,
            ),
          );
        }
      },
    );

    return itemList;
  }

  InlineSpan getTextCtaSpan(
    BaseButtonData? data,
    BaseTextData? title,
    BuildContext context,
  ) {
    return TextSpan(
      text: title?.text ?? "",
      style: getBaseTextStyle(
        BaseTextData(
          font: title?.font,
          color: title?.color,
        ),
      ),
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          onClickListener?.call(data);
        },
    );
  }

  InlineSpan getTitleSpan(BaseTextData? data, BuildContext context) {
    if (data == null) return const TextSpan();
    return TextSpan(
      text: data.text ?? "",
      style: getBaseTextStyle(
        BaseTextData(
          font: data.font,
          color: data.color,
        ),
      ),
    );
  }

  InlineSpan getLogoCtaSpan(
      BaseButtonData? data, BaseImageData? logo, BuildContext context) {
    if (data == null) return const WidgetSpan(child: emptyContainer);
    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: GestureDetector(
        onTap: () {
          onClickListener?.call(data);
        },
        child: BaseImageWidget(
          data: logo,
        ),
      ),
    );
  }

  InlineSpan getLogoSpan(BaseImageData? data, BuildContext context) {
    if (data == null) return const WidgetSpan(child: emptyContainer);
    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: BaseImageWidget(
        data: data,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return (data?.list != null || data?.list?.isEmpty == false)
        ? Align(
            alignment: (data?.alignment ?? "")
                .getAlignmentBasedOnValue(data?.alignment),
            child: Text.rich(
              TextSpan(
                children: spanBuilder(data?.list, context),
              ),
              textAlign: (data?.textAlignment ?? data?.alignment)
                  ?.getTextAlignmentType(
                      data?.textAlignment ?? data?.alignment),
            ).padding(
              data: PaddingData(
                left: data?.padding,
                right: data?.padding,
                bottom: data?.padding,
                top: data?.padding,
              ),
            ),
          )
        : emptyContainer;
  }
}

class TextImageSpanWidgetData {
  List<TextImageSpanWidgetItemData>? list;
  String? alignment;
  BaseButtonData? parentButton;
  String? bgColor;
  int? radius;
  String? borderColor;
  int? strokeWidth;
  int? padding;
  int? elevation;
  String? textAlignment;

  TextImageSpanWidgetData({
    this.list,
    this.alignment,
    this.bgColor,
    this.radius,
    this.borderColor,
    this.strokeWidth,
    this.padding,
    this.elevation,
    this.textAlignment,
    this.parentButton,
  });
}

class TextImageSpanWidgetItemData {
  String? type;
  BaseTextData? title;
  BaseButtonData? button;
  BaseImageData? logo;
  BaseButtonData? cta;

  TextImageSpanWidgetItemData({
    this.type,
    this.title,
    this.button,
    this.logo,
    this.cta,
  });
}

extension TextImageSpanWidgetDataExtension on TextImageSpanWidgetData? {
  bool get isValidData {
    if (this == null || this?.list == null || this?.list?.isEmpty == true) {
      return false;
    }
    return true;
  }
}

const emptyContainer = SizedBox(
  height: 0,
  width: 0,
);
