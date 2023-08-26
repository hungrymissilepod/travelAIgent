import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_aigent/models/duck_web_image_model.dart';
import 'package:travel_aigent/ui/common/app_colors.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({
    super.key,
    required this.images,
    this.height = 250,
  });

  final List<DuckWebImage> images;
  final double height;

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel>
    with SingleTickerProviderStateMixin {
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
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.images[index].image,
                      fit: BoxFit.cover,
                      fadeInDuration: Duration.zero,
                      progressIndicatorBuilder: (BuildContext context,
                          String url, DownloadProgress progress) {
                        return Image(
                          image: NetworkImage(widget.images[index].thumbnail),
                          fit: BoxFit.cover,
                        );
                      },
                      errorWidget: (context, url, error) =>
                          const ImageCarouselError(),
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
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: widget.images.length,
                        effect: WormEffect(
                          dotColor: Colors.black.withOpacity(0.5),
                          activeDotColor: Colours.accent,
                          dotHeight: 8,
                          dotWidth: 8,
                        ),
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

class ImageCarouselError extends StatelessWidget {
  const ImageCarouselError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image(
          image: AssetImage('assets/caution.png'),
          width: 50,
          height: 50,
        ),
        SizedBox(height: 20),
        Text(
          'Failed to load image',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ],
    );
  }
}
