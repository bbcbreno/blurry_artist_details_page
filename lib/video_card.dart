import 'package:blurry_artist_details_page/models.dart';
import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  VideoCard(this.video);
  final Video video;

  BoxDecoration _buildShadowAndRoundedCorners() {
    return BoxDecoration();
  }

  Widget _buildThumbnail() {
    return Placeholder();
  }

  Widget _buildInfo() {
    return Placeholder();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175.0,
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
      decoration: _buildShadowAndRoundedCorners(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 3,
            child: _buildThumbnail(),
          ),
          Flexible(
            flex: 2,
            child: _buildInfo(),
          ),
        ],
      ),
    );
  }
}
