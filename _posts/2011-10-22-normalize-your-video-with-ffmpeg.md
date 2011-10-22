---
layout: post
title: Normalize your video with FFmpeg
---

<h2>
  {{ page.title }}
</h2>

<h3>22 October 2011</h3>

It's been a while since I've updated my blog. I didn't encounter any weird things until last week.

At Movideo, we've been haunted by videos that goes out of sync with it's audio.
The symptom goes something like this:

1. Plays a dynamic bitrate video that was encoded using Movideo's Encoder application.
2. In the beginning, audio and video is in sync.
3. A crackling noise appeared and then the audio and video goes out of sync.

We've decided to use <a href="http://www.mplayerhq.hu/DOCS/HTML/en/mencoder.html">MEncoder</a> to normalize
the original video which is in .mov format.

The command 
{% highlight bash %}
mencoder -ovc copy -af volnorm=1 -oac libmp3lame input.mov -o output.mov
{% endhighlight %}
creates a mov file
which Quick Time won't recognize at all. Tried viewing it with Windows Media Player and there's audio but no video.
After that, I upload the video via Movideo's Admin interface. The re-encoded video still goes out of sync.

The solution to this is to re-encode the audio with FFmpeg with 
{% highlight bash %}
ffmpeg -i input.mov -vcodec copy -acodec libmp3lame output.mov
{% endhighlight %}
Now, output.mov can be viewed by Quick Time and works fine on Windows Media Player.
Then, I tried uploading the output.mov via Movideo's Admin interface and the video doesn't go out of sync anymore.
