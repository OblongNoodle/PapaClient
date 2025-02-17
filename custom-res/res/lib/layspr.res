Haven Resource 1 src f  Layer.java /* Preprocessed source code */
/* $use: ui/tt/defn */

package haven.res.lib.layspr;

import haven.*;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.util.*;

abstract class Layer {
    final int z;
    final Coord sz;

    Layer(int z, Coord sz) {
	this.z = z;
	this.sz = sz;
    }

    abstract void draw(GOut g);
}

src �  Image.java /* Preprocessed source code */
/* $use: ui/tt/defn */

package haven.res.lib.layspr;

import haven.*;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.util.*;

class Image extends Layer {
    final Resource.Image img;

    Image(Resource.Image img) {
	super(img.z, img.ssz);
	this.img = img;
    }

    void draw(GOut g) {
	g.image(img, Coord.z);
    }
}

src �  Animation.java /* Preprocessed source code */
/* $use: ui/tt/defn */

package haven.res.lib.layspr;

import haven.*;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.util.*;

class Animation extends Layer {
    Resource.Anim a;
    double te, dur;
    int cf;

    static Coord sz(Resource.Anim a) {
	Coord ret = new Coord();
	for(int i = 0; i < a.f.length; i++) {
	    for(int o = 0; o < a.f[i].length; o++) {
		ret.x = Math.max(ret.x, a.f[i][o].ssz.x);
		ret.y = Math.max(ret.y, a.f[i][o].ssz.y);
	    }
	}
	return(ret);
    }

    Animation(Resource.Anim anim) {
	super(anim.f[0][0].z, sz(anim));
	this.a = anim;
	this.dur = anim.d / 1000.0;
	te = 0;
    }

    void tick(double dt) {
	te += dt;
	while(te > dur) {
	    te -= dur;
	    cf = (cf + 1) % a.f.length;
	}
    }

    void draw(GOut g) {
	for(int i = 0; i < a.f[cf].length; i++)
	    g.image(a.f[cf][i], Coord.z);
    }
}

src �  Layered.java /* Preprocessed source code */
/* $use: ui/tt/defn */

package haven.res.lib.layspr;

import haven.*;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.util.*;

public class Layered extends GSprite implements GSprite.ImageSprite {
    final Layer[] lay;
    final Coord sz;

    public static List<Indir<Resource>> decode(Resource.Resolver rr, Message sdt) {
	List<Indir<Resource>> ret = new ArrayList<Indir<Resource>>();
	while(!sdt.eom())
	    ret.add(rr.getres(sdt.uint16()));
	return(ret);
    }

    public Layered(Owner owner, Collection<Indir<Resource>> lres) {
	super(owner);
	List<Layer> lay = new ArrayList<Layer>(lres.size());
	for(Indir<Resource> res : lres) {
	    boolean f = false;
	    for(Resource.Anim anim : res.get().layers(Resource.animc)) {
		f = true;
		lay.add(new Animation(anim));
	    }
	    if(f)
		continue;
	    for(Resource.Image img : res.get().layers(Resource.imgc))
		lay.add(new Image(img));
	}
	Collections.sort(lay, new Comparator<Layer>() {
		public int compare(Layer a, Layer b) {
		    return(a.z - b.z);
		}
	    });
	this.lay = lay.toArray(new Layer[0]);
	sz = new Coord();
	for(Layer l : this.lay) {
	    sz.x = Math.max(sz.x, l.sz.x);
	    sz.y = Math.max(sz.y, l.sz.y);
	}
	tick(Math.random() * 10);
    }

    public void draw(GOut g) {
	for(Layer l : lay)
	    l.draw(g);
    }

    public Coord sz() {
	return(sz);
    }

    public void tick(double dt) {
	for(Layer l : lay) {
	    if(l instanceof Animation)
		((Animation)l).tick(dt);
	}
    }

