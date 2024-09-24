# Rotate video without reencoding

```sh
ffmpeg -i input.mp4 \
   -c copy -metadata:s:v:0 rotate=90 \
   output.mp4
```


# Create a 16:9 from a video with blured fill

```sh
ffmpeg -i input.mp4 \
   -filter_complex '[0:v]scale=ih*16/9:-1,boxblur=luma_radius=min(h\,w)/20:luma_power=1:chroma_radius=min(cw\,ch)/20:chroma_power=1[bg];[bg][0:v]overlay=(W-w)/2:(H-h)/2,crop=h=iw*9/16' \
   output.mp4
```


# 10-bit/12-bit HEVC to 8-bit H.264

```sh
ffmpeg -i input.mkv \
   -map 0 -c:v libx264 -crf 18 -vf format=yuv420p -c:a copy \
   output.mkv
```

# Video loop

```sh
ffmpeg -stream_loop 10 \
   -i input.mp4 \
   -c copy \
   output.mp4
```


# Remove audio

```sh
ffmpeg -i input.mp4 \
   -c copy -an \
   output.mp4
```

# iPhone HDR Video to SDR

```sh
ffmpeg -i INPUT.MOV \
    -vf zscale=transfer=linear,tonemap=hable:peak=5,zscale=transfer=bt709,format=yuv420p,colorspace=all=bt709 \
    output.mp4
```
