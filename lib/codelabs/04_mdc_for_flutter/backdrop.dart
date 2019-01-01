import 'package:flutter/material.dart';
import 'package:flutter_app/codelabs/04_mdc_for_flutter/login_page.dart';
import 'package:flutter_app/codelabs/04_mdc_for_flutter/model/product.dart';

// Add velocity constant
const double _kFlingVelocity = 2.0;

/// Builds a Backdrop.
///
/// A Backdrop widget has two layers, front and back. The front layer is shown
/// by default, and slides down to show the back layer, from which a user
/// can make a selection. The user can also configure the titles for when the
/// front or back layer is showing.
class Backdrop extends StatefulWidget {
  final Category currentCategory;
  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontTitle;
  final Widget backTitle;

  const Backdrop({
    @required this.currentCategory,
    @required this.frontLayer,
    @required this.backLayer,
    @required this.frontTitle,
    @required this.backTitle,
  })  : assert(currentCategory != null),
        assert(frontLayer != null),
        assert(backLayer != null),
        assert(frontTitle != null),
        assert(backTitle != null);

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop> with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  AnimationController _controller;

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double layerTitleHeight = 48.0;
    final Size layerSize = constraints.biggest;
    final double layerTop = layerSize.height - layerTitleHeight;

    // Create a RelativeRectTween Animation
    Animation<RelativeRect> layerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(
          0.0, layerTop, 0.0, layerTop - layerSize.height),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_controller.view); // todo weiyi what's meaning of controller.view?

    // A Stack's children can overlap. Each child's size and location is specified relative to the Stack's parent.
    return Stack(
      key: _backdropKey,
      children: <Widget>[
        // Wrap backLayer in an ExcludeSemantics widget
        // This widget will exclude the backLayer's menu items from the semantics tree when the back layer isn't visible.
        ExcludeSemantics(
          child: widget.backLayer,
          excluding: _frontLayerVisible,
        ),
        // Add a PositionedTransition
        PositionedTransition(
          rect: layerAnimation,
          child: _FrontLayer(
            // Implement onTap property on _BackdropState
            onTap: _toggleBackdropLayerVisibility,
            // Wrap the front layer in _FrontLayer
            child: widget.frontLayer,
          ),
        ),
      ],
    );
  }

  // note21: The widget lifecycle
  // The initState() method is only called once, before the widget is part of its render tree.
  // The dispose() method is also only called once, when the widget is removed from its tree for good.
  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Called whenever the widget configuration changes.
  // Override this method to respond when the [widget] changes (e.g., to start implicit animations).
  // because [_ShrineAppState._onCategoryTap] was called to set [this.currentCategory]
  @override
  void didUpdateWidget(Backdrop old) {
    super.didUpdateWidget(old);

    if (widget.currentCategory != old.currentCategory) {
      _toggleBackdropLayerVisibility();
    } else if (!_frontLayerVisible) {
      _controller.fling(velocity: _kFlingVelocity);
    }
  }

  // Add functions to get and change front layer visibility
  bool get _frontLayerVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed || status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
    _controller.fling(
        velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity
    );
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      brightness: Brightness.light,
      elevation: 0.0,
      titleSpacing: 0.0,
      // Create title with _BackdropTitle parameter. and remove the leading property in the AppBar builder.
      // Removal is necessary for the custom branded icon to be rendered in the original leading widget's place
      /*
      note21:
> Flutter's "everything is a widget" architecture allows the layout of the default AppBar to be altered without having to create an entirely new custom AppBar widget. The title parameter, which is originally a Text widget, can be replaced with a more complex _BackdropTitle. Since the _BackdropTitle also includes the custom icon, it takes the place of the leading property, which can be now be omitted. This simple widget substitution is accomplished without changing any of the other parameters, such as the action icons, which continue to function on their own.
> https://codelabs.developers.google.com/codelabs/mdc-104-flutter/#7
       */
      title: _BackdropTitle(
        listenable: _controller.view,
        onPress: _toggleBackdropLayerVisibility,
        frontTitle: widget.frontTitle,
        backTitle: widget.backTitle,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            semanticLabel: 'search',
          ),
          onPressed: () {
          },
        ),
        IconButton(
          icon: Icon(
            Icons.tune,
            semanticLabel: 'filter',
          ),
          onPressed: () {
          },
        ),
        IconButton(
          icon: Icon(
            Icons.account_circle,
            semanticLabel: 'login',
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
            );
          },
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      // Return a LayoutBuilder widget.
      // LayoutBuilder is used when a widget must know its parent widget's size in order to lay itself out (and the parent size does not depend on the child.)
      body: LayoutBuilder(builder: _buildStack),
    );
  }
}

/*
note21:
 Add shape: style the front layer to add a cut in the upper left corner.
 Add a GestureDetector to detect the tap event.
todo weiyi add a drap detector?
 */
class _FrontLayer extends StatelessWidget {
  const _FrontLayer({
    Key key,
    this.onTap,
    this.child,
  }) : super(key: key);

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16.0,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(46.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Add a GestureDetector
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Container(
              height: 40.0,
              alignment: AlignmentDirectional.centerStart,
            ),
          ),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}

/// The _BackdropTitle is a custom widget that will replace the plain Text widget for the AppBar widget's title parameter.
/// It has an animated menu icon and animated transitions between the front title and back title.
/// todo weiyi 看不懂！仅仅是2个 icon 和 1个 text 就这么复杂的代码？
class _BackdropTitle extends AnimatedWidget {
  final Function onPress;
  final Widget frontTitle;
  final Widget backTitle;

  const _BackdropTitle({
    Key key,
    Listenable listenable,
    this.onPress,
    @required this.frontTitle,
    @required this.backTitle,
  })  : assert(frontTitle != null),
        assert(backTitle != null),
        super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = this.listenable;

    return DefaultTextStyle(
      style: Theme.of(context).primaryTextTheme.title,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      child: Row(children: <Widget>[
        // branded icon
        // SizedBox in order to make room for the horizontal icon motion
        SizedBox(
          width: 72.0,
          child: IconButton(
            padding: EdgeInsets.only(right: 8.0),
            onPressed: this.onPress,
            // It contains a Stack of animated icons:
            icon: Stack(children: <Widget>[
              Opacity(
                opacity: animation.value, // todo weiyi opacity == visibility ?
                child: ImageIcon(AssetImage('assets/images/slanted_menu.png')),
              ),
              FractionalTranslation(
                translation: Tween<Offset>(
                  begin: Offset.zero,
                  end: Offset(1.0, 0.0),
                ).evaluate(animation),
                child: ImageIcon(AssetImage('assets/images/diamond.png')),
              )]),
          ),
        ),
        // Here, we do a custom cross fade between backTitle and frontTitle.
        // This makes a smooth animation between the two texts.
        Stack(
          children: <Widget>[
            Opacity(
              opacity: CurvedAnimation(
                parent: ReverseAnimation(animation),
                curve: Interval(0.5, 1.0),
              ).value,
              child: FractionalTranslation(
                translation: Tween<Offset>(
                  begin: Offset.zero,
                  end: Offset(0.5, 0.0),
                ).evaluate(animation),
                child: backTitle,
              ),
            ),
            Opacity(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Interval(0.5, 1.0),
              ).value,
              child: FractionalTranslation(
                translation: Tween<Offset>(
                  begin: Offset(-0.25, 0.0),
                  end: Offset.zero,
                ).evaluate(animation),
                child: frontTitle,
              ),
            ),
          ],
        )
      ]),
    );
  }
}
