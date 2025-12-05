// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../resources/all.dart';
import '../../../resources/generated/assets.gen.dart';
import '../../../resources/generated/colors.gen.dart';

class BasicLayout extends StatelessWidget {
  const BasicLayout({
    super.key,
    this.scaffoldKey,
    this.child,
    this.headerVisible = false,
    this.headerLeading,
    this.headerActions,
    this.title,
    this.centerTitle = true,
    this.padding,
    this.automaticallyImplyLeading = false,
    this.appBar,
    this.color,
    this.appBarColor,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.darkMode = false,
    this.safeTopPadding = true,
    this.safeBottomPadding = true,
    this.builder,
    this.resizeToAvoidBottomInset = false,
    this.extendBodyBehindAppBar = false,
    this.extendBody = false,
    this.isDialog = false,
    this.iconSize,
    this.bottomBarAutoScroll = false,
    this.elevation,
    this.endDrawer,
    this.drawer,
    this.onDrawerChange,
    this.canPop = true,
    this.onPopInvokedWithResult,
    this.maintainBottomViewPadding = true,
  }) : assert(child != null);
  final Widget Function(BuildContext scaffoldContext)? builder;

  static const defaultPadding = EdgeInsets.fromLTRB(
    1 * AppDimension.defaultPadding,
    0,
    1 * AppDimension.defaultPadding,
    1 * AppDimension.defaultPadding,
  );

  final Key? scaffoldKey;
  final bool isDialog;
  final bool safeTopPadding;
  final bool safeBottomPadding;
  final PreferredSizeWidget? appBar;
  final bool automaticallyImplyLeading;
  final Widget? bottomNavigationBar;
  final Widget? child;
  final Color? color;
  final Color? appBarColor;
  final bool extendBodyBehindAppBar;
  final List<Widget>? headerActions;
  final Widget? headerLeading;
  final bool headerVisible;
  final EdgeInsets? padding;
  final Widget? title;
  final bool centerTitle;
  final Widget? floatingActionButton;
  final bool darkMode;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool resizeToAvoidBottomInset;
  final bool extendBody;
  final double? iconSize;
  final double? elevation;
  final Widget? endDrawer;
  final Widget? drawer;
  final Function(bool valuevalue)? onDrawerChange;
  final PopInvokedWithResultCallback? onPopInvokedWithResult;
  final bool canPop;
  final bool maintainBottomViewPadding;

  double get defaultIconSize => iconSize ?? 24;
  final bool bottomBarAutoScroll;

  @override
  Widget build(BuildContext context) {
    final appBackgroundColor = color ?? ColorName.white;
    return Container(
      color: ColorName.white,
      child: SafeArea(
        top: safeTopPadding,
        bottom: safeBottomPadding,
        maintainBottomViewPadding: maintainBottomViewPadding,
        child: PopScope(
          canPop: canPop,
          onPopInvokedWithResult: onPopInvokedWithResult,
          child: Scaffold(
            key: scaffoldKey,
            extendBodyBehindAppBar: extendBodyBehindAppBar,
            extendBody: extendBody,
            backgroundColor: appBackgroundColor,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            bottomNavigationBar: !bottomBarAutoScroll
                ? bottomNavigationBar
                : null,
            floatingActionButton: floatingActionButton,
            floatingActionButtonLocation: floatingActionButtonLocation,
            drawer: drawer,
            onDrawerChanged: (isOpened) => onDrawerChange?.call(isOpened),
            endDrawer: endDrawer,
            appBar: headerVisible
                ? appBar ??
                      AppBar(
                        automaticallyImplyLeading: automaticallyImplyLeading,
                        leading: headerLeading,
                        actions: headerActions,
                        toolbarHeight: headerVisible ? kToolbarHeight : 0,
                        title: title,
                        centerTitle: centerTitle,
                        backgroundColor: appBarColor,
                        elevation: elevation,
                      )
                : null,
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.images.background.path),
                  fit: BoxFit.fill,
                ),
              ),
              child: bottomBarAutoScroll
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(child: _getBuildMethod(context)),
                        SizedBox(
                          width: double.infinity,
                          child: bottomNavigationBar ?? const SizedBox.shrink(),
                        ),
                      ],
                    )
                  : _getBuildMethod(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getBuildMethod(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.maxFinite,
      padding: padding ?? defaultPadding,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        onTap: () {
          hideKeyBoard(context);
        },
        child: Builder(
          builder: (builderContext) {
            if (builder != null) {
              return builder!(builderContext);
            }
            return child!;
          },
        ),
      ),
    );
  }

  void hideKeyBoard(BuildContext context) {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }
}
