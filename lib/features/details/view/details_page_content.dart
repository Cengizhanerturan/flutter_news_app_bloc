import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/theme/app_colors.dart';
import 'package:flutter_news_app/core/theme/app_padding.dart';
import 'package:flutter_news_app/core/theme/app_spacing.dart';
import 'package:flutter_news_app/core/theme/theme_extension.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/util/extensions/extensions.dart';
import 'package:flutter_news_app/core/util/extensions/navigation_extension.dart';
import 'package:flutter_news_app/data/models/news_model.dart';
import 'package:flutter_news_app/features/details/bloc/details_bloc.dart';
import 'package:flutter_news_app/widget/custom_back_button.dart';
import 'package:flutter_news_app/widget/custom_cached_network_image.dart';
import 'package:flutter_news_app/features/details/widgets/custom_save_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DetailsPageContent extends StatelessWidget {
  final NewsModel? newsModel;
  final bool isFromSavedPage;
  const DetailsPageContent({
    super.key,
    required this.newsModel,
    required this.isFromSavedPage,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _handleBack(context);
      },
      child: Scaffold(body: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (newsModel == null) return SizedBox();
    return SafeArea(
      top: false,
      child: Stack(
        children: [_buildImageArea(context), _buildContentArea(context)],
      ),
    );
  }

  Widget _buildContentArea(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: Device.width,
        height: Device.height * 0.67,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildSourceAndDateArea(context),
            _buildContent(context),
            _buildReadMoreButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildReadMoreButton(BuildContext context) {
    return Container(
      width: Device.width,
      height: 55.px,
      padding: AppPadding.horizontal(AppSpacing.md),
      margin: AppPadding.vertical(AppSpacing.sm),
      child: InkWell(
        onTap: () {
          context.toWebView(newsModel!.url);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.px),
            color: Theme.of(context).primaryColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: SizedBox()),
              Expanded(
                child: Text(
                  StringConstants.READ_MORE_BUTTON_TEXT,
                  style: Theme.of(context).primaryTextTheme.bodyMedium?.semibold
                      .copyWith(color: AppColorsLight.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(child: _buildCircleArrowIcon(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircleArrowIcon(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 50.px,
        height: 50.px,
        margin: AppPadding.only(right: AppSpacing.xs),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Icon(Icons.arrow_forward_ios_rounded, size: 30.px),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      width: Device.width,
      height: Device.height * 0.6 - 65.px,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.px),
          topRight: Radius.circular(30.px),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.horizontal(AppSpacing.md),
          child: Column(
            children: [
              SizedBox(height: 16.px),
              _buildTitleText(context),
              SizedBox(height: 16.px),
              _buildContentText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleText(BuildContext context) {
    return Text(
      newsModel!.title,
      style: Theme.of(context).primaryTextTheme.bodyLarge?.semibold,
    );
  }

  Widget _buildContentText(BuildContext context) {
    return Text(
      newsModel!.content ?? "",
      style: Theme.of(context).primaryTextTheme.bodyMedium?.medium,
    );
  }

  Widget _buildSourceAndDateArea(BuildContext context) {
    return Padding(
      padding: AppPadding.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_buildSource(context), _buildDateText(context)],
      ),
    );
  }

  Widget _buildSource(BuildContext context) {
    return Container(
      padding: AppPadding.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.px),
        color: Theme.of(context).primaryColor,
      ),
      child: Text(
        newsModel!.source.name,
        style: Theme.of(context).primaryTextTheme.bodySmall?.medium.copyWith(
          color: AppColorsLight.white,
        ),
      ),
    );
  }

  Widget _buildDateText(BuildContext context) {
    return Text(
      newsModel!.publishedAt.formattedDate,
      style: Theme.of(context).primaryTextTheme.bodySmall?.medium.copyWith(
        color: AppColorsLight.white,
      ),
    );
  }

  Widget _buildImageArea(BuildContext context) {
    return SizedBox(
      width: Device.width,
      height: Device.height * 0.45,
      child: Stack(
        children: [
          CustomCachedNetworkImage(
            imageUrl: newsModel!.urlToImage,
            width: Device.width,
            height: Device.height * 0.5,
            isBorderRadius: false,
          ),
          _buildImageShadow(),
          _buildBackAndSaveButton(context),
        ],
      ),
    );
  }

  Widget _buildBackAndSaveButton(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomBackButton(onTap: () => _handleBack(context)),
          BlocSelector<DetailsBloc, DetailsState, bool>(
            selector: (state) => state.isSavedNews,
            builder: (context, isSavedNews) {
              return CustomSaveButton(
                isSaved: isSavedNews,
                onTap:
                    () => context.read<DetailsBloc>().add(
                      ToggleSaveStatus(newsModel),
                    ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildImageShadow() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: Device.height * 0.3,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [AppColorsLight.black, Colors.transparent],
          ),
          borderRadius: BorderRadius.circular(10.px),
        ),
      ),
    );
  }

  void _handleBack(BuildContext context) {
    final isSaved = context.read<DetailsBloc>().state.isSavedNews;

    if (isFromSavedPage && isSaved == false) {
      context.back(newsModel);
    } else {
      context.back();
    }
  }
}
