# from GH pull
# Copyright (c) 2019 Alexander Medvednikov. All rights reserved.
# Use of this source code is governed by an MIT license
# that can be found in the LICENSE file.

#-std=c11
CC=cc -w

all: v vc

v: vc
	./vc -o v .

vc: v.c
	$(CC) -o vc v.c
win: v.c
	$(CC) -Dwindows -o vc v.c -g
	$(MAKE) v

v.c:
	wget https://vlang.io/v.c

clean:
	-rm v vc v.c
