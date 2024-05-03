import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get_it/get_it.dart';
import 'package:pbl5/locator_config.dart';
import 'package:pbl5/screens/base/base_view.dart';
import 'package:pbl5/screens/swipe_selection/card/candidate_model.dart';
import 'package:pbl5/screens/swipe_selection/card/card.dart';
import 'package:pbl5/view_models/profile_view_model.dart';
import 'package:pbl5/view_models/swipe_selection_view_model.dart';

class SwipeSelectionScreen extends StatefulWidget {
  const SwipeSelectionScreen({super.key});

  @override
  State<SwipeSelectionScreen> createState() => _SwipeSelectionScreenState();
}

class _SwipeSelectionScreenState extends State<SwipeSelectionScreen> {
  late SwipeSelectionViewModel viewModel;
  final CardSwiperController controller = CardSwiperController();

  final cards = candidates.map(ExampleCard.new).toList();

  @override
  void initState() {
    viewModel = getIt.get<SwipeSelectionViewModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        canPop: false,
        viewModel: viewModel,
        appBar: AppBar(
          title: const Text(
            'JobSwipe',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              color: Colors.pink,
            ),
          ),
          leading: const SizedBox.shrink(),
          leadingWidth: 0,
        ),
        mobileBuilder: (context) {
          return Column(
            children: [
              Flexible(
                child: CardSwiper(
                  controller: controller,
                  cardsCount: cards.length,
                  onSwipe: _onSwipe,
                  onUndo: _onUndo,
                  allowedSwipeDirection: AllowedSwipeDirection.symmetric(
                    horizontal: true,
                    vertical: false,
                  ),
                  numberOfCardsDisplayed: 3,
                  backCardOffset: const Offset(40, 40),
                  padding: const EdgeInsets.all(24.0),
                  cardBuilder: (
                    context,
                    index,
                    horizontalThresholdPercentage,
                    verticalThresholdPercentage,
                  ) =>
                      cards[index],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: controller.undo,
                      child: const Icon(Icons.rotate_left),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          controller.swipe(CardSwiperDirection.left),
                      child: const Icon(Icons.keyboard_arrow_left),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          controller.swipe(CardSwiperDirection.right),
                      child: const Icon(Icons.keyboard_arrow_right),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $currentIndex was undod from the ${direction.name}',
    );
    return true;
  }
}
