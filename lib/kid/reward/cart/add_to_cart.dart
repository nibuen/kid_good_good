import 'package:flutter/material.dart';
import 'package:kid_good_good/kid/constants.dart';
import 'package:kid_good_good/kid/kid.dart';

import '../reward.dart';

class AddToCart extends StatelessWidget {
  const AddToCart({
    Key? key,
    required this.reward,
    required this.kid,
  }) : super(key: key);

  final Reward reward;
  final Kid kid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: FractionallySizedBox(
        heightFactor: .7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "${reward.name}",
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              "${reward.cost} Points",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Divider(),
            Text(
                "${kid.points} - ${reward.cost} = ${kid.points - reward.cost}"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(thickness: 6),
            ),
            Row(
              children: <Widget>[
                // TODO add cart
                // Container(
                //   margin: const EdgeInsets.only(right: kDefaultPaddin),
                //   height: 50,
                //   width: 58,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(18),
                //     border: Border.all(
                //       color: reward.color,
                //     ),
                //   ),
                //   child: IconButton(
                //     icon: SvgPicture.asset(
                //       "assets/icons/add_to_cart.svg",
                //       color: reward.color,
                //     ),
                //     onPressed: () {},
                //   ),
                // ),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(18)),
                        backgroundColor:
                            MaterialStateProperty.all(reward.color),
                      ),
                      onPressed: () {
                        if (!kid.claimReward(reward)) {
                          // TODO show error if couldn't claim
                        } else {
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "Buy  Now".toUpperCase(),
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
