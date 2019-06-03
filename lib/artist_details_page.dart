import 'package:blurry_artist_details_page/models.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ArtistDetailsPage extends StatelessWidget {
  ArtistDetailsPage(this.artist);
  final Artist artist;

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildAvatar(),
          _buildInfo(),
          _buildVideoScroller(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      margin: EdgeInsets.only(top: 32, left: 16),
      padding: EdgeInsets.all(3.0),
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white30,
        ),
      ),
      child: ClipOval(
        child: Image.asset(artist.avatar),
      ),
    );
  }

  Widget _buildInfo() {
    return Container();
  }

  Widget _buildVideoScroller() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            artist.backdropPhoto,
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: _buildContent(),
            ),
          )
        ],
      ),
    );
  }
}
