import 'package:flutter/material.dart';
import 'package:sytiamo/custom_widget/error_switcher.dart';
import 'package:sytiamo/custom_widget/no_data.dart';
import 'package:sytiamo/utils/images.dart';
import 'package:sytiamo/utils/page_state_enum.dart';

class SYPageStateWidget extends StatelessWidget {
  final PageState pageState;
  final Widget loadingWidget;
  final WidgetBuilder builder;
  final WidgetBuilder noDataBuilder;
  final String textUnderLoader;
  final Function onRetry;
  final dynamic error;
  final String noDataMessage;

  SYPageStateWidget({
    this.pageState,
    this.loadingWidget,
    this.builder,
    this.noDataBuilder,
    this.textUnderLoader,
    this.onRetry,
    this.error,
    this.noDataMessage,
  });

  @override
  Widget build(BuildContext context) {
    Widget pageBody = SizedBox.shrink();
    switch (pageState) {
      case PageState.loading:
        pageBody = SizedBox.fromSize(
          size: Size(20, 50),
          child: Center(
            child: loadingWidget ?? Image.asset(SYImages.loader),
          ),
        );
        break;
      case PageState.loaded:
        if (builder != null) pageBody = Builder(builder: builder);
        break;
      case PageState.error:
        pageBody = ErrorSwitcher(
          message: 'An error has occurred',
          onRetry: onRetry,
          error: error,
        );
        break;
      case PageState.noData:
        if (noDataBuilder != null)
          pageBody = Builder(builder: noDataBuilder);
        else if (noDataMessage != null) pageBody = NoData(noDataMessage);
        break;
    }

    return pageBody;
  }
}
