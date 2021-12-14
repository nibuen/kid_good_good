import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kid_good_good/kid/reward/cart/add_to_cart.dart';
import 'package:kid_good_good/kid/reward/reward.dart';
import 'package:kid_good_good/widgets/loading_image.dart';

import '../../app_bar.dart';
import '../kid.dart';

class RewardsPage extends StatefulWidget {
  const RewardsPage({
    Key? key,
    required this.title,
    required this.kid,
  }) : super(key: key);

  final String title;
  final Kid kid;

  @override
  _RewardsPageState createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UserAppBar(title: widget.title),
      body: Column(
        children: [
          Expanded(
            child: GridView.extent(
              maxCrossAxisExtent: 280,
              padding: const EdgeInsets.all(24),
              children: [
                _RewardCard(
                  Reward(
                    cost: 60,
                    name: "Candy Bar",
                    imageUrl:
                        "https://m.media-amazon.com/images/I/91hNjiwP8kL._SL1500_.jpg",
                  ),
                  kid: widget.kid,
                ),
                _RewardCard(
                  Reward(
                    cost: 60,
                    name: "Soda",
                    imageUrl:
                        "https://images.heb.com/is/image/HEBGrocery/000539118?fit=constrain,1&wid=800&hei=800&fmt=jpg&qlt=85,0&resMode=sharp2&op_usm=1.75,0.3,2,0",
                  ),
                  kid: widget.kid,
                ),
                _RewardCard(
                  Reward(
                    cost: 100,
                    name: "\$5 Roblux",
                    imageUrl:
                        "https://pbs.twimg.com/profile_images/1131599526001692672/D40KVhLQ.png",
                  ),
                  kid: widget.kid,
                ),
                _RewardCard(
                  Reward(
                    cost: 350,
                    name: "Pizza Party",
                    imageUrl:
                        "https://d14peyhpiu05bf.cloudfront.net/uploads/2019/12/Pizza-partyFT.jpg",
                  ),
                  kid: widget.kid,
                ),
                _RewardCard(
                  Reward(
                    cost: 1000,
                    name: "Computer Upgrade",
                    imageUrl:
                        "https://m.media-amazon.com/images/I/819XYUimTuL._AC_SL1500_.jpg",
                  ),
                  kid: widget.kid,
                ),
                _RewardCard(
                  Reward(
                    cost: 4000,
                    name: "Snowboard",
                    imageUrl:
                        "https://cdn.shopify.com/s/files/1/0370/3986/5987/products/BATALEON-SNOWBOARDS-ENVIRONMENT-MAGIC-CARPET-1_1024x1024.jpg?v=1604485712",
                  ),
                  kid: widget.kid,
                ),
                _RewardCard(
                  Reward(
                    cost: 6000,
                    name: "Bike",
                    imageUrl:
                        "https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1606749953-yoji16-neongreen-1606749936.png",
                  ),
                  kid: widget.kid,
                ),
                _RewardCard(
                  Reward(
                    cost: 1000000,
                    name: "Kitten",
                    imageUrl:
                        "https://thumbs.dreamstime.com/b/baby-cat-ginger-kitten-sleeping-under-blanket-couch-knitted-two-cats-cuddling-hugging-domestic-animal-sleep-cozy-nap-time-155641371.jpg",
                  ),
                  kid: widget.kid,
                ),
              ],
            ),
          ),
          //AddToCart(reward: Reward()),
        ],
      ),
    );
  }
}

class _RewardCard extends ConsumerWidget {
  const _RewardCard(
    this.reward, {
    required this.kid,
    Key? key,
  }) : super(key: key);

  final Kid kid;

  final Reward reward;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: AddToCart(
              reward: reward,
              kid: kid,
              kidRepository: ref.read(repositoryProvider),
            ),
          );
        },
      ),
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 3,
        child: Stack(
          children: [
            if (reward.imageUrl != null)
              Positioned.fill(
                child: LoadingImage(url: reward.imageUrl!),
              ),
            Positioned.fill(
              child: Card(
                margin: EdgeInsets.all(8),
                color: Colors.black26,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      reward.name,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "${reward.cost} Points",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
