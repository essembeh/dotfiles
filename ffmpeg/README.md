# Rotate video without reencoding

```sh
ffmpeg -i input.mp4 -c copy -metadata:s:v:0 rotate=90 output.mp4
```

# Create a 16:9 from a video with blured fill

```sh
ffmpeg -i input.mp4 \
   -filter_complex '[0:v]scale=ih*16/9:-1,boxblur=luma_radius=min(h\,w)/20:luma_power=1:chroma_radius=min(cw\,ch)/20:chroma_power=1[bg];[bg][0:v]overlay=(W-w)/2:(H-h)/2,crop=h=iw*9/16' \
   output.mp4
```