    public BufferedImage image() {
	Coord sz = sz();
	if((sz.x < 1) || (sz.y < 1))
	    return(null);
	BufferedImage img = TexI.mkbuf(sz);
	Graphics g = img.getGraphics();
	for(Layer l : lay) {
	    if(l instanceof Image) {
		Image il = (Image)l;
		g.drawImage(il.img.scaled(), il.img.o.x, il.img.o.y, null);
	    }
	}
	return(img);
    }
}

/* >ispr: haven.res.lib.layspr.BaseLayered */
src +  BaseLayered.java /* Preprocessed source code */
/* $use: ui/tt/defn */

package haven.res.lib.layspr;

import haven.*;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.util.*;

public class BaseLayered extends Layered implements haven.res.ui.tt.defn.DynName {
    public final String name;

    public BaseLayered(Owner owner, List<Indir<Resource>> lay) {
	super(owner, lay);
	Resource nres = Utils.el(lay).get();
	Resource.Tooltip tt = nres.layer(Resource.tooltip);
	if(tt == null)
	    throw(new RuntimeException("Item resource " + nres + " is missing default tooltip"));
	name = tt.t;
    }

    public BaseLayered(Owner owner, Resource res, Message sdt) {
	this(owner, decode(owner.context(Resource.Resolver.class), sdt));
    }

    public String name() {
	return(name);
    }
}
code �  haven.res.lib.layspr.Layer ����   4 
  	  	     z I sz Lhaven/Coord; <init> (ILhaven/Coord;)V Code LineNumberTable draw (Lhaven/GOut;)V 
SourceFile 
Layer.java 
     	 haven/res/lib/layspr/Layer java/lang/Object ()V layspr.cjava              	      
      3     *� *� *,� �              	              code �  haven.res.lib.layspr.Image ����   4 -	 
 	 
 
  	  	  
     img ! Image InnerClasses Lhaven/Resource$Image; <init> (Lhaven/Resource$Image;)V Code LineNumberTable draw (Lhaven/GOut;)V 
