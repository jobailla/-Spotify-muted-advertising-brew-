#!/bin/zsh
while [ 1 ];
do
	spotify_info=`spotify info`;

	spotify_elapsed_seconds=`echo $spotify_info |
	grep 'Seconds played:' | cut -d ':' -f 2 | tr -d ' ' | tr ',' '.'`;
	spotify_elapsed_seconds=`printf "%.*f\n" 1 $spotify_elapsed_seconds`;
	echo 'elapsed: '$spotify_elapsed_seconds;

	spotify_total_seconds=`echo $spotify_info |
	grep 'Seconds:' | cut -d ':' -f 2 | tr -d ' ' | tr ',' '.'`;
	spotify_total_seconds=`printf "%.*f\n" 1 $spotify_total_seconds`;
	echo 'total: '$spotify_total_seconds;

	spotify_current_artist=`echo "$spotify_info" |
	grep 'Artist:' | grep -v 'Album ' | cut -d ':' -f 2- | tr -d ' \n'`;

	spotify_current_album=`echo "$spotify_info" |
	grep 'Album:' | cut -d ':' -f 2- | tr -d ' \n'`;

	echo `echo -n "$spotify_info" | grep 'Track:'`;
	if [ "$spotify_current_artist" = "" ] || [ "$spotify_current_album" = "" ];
	then
		spotify vol 0;
	else
		spotify vol 100;
	fi

	echo 'next evalutaion in: '`printf "%.*f\n" 1 $(($spotify_total_seconds - $spotify_elapsed_seconds + 0.3))`;
	sleep `printf "%.*f\n" 1 $(($spotify_total_seconds - $spotify_elapsed_seconds + 0.3))`;
done
