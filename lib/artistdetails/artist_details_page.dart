import 'dart:math';
import 'dart:ui' as ui;

import 'package:blurry_artist_details_page/artistdetails/artist_details_animator.dart';
import 'package:blurry_artist_details_page/data/models.dart';
import 'package:blurry_artist_details_page/artistdetails/video_card.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ArtistDetailsPage extends StatelessWidget {
  ArtistDetailsPage({
    @required this.artist,
    @required AnimationController controller,
  }) : animator = new ArtistDetailsAnimator(controller);

  final Artist artist;
  final ArtistDetailsAnimator animator;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Opacity(
          opacity: animator.backdropOpacity.value,
          child: new Image.asset(
            artist.backdropPhoto,
            fit: BoxFit.cover,
          ),
        ),
        new BackdropFilter(
          filter: new ui.ImageFilter.blur(
            sigmaX: animator.backdropBlur.value,
            sigmaY: animator.backdropBlur.value,
          ),
          child: new Container(
            color: Colors.black.withOpacity(0.5),
            child: _buildContent(),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return new SingleChildScrollView(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildAvatar(),
          _buildInfo(),
          _buildVideoScroller(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return new Transform(
      transform: new Matrix4.diagonal3Values(
        animator.avatarSize.value,
        animator.avatarSize.value,
        1.0,
      ),
      alignment: Alignment.center,
      child: new Container(
        width: 110.0,
        height: 110.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          border: new Border.all(color: Colors.white30),
        ),
        margin: const EdgeInsets.only(top: 32.0, left: 16.0),
        padding: const EdgeInsets.all(3.0),
        child: new ClipOval(
          child: new Image.asset(artist.avatar),
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return new Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Opacity(
            opacity: animator.nameOpacity.value,
            child: new Text(
              artist.firstName + '\n' + artist.lastName,
              style: new TextStyle(
                color: Colors.white.withOpacity(animator.nameOpacity.value),
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
          ),
          new Text(
            artist.location,
            style: new TextStyle(
              color: Colors.white.withOpacity(animator.locationOpacity.value),
              fontWeight: FontWeight.w500,
            ),
          ),
          new Container(
            color: Colors.white.withOpacity(0.85),
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            width: animator.dividerWidth.value,
            height: 1.0,
          ),
          new Text(
            artist.biography,
            style: new TextStyle(
              color: Colors.white.withOpacity(animator.biographyOpacity.value),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoScroller() {
    return new Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: new Transform(
        transform: new Matrix4.translationValues(
          animator.videoScrollerXTranslation.value,
          0.0,
          0.0,
        ),
        child: new Opacity(
          opacity: min(1.0, animator.videoScrollerOpacity.value),
          child: new SizedBox.fromSize(
            size: new Size.fromHeight(245.0),
            child: new ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              itemCount: artist.videos.length,
              itemBuilder: (BuildContext context, int index) {
                var video = artist.videos[index];
                return new VideoCard(video);
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new AnimatedBuilder(
        animation: animator.controller,
        builder: _buildAnimation,
      ),
    );
  }
}
