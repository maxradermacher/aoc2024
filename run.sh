#!/bin/sh

for day in day??; do
	echo "building $day..."
	cd "$day"
	swift build -c release
	./.build/release/"$day" > /dev/null
	cd ..
	echo
done

time (
	for day in day??; do
		cd "$day"
		echo "$day:"
		./.build/release/"$day"
		cd ..
		echo
	done
)
