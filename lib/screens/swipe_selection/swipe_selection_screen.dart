import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pbl5/locator_config.dart';
import 'package:pbl5/models/user/user.dart';
import 'package:pbl5/screens/base/base_view.dart';
import 'package:pbl5/screens/swipe_selection/card/card.dart';
import 'package:pbl5/view_models/swipe_selection_view_model.dart';
import 'package:provider/provider.dart';

class SwipeSelectionScreen extends StatefulWidget {
  const SwipeSelectionScreen({super.key});

  @override
  State<SwipeSelectionScreen> createState() => _SwipeSelectionScreenState();
}

class _SwipeSelectionScreenState extends State<SwipeSelectionScreen> {
  late SwipeSelectionViewModel viewModel;
  final CardSwiperController cardSwiperController = CardSwiperController();

  // final exampleCards = candidates.map(ExampleCard.new).toList();
  List<Widget> cards = [];

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
          final users = context.select<SwipeSelectionViewModel, List<User>?>(
              (viewModel) => viewModel.users?.data);
          if (users != null) {
            cards = users.map((user) => UserCard(user: user)).toList();
          }
          return cards.isEmpty
              ? Center(child: Container())
              : Column(
                  children: [
                    Flexible(
                      child: CardSwiper(
                        controller: cardSwiperController,
                        cardsCount: cards.length,
                        onSwipe: _onSwipe,
                        onUndo: _onUndo,
                        allowedSwipeDirection: AllowedSwipeDirection.symmetric(
                          horizontal: true,
                          vertical: false,
                        ),
                        onEnd: () {
                          cardSwiperController.moveTo(cards.length - 1);
                        },
                        numberOfCardsDisplayed: 3,
                        isLoop: false,
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
                    SizedBox(
                      height: 110.h,
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(bottom: 80.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       ElevatedButton(
                    //         onPressed: () {
                    //           viewModel.getRecommendedCompanies().then((_) {
                    //             debugPrint(
                    //                 'Companies k null: ${viewModel.users}');
                    //             setState(() {
                    //               cards = users!
                    //                   .map((user) => UserCard(user:user))
                    //                   .toList();
                    //               cardSwiperController.moveTo(0);
                    //             });
                    //           });
                    //         },
                    //         child: const Icon(Icons.ac_unit),
                    //       ),
                    //       ElevatedButton(
                    //         onPressed: cardSwiperController.undo,
                    //         child: const Icon(Icons.rotate_left),
                    //       ),
                    //       ElevatedButton(
                    //         onPressed: () => cardSwiperController
                    //             .swipe(CardSwiperDirection.left),
                    //         child: const Icon(Icons.keyboard_arrow_left),
                    //       ),
                    //       ElevatedButton(
                    //         onPressed: () => cardSwiperController
                    //             .swipe(CardSwiperDirection.right),
                    //         child: const Icon(Icons.keyboard_arrow_right),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
        'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top');
    if (currentIndex != null && cards.length - currentIndex == 10) {
      viewModel.getRecommendedCompanies(
          page: viewModel.users!.paging!.nextPage);
    }
    if (direction == CardSwiperDirection.right) {
      debugPrint('Swiped right' +
          viewModel.users!.data![previousIndex].firstName.toString());
      viewModel.requestMatchedPair(
        userId: viewModel.users!.data![previousIndex].id,
        onSuccess: () {},
        onFailure: (e) {},
      );
    }

    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $currentIndex was undo from the ${direction.name}',
    );
    return true;
  }
}
