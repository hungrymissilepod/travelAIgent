import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';

/// TODO: should we have the ability for this carousel to autoscroll and also infinitely loop?
/// https://stackoverflow.com/questions/56780188/how-to-automatically-scroll-a-pageview-with-some-delay-that-is-made-without-usin
/// https://pub.dev/packages/loop_page_view
class ImageCarousel extends StatefulWidget {
  const ImageCarousel({
    super.key,
    required this.images,
    this.height = 250,
  });

  final List<String> images;
  final double height;

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> with SingleTickerProviderStateMixin {
  final PageController controller = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() => listenToPage());
  }

  @override
  void dispose() {
    controller.removeListener(() => listenToPage());
    super.dispose();
  }

  void listenToPage() {
    setState(() {
      currentIndex = controller.page!.toInt();
    });
  }

  void decrement() {
    if (currentIndex == 0) return;
    currentIndex--;
    animateToPage(currentIndex);
  }

  void increment() {
    if (currentIndex == widget.images.length - 1) return;
    currentIndex++;
    animateToPage(currentIndex);
  }

  void animateToPage(int index) {
    setState(() {
      controller.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          PageView.builder(
            itemCount: widget.images.length,
            controller: controller,
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: SizedBox(
                  width: double.infinity,

                  /// TODO: add the progressive image builder here to display image thumbail blurred while loading images
                  /// TODO: if we don't like it try using an AnimatedOpacity again because it also achieves a similar effect
                  /// https://stackoverflow.com/questions/71676805/flutter-pageview-swipe-change-background-image-with-animation
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),

                    /// TODO: display correct loading and error states
                    child: CachedNetworkImage(
                      imageUrl: widget.images[index],
                      fit: BoxFit.cover,
                      placeholderFadeInDuration: Duration.zero,
                      fadeInDuration: Duration.zero,
                      placeholder: (context, url) => Center(child: Container()),
                      errorWidget: (context, url, error) {
                        return const Icon(Icons.error);
                      },
                    ),
                  ),
                ),
              );
            },
          ),
          Visibility(
            visible: widget.images.length > 1,
            child: CarouselDirectionButton(
              enabled: currentIndex != 0,
              onTap: () => decrement(),
              icon: FontAwesomeIcons.arrowLeft,
              alignment: Alignment.centerLeft,
            ),
          ),
          Visibility(
            visible: widget.images.length > 1,
            child: CarouselDirectionButton(
              enabled: currentIndex != widget.images.length - 1,
              onTap: () => increment(),
              icon: FontAwesomeIcons.arrowRight,
              alignment: Alignment.centerRight,
            ),
          ),
          widget.images.length > 1
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: widget.images.length,
                      effect: WormEffect(
                        dotColor: Colors.black.withOpacity(0.4),
                        activeDotColor: Colours.accent,
                        dotHeight: 8,
                        dotWidth: 8,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class CarouselDirectionButton extends StatelessWidget {
  const CarouselDirectionButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.alignment,
    required this.enabled,
  });

  final IconData icon;
  final Function() onTap;
  final Alignment alignment;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ClipOval(
          child: Opacity(
            opacity: enabled ? 1.0 : 0.5,
            child: Material(
              color: Colors.black.withOpacity(0.4),
              child: InkWell(
                splashColor: Colours.accent.shade700,
                onTap: () => onTap(),
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: Center(
                    child: FaIcon(
                      icon,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
