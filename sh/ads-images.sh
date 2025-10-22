OUT_DIR="/home/${USER}/k/kishore/business/registrationform/public/assets/images/ads"

IMAGE_SIZE="500x70"
POINTSIZE="42"
TEXT_WITH_COORDS_01="text 20,30 'BIZ FORMS'"
TEXT_WITH_COORDS_02="text 20,30 'CUSTOMIZABLE'"
TEXT_WITH_COORDS_03="text 20,30 'EASY TO USE'"

convert -size $IMAGE_SIZE xc:transparent -font Bookman-DemiItalic -pointsize $POINTSIZE -draw "$TEXT_WITH_COORDS_01" \
-fill darkred -stroke magenta -draw "$TEXT_WITH_COORDS_01" "$OUT_DIR/01.png"

convert -size $IMAGE_SIZE xc:transparent -font Bookman-DemiItalic -pointsize $POINTSIZE -draw "$TEXT_WITH_COORDS_02" \
-fill darkred -stroke magenta -draw "$TEXT_WITH_COORDS_02" "$OUT_DIR/02.png"

convert -size $IMAGE_SIZE xc:transparent -font Bookman-DemiItalic -pointsize $POINTSIZE -draw "$TEXT_WITH_COORDS_03" \
-fill darkred -stroke magenta -draw "$TEXT_WITH_COORDS_03" "$OUT_DIR/03.png"
