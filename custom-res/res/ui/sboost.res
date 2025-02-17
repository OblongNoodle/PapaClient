Haven Resource 1 src �  BoostMeter.java /* Preprocessed source code */
package haven.res.ui.sboost;

import haven.*;
import java.awt.Color;

public abstract class BoostMeter extends Widget {
    public static final int N = 8;
    public static final double st = 0.5;
    private int rlvl;
    private Text rmeter;

    public BoostMeter(Coord sz) {
	super(sz);
    }

    public abstract int level();

    public void draw(GOut g) {
	int lvl = level();
	if((rmeter == null) || (lvl != rlvl))
	    rmeter = Text.render(String.format("%.1f\u00d7", ((rlvl = lvl) * st) + 1));
	g.chcolor(0, 0, 0, 255);
	g.frect(Coord.z, sz);

	g.chcolor(24, 48, 24, 255);
	g.frect2(new Coord(1, 1), new Coord(sz.x / 2, sz.y - 1));
	g.chcolor(48, 24, 24, 255);
	g.frect2(new Coord(sz.x / 2, 1), new Coord(sz.x - 1, sz.y - 1));

	if(lvl > 0) {
	    g.chcolor(128, 0, 0, 255);
	    g.frect(new Coord(1, 1), new Coord(((sz.x - 2) * lvl) / N, sz.y - 2));
	}

	g.chcolor(192, 192, 192, 255);
	for(int i = 0; i <= N; i++) {
	    int h = UI.scale((((i * st) - (int)(i * st)) == 0) ? 3 : 2);
	    int x = 1 + ((sz.x - 3) * i) / N;
	    g.line(new Coord(x, 1), new Coord(x, 1 + h), 1);
	    g.line(new Coord(x, sz.y - 2), new Coord(x, sz.y - 2 - h), 1);
	}

	g.chcolor();
	g.aimage(rmeter.tex(), sz.div(2), 0.5, 0.5);
    }
}
code 7  haven.res.ui.sboost.BoostMeter ����   4 v
  1
  2	  3	  4 5 6 7?�      
 8 9
 : ;
 < =
 > ?	  @	  A
 > B C
  D	  E	  F
 > G
 H I
 > J
 > K
 < L
  M
 > N O N I ConstantValue    st D rlvl rmeter Lhaven/Text; <init> (Lhaven/Coord;)V Code LineNumberTable level ()I draw (Lhaven/GOut;)V StackMapTable 
SourceFile BoostMeter.java & ' * + $ % #  %.1f× java/lang/Object haven/res/ui/sboost/BoostMeter P Q R S T U V W [ \ ] ^ _ ` a ` b c haven/Coord & d e  f  g c h i j k l ] m n o p q r s haven/Widget java/lang/Double valueOf (D)Ljava/lang/Double; java/lang/String format 9(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String; 
haven/Text render t Line InnerClasses %(Ljava/lang/String;)Lhaven/Text$Line; 
haven/GOut chcolor (IIII)V z Lhaven/Coord; sz frect (Lhaven/Coord;Lhaven/Coord;)V (II)V x y frect2 haven/UI scale (I)I line (Lhaven/Coord;Lhaven/Coord;D)V ()V tex ()Lhaven/Tex; div (I)Lhaven/Coord; aimage (Lhaven/Tex;Lhaven/Coord;DD)V haven/Text$Line sboost.cjava!                 ! "        #     $ %     & '  (   "     *+� �    )   
       * +    , -  (  / 	   �*� =*� � *� � &*� Y*Z� � kc� 
S� � � + �� +� *� � +0 �� +� Y� � Y*� � l*� � d� � +0 �� +� Y*� � l� � Y*� � d*� � d� � � :+ � �� +� Y� � Y*� � dhl*� � d� � + � � � �� >� �� k� k��g�� � � 6*� � dhl`6+� Y� � Y`� � +� Y*� � d� � Y*� � dd� � ���+� +*� � *� �   � �    .    � "� �� @� d )   Z         7  A  L  Y    �  �  �  �   � # $ %+ &= 'Y (� $� +� ,� -  /    u Z   
  X < Y 	codeentry     