SourceFile 
Image.java " # $ %  & 	  ' " % ( ) * haven/res/lib/layspr/Image haven/res/lib/layspr/Layer + haven/Resource$Image z I ssz Lhaven/Coord; (ILhaven/Coord;)V haven/Coord 
haven/GOut image &(Lhaven/Resource$Image;Lhaven/Coord;)V haven/Resource layspr.cjava         	             2     *+� +� � *+� �                        (     +*� � � �       
             ,    
  
    code �  haven.res.lib.layspr.Animation ����   4 Z .
  /	  0	  1	 2 3
 4 5	  6	 2 7
  8
  9	  :	  ;@�@     	  <	  =	  >	  ?
 @ A B C a E Anim InnerClasses Lhaven/Resource$Anim; te D dur cf I sz $(Lhaven/Resource$Anim;)Lhaven/Coord; Code LineNumberTable StackMapTable . <init> (Lhaven/Resource$Anim;)V tick (D)V draw (Lhaven/GOut;)V 
SourceFile Animation.java haven/Coord & F G I J  K L M N O P Q  R    ! & S   T        R M U V W haven/res/lib/layspr/Animation haven/res/lib/layspr/Layer X haven/Resource$Anim ()V f Image [[Lhaven/Resource$Image; x haven/Resource$Image ssz Lhaven/Coord; java/lang/Math max (II)I y z (ILhaven/Coord;)V d 
haven/GOut image &(Lhaven/Resource$Image;Lhaven/Coord;)V haven/Resource layspr.cjava                                    !  "   �     `� Y� L=*� �� N>*� 2�� ;++� *� 22� � � � ++� *� 22� � � � ��������+�    $    � 
 %� 
� B�  #   "    )  *  +   , 9 - R + X * ^ 0   & '  "   S     +*+� 22� +� 	� 
*+� *+� � o� *� �    #       4  5  6 % 7 * 8   ( )  "   l     :*Y� 'c� *� *� �� &*Y� *� g� **� `*� � �p� ��Ա    $    
. #       ; 
 <  = # > 9 @   * +  "   b     /=*� � *� 2�� +*� � *� 22� � ���ױ    $   	 � � + #       C  D ( C . E  ,    Y       D   2 D H code �  haven.res.lib.layspr.Layered$1 ����   4 -	  
  	   
      ! this$0 Lhaven/res/lib/layspr/Layered; <init> !(Lhaven/res/lib/layspr/Layered;)V Code LineNumberTable compare ;(Lhaven/res/lib/layspr/Layer;Lhaven/res/lib/layspr/Layer;)I '(Ljava/lang/Object;Ljava/lang/Object;)I 	Signature FLjava/lang/Object;Ljava/util/Comparator<Lhaven/res/lib/layspr/Layer;>; 
SourceFile Layered.java EnclosingMethod "  % 	 
  & ' ( haven/res/lib/layspr/Layer   haven/res/lib/layspr/Layered$1 InnerClasses java/lang/Object java/util/Comparator haven/res/lib/layspr/Layered * Owner .(Lhaven/GSprite$Owner;Ljava/util/Collection;)V ()V z I + haven/GSprite$Owner haven/GSprite layspr.cjava        	 
            "     
*+� *� �           a        "     
+� ,� d�           cA       %     *+� ,� � �           a      ,                  # ) $	      code S  haven.res.lib.layspr.Layered ����   4 � \
  ]
 ^ _
 ^ ` = a b c
 5 d e f
  g e h i j i k l  m n	  o
  p q s
  t	  u v x
  y z
  {
 | } ~ b  9	 4 � �
   ]	 4 �	   �	  �
 � �	   �
 � �@$      
 4 �
  �
  �
 4 �
 � �
 � �	  �
  �	  �
 � � � � � InnerClasses lay [Lhaven/res/lib/layspr/Layer; sz Lhaven/Coord; decode � Resolver :(Lhaven/Resource$Resolver;Lhaven/Message;)Ljava/util/List; Code LineNumberTable StackMapTable � 	Signature [(Lhaven/Resource$Resolver;Lhaven/Message;)Ljava/util/List<Lhaven/Indir<Lhaven/Resource;>;>; <init> � Owner .(Lhaven/GSprite$Owner;Ljava/util/Collection;)V � � � � l O(Lhaven/GSprite$Owner;Ljava/util/Collection<Lhaven/Indir<Lhaven/Resource;>;>;)V draw (Lhaven/GOut;)V ()Lhaven/Coord; tick (D)V image  ()Ljava/awt/image/BufferedImage; � � � 
SourceFile Layered.java java/util/ArrayList F � � � � � � � � � � � F � � � � F � � � � � � � � haven/Indir � � haven/Resource � � � � haven/Resource$Anim Anim haven/res/lib/layspr/Animation F � � � haven/Resource$Image Image haven/res/lib/layspr/Image F � haven/res/lib/layspr/Layered$1 F � � � � haven/res/lib/layspr/Layer � � 8 9 haven/Coord : ; � � � � � � � � � S T P Q : R � � � � � � � � � V � ; � � � haven/res/lib/layspr/Layered haven/GSprite haven/GSprite$ImageSprite ImageSprite haven/Resource$Resolver java/util/List haven/GSprite$Owner java/util/Collection java/util/Iterator java/awt/image/BufferedImage java/awt/Graphics ()V haven/Message eom ()Z uint16 ()I getres (I)Lhaven/Indir; add (Ljava/lang/Object;)Z (Lhaven/GSprite$Owner;)V size (I)V iterator ()Ljava/util/Iterator; hasNext next ()Ljava/lang/Object; get animc Ljava/lang/Class; layers )(Ljava/lang/Class;)Ljava/util/Collection; (Lhaven/Resource$Anim;)V imgc (Lhaven/Resource$Image;)V !(Lhaven/res/lib/layspr/Layered;)V java/util/Collections sort )(Ljava/util/List;Ljava/util/Comparator;)V toArray (([Ljava/lang/Object;)[Ljava/lang/Object; x I java/lang/Math max (II)I y random ()D 
haven/TexI mkbuf -(Lhaven/Coord;)Ljava/awt/image/BufferedImage; getGraphics ()Ljava/awt/Graphics; img Lhaven/Resource$Image; scaled o 	drawImage 3(Ljava/awt/Image;IILjava/awt/image/ImageObserver;)Z layspr.cjava ! 4 5  6   8 9    : ;    	 < ?  @   X     %� Y� M+� � ,*+� �  �  W���,�    B   	 �  C A       M  N  O # P D    E  F I  @  �  	  J*+� � Y,�  � 	N,� 
 :�  � ��  � :6�  � � � � 
 :�  � %�  � :6-� Y� �  W���� ����  � � � � 
 :�  � "�  � :-� Y� �  W��ڧ�\-� Y*� � *-� �  � � *�  Y� !� "*� :�66� B2:*� "*� "� #� $� #� %� #*� "*� "� &� $� &� %� &����*� ' (k� *�    B   = 	�   J K L C M  � / N M� +�  M� (� � 5 � E A   Z    T  U  V 1 W 4 X a Y d Z t [ w \ | ]  ^ � _ � ` � a � f � g � h i j8 h> lI m D    O  P Q  @   [     $*� M,�>6� ,2:+� +����    B    �  �  A       p  q  p # r  : R  @        *� "�    A       u  S T  @   m     1*� N-�66�  -2:� � � '� ,���߱    B    �  �  A       y  z ! { * y 0 }  U V  @   �  	   x*� -L+� #� +� &� �+� .M,� /N*� :�66� C2:� � .� :-� 0� 1� 0� 2� #� 0� 2� &� 3W����,�    B   ' �  W�   J W X Y   � @�  A   .    �  �  �  �  � ! � = � E � L � p � v �  Z    � 7   2         =  >	 G 5 H	   r    w  6 5 �	code <  haven.res.lib.layspr.BaseLayered ����   4 j
  0
 1 2 3  4 5	  6
  7 8 : ;
 
 < =
 
 >
 
 ? @
 
 A
 	 B	  C	  D E  G
  H
  I J K L name Ljava/lang/String; <init> N Owner InnerClasses ((Lhaven/GSprite$Owner;Ljava/util/List;)V Code LineNumberTable StackMapTable J N O 5 8 	Signature I(Lhaven/GSprite$Owner;Ljava/util/List<Lhaven/Indir<Lhaven/Resource;>;>;)V 7(Lhaven/GSprite$Owner;Lhaven/Resource;Lhaven/Message;)V ()Ljava/lang/String; 
SourceFile BaseLayered.java  P Q R S haven/Indir T U haven/Resource V W X [ haven/Resource$Tooltip Tooltip java/lang/RuntimeException java/lang/StringBuilder  \ Item resource  ] ^ ] _  is missing default tooltip ` -  a b    haven/Resource$Resolver Resolver c d e f  !  haven/res/lib/layspr/BaseLayered haven/res/lib/layspr/Layered haven/res/ui/tt/defn/DynName g haven/GSprite$Owner java/util/List .(Lhaven/GSprite$Owner;Ljava/util/Collection;)V haven/Utils el ((Ljava/lang/Iterable;)Ljava/lang/Object; get ()Ljava/lang/Object; tooltip Ljava/lang/Class; layer h Layer )(Ljava/lang/Class;)Lhaven/Resource$Layer; ()V append -(Ljava/lang/String;)Ljava/lang/StringBuilder; -(Ljava/lang/Object;)Ljava/lang/StringBuilder; toString (Ljava/lang/String;)V t context %(Ljava/lang/Class;)Ljava/lang/Object; decode :(Lhaven/Resource$Resolver;Lhaven/Message;)Ljava/util/List; haven/GSprite haven/Resource$Layer layspr.cjava !              !  "   �     Q*+,� ,� � �  � N-� � � :� #� 	Y� 
Y� � -� � � � �*� � �    $    � G  % & ' ( )   #       �  �  � " � ' � G � P � *    +   ,  "   1     *++�  � -� � �    #   
    �  �   -  "        *� �    #       �  .    i     "   M 	   9    F	 Y  Zcodeentry 8   ispr haven.res.lib.layspr.BaseLayered   ui/tt/defn   