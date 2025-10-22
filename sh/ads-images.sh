OUT_DIR="/home/${USER}/k/kishore/business/registrationform/public/assets/images/ads"

IMAGE_SIZE="500x70"
POINTSIZE="28"
TEXT_WITH_COORDS_01="text 10,20 'B I Z  F O R M S'"
TEXT_WITH_COORDS_02="text 10,20 'C U S T O M I Z A B L E'"
TEXT_WITH_COORDS_03="text 10,20 'E A S Y  T O  U S E'"
TEXT_WITH_COORDS_04="text 10,20 'A B C D E F G H I J K L M N O P'"
TEXT_WITH_COORDS_05="text 10,20 '0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5'"

convert -size $IMAGE_SIZE xc:transparent -font Bookman-DemiItalic -pointsize $POINTSIZE -draw "$TEXT_WITH_COORDS_01" \
-fill darkred -stroke magenta -draw "$TEXT_WITH_COORDS_01" "$OUT_DIR/01.png"

convert -size $IMAGE_SIZE xc:transparent -font Bookman-DemiItalic -pointsize $POINTSIZE -draw "$TEXT_WITH_COORDS_02" \
-fill darkred -stroke magenta -draw "$TEXT_WITH_COORDS_02" "$OUT_DIR/02.png"

convert -size $IMAGE_SIZE xc:transparent -font Bookman-DemiItalic -pointsize $POINTSIZE -draw "$TEXT_WITH_COORDS_03" \
-fill darkred -stroke magenta -draw "$TEXT_WITH_COORDS_03" "$OUT_DIR/03.png"

convert -size $IMAGE_SIZE xc:transparent -font Bookman-DemiItalic -pointsize $POINTSIZE -draw "$TEXT_WITH_COORDS_04" \
-fill darkred -stroke magenta -draw "$TEXT_WITH_COORDS_04" "$OUT_DIR/04.png"

convert -size $IMAGE_SIZE xc:transparent -font Bookman-DemiItalic -pointsize $POINTSIZE -draw "$TEXT_WITH_COORDS_05" \
-fill darkred -stroke magenta -draw "$TEXT_WITH_COORDS_05" "$OUT_DIR/05.png"
