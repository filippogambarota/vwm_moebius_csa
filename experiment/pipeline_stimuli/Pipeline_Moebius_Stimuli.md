---
title: Pipeline Moebius Stimuli
author: Filippo Gambarota
---

# Videos

Movies were taken from the [MMI Database](https://mmifacedb.eu/). In particular this is the specific collection [https://mmifacedb.eu/view_collection/videos-emotional-label](https://mmifacedb.eu/view_collection/videos-emotional-label).

## Female

* Anger: folder `Sessions/100`
* Fear: folder `Sessions/107`
* Happiness: `Sessions/109`

## Male

* Anger: folder `Sessions/1809`
* Fear: folder `Sessions/1814`
* Happiness: `Sessions/1816`

# Frames Extraction

I have extracted frames with [ffmpeg](https://ffmpeg.org) using the command:
```
ffmpeg -i inputvideo.avi -r 25 -start_number 0 %1d.png
```

Every videos have the same **framerate** of `25 frames/second` so with this command all possible frames are extracted.

Starting from the male images that is fullscreen, the ratio between **Height and Width** has been calculated for making the female picture as similar as possible. However, resolution is different so male images are higher in resolution. Male ratio has been calculated with [this website](https://eikhart.com/blog/aspect-ratio-calculator) and is `0.774468085106383 : 1` 

* Female images have been cropped keeping the same ratio with a final dimension of: `w = 314; h = 405 px`.
* Male images dimensions are: `w = 546; h = 705 px`.

## Female

Female videos have a **resolution** of `720 x 576 px`. I have cropped extracted frames with [ImageMagick](https://imagemagick.org/index.php) using the command:

```
magick mogrify -crop 314x405+384+153 *.png
```

### Anger

Selected images from the entire pool of frames are: **5 7 8 9 11 12 13 15**. Images have been cropped using the following command:
```
magick mogrify -crop 314x405+384+153 *.png
```

### Fear

Both fear videos are appropriate and images have been cropped using the following command:

```
magick mogrify -crop 314x405+384+153 *.png
```

#### Fear 1

Selected images are **6 10 12 14 16 19 21 27**.

#### Fear 2 (selected)

Selected images are **0 14 16 18 20 22 24 28**.

### Happiness

Selected images are **30 38 41 42 43 44 45 47**. 

Happy images have been cropped using the following command:

```
magick mogrify -crop 314x405+370+153 *.png
```

## Male

### Anger

Selected images are **2 4 6 7 8 9 10 12 15** and cropping command is the following:

```
magick mogrify -crop 546x705+30+15 *.png
```

### Fear

Selected images are **7 10 12 14 16 20 22 25** and cropping command is the following:

```
magick mogrify -crop 546x705+10+15 *.png
```

### Happiness

Selected images are **0 10 12 17 22 23 24 28** and cropping command is the following:

```
magick mogrify -crop 546x705+0+15 *.png
```

# Oval Cropping

The dimension of the **oval** is the same between male and female `247x300`. The position `x and y values` is the same within the same emotion-gender but is different between emotion and gender.

The oval crop is made with **MATLAB R2019b** and the `Cropping_Faces_Script.m` script.

## Male

Male images are `546x705`. For pairing with female images I cropped to `314x405`.

Images are cropped with this command (imagemagick):

```
magick mogrify -resize 314x405 -quality 100 -interpolate 'bilinear' *.png
```

### Anger

Oval cropping coordinates are `x = 33; y = 46`

### Fear

Oval cropping coordinates are `x = 32; y = 43`

### Happiness

Oval cropping coordinates are `x = 31; y = 47`


## Female

Female images are the reference point so the final dimension before cropping is `314x405`.

### Anger

Oval cropping coordinates are `x = 35; y = 50`

### Fear

Oval cropping coordinates are `x = 32; y = 52`

### Happiness

Oval cropping coordinates are `x = 39; y = 55`


# Oval final crop

The oval has been finally cropped `254x306` for reducing the trasparent background. Given the centre of the face the rectangular crop has been made having the same lenght outside each border of the image.

## Male

### Anger

Cropping coordinates are `x = 29; y = 43`.

### Fear

Oval cropping coordinates are `x = 28; y = 40`

### Happiness

Oval cropping coordinates are `x = 27; y = 44`

## Female

### Anger

Oval cropping coordinates are `x = 31; y = 47`

### Fear

Oval cropping coordinates are `x = 29; y = 49`

### Happiness

Oval cropping coordinates are `x = 36; y = 52`


# E-Prime Resizing

For the E-Prime script final images are resized `130x157` with the following command:

```
magick mogrify -resize 130x157 -quality 100 -interpolate 'bilinear' *.png
```

The slide object of E-Prime require both the percentage of the single frame and the position (in percentage) on the **x** and **y** axes.

* `Width = 15%; Height = 25%`
* Position within the slide are:

# Adjusting the luminance

For using these stimuli in the PC a luminance adjustment is required. For both male and female images the luminance is reduce at 65% with the following command:

```
 magick mogrify -modulate 65,100,100 *.png
```