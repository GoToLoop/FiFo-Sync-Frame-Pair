/**
 * FiFo Sync Frame Pair (v1.0.1)
 * GoToLoop (2020/Apr/20)
 *
 * Discourse.Processing.org/t/read-from-2-videos-at-the-same-time/19937/4
 * GitHub.com/GoToLoop/FiFo-Sync-Frame-Pair
 */

import processing.video.Movie;

import java.util.Queue;
import java.util.ArrayDeque;

static final String VID_1 = "videoL1.avi", VID_2 = "videoR1.avi";
static final int W = 1024, H = 768, WW = W >> 1, HH = H >> 1;

final Queue<PImage> framesA = new ArrayDeque<PImage>();
final Queue<PImage> framesB = new ArrayDeque<PImage>();

Movie videoA, videoB;

void settings() {
  size(W, HH);
}

void setup() {
  videoA = new Movie(this, VID_1);
  videoB = new Movie(this, VID_2);

  videoA.play();
  videoB.play();
}

void draw() {
  if (framesB.isEmpty() || framesA.isEmpty())  return;

  final PImage frameA = framesA.remove();
  final PImage frameB = framesB.remove();

  set(0, 0, frameA);
  set(WW, 0, frameB);
}

void movieEvent(final Movie m) {
  m.read();

  final PImage frame = m.get();
  frame.resize(WW, HH);

  final Queue<PImage> frames = m == videoA? framesA : framesB;
  frames.add(frame);
}
