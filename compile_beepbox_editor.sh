#!/bin/bash

# Compile ts/SongEditor.ts into beepbox_editor.js
tsc

# Minify beepbox_editor.js into beepbox_editor.min.js
uglifyjs \
	--compress \
	--mangle \
	--mangle-props regex="/^_.+/;" \
	website/beepbox_editor.js \
	-o website/beepbox_editor.min.js

# Combine the html and js into a single file for the offline version
sed \
	-e '/INSERT_BEEPBOX_SOURCE_HERE/{r website/beepbox_editor.min.js' -e 'd' -e '}' \
	website/beepbox_offline_template.html \
	> website/beepbox_offline.html
