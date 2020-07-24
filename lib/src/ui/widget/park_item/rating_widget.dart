/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../rating.dart';

class Rating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: StarRating(
                          // size: 20,
                          color: Colors.yellow[600],
                          rating: double.parse(widget.document.data['rating']),
                          onRatingChanged: (rating) =>
                              //setState(() => this.rating = rating),

                              provider.updateRatingStars(rating.toString(),
                                  widget.document.data['id'])),
                    ),
  }

}*/