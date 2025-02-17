Haven Resource 1 src 5  Decal.java /* Preprocessed source code */
/* $use: lib/itemtex */

package haven.res.gfx.terobjs.items.decal;

import haven.*;
import haven.render.*;
import haven.res.lib.itemtex.ItemTex;
import java.util.*;
import java.util.function.*;
import java.awt.image.BufferedImage;

/* >spr: Decal */
public class Decal implements Sprite.Factory {
    public Sprite create(Sprite.Owner owner, Resource res, Message sdt) {
	Supplier<Pipe.Op> eq = null;
	Gob gob = owner.ocontext(Gob.class).orElse(null);
	if(gob != null) {
	    Resource ores = gob.getres();
	    if(ores != null) {
		Skeleton.BoneOffset bo = ores.layer(Skeleton.BoneOffset.class, "decal");
		if(bo != null)
		    eq = bo.from(gob);
	    }
	}
	Material base = res.layer(Material.Res.class, 16).get();
	RenderTree.Node proj = res.layer(FastMesh.MeshRes.class, 0).m;
	Coord3f pc;
	if(sdt.eom()) {
	    pc = Coord3f.o;
	} else {
	    pc = new Coord3f((float)(sdt.float16() * MCache.tilesz.x), -(float)(sdt.float16() * MCache.tilesz.y), 0);
	}
	Location offset = null;
	if(eq == null)
	    offset = Location.xlate(pc);
	Material sym = null;
	if(!sdt.eom()) {
	    BufferedImage img = ItemTex.create(owner, sdt);
	    if(img != null) {
		TexRender tex = ItemTex.fixup(img);
		sym = new Material(base, tex.draw, tex.clip);
	    }
	}
	RenderTree.Node[] parts = StaticSprite.lsparts(res, Message.nil);
	if(sym != null)
	    parts = Utils.extend(parts, sym.apply(proj));
	Location cpoffset = offset;
	Supplier<Pipe.Op> cpeq = eq;
	return(new StaticSprite(owner, res, parts) {
		final Collection<RenderTree.Slot> slots = new ArrayList<>(1);

		public void added(RenderTree.Slot slot) {
		    if(cpeq != null)
			slot.ostate(cpeq.get());
		    else if(cpoffset != null)
			slot.ostate(cpoffset);
		    super.added(slot);
		    slots.add(slot);
		}

		public void removed(RenderTree.Slot slot) {
		    super.removed(slot);
		    slots.remove(slot);
		}

		public boolean tick(double dt) {
		    if(cpeq != null) {
			Pipe.Op nst = cpeq.get();
			for(RenderTree.Slot slot : slots)
			    slot.ostate(nst);
		    }
		    return(false);
		}
	    });
    }
}
code <  haven.res.gfx.terobjs.items.decal.Decal$1 ����   4 k	  6	  7	  8
  9 :
  ;	  < = > @  B
  C D E
  F D G D H I J I K M N O slots Ljava/util/Collection; 	Signature Slot InnerClasses 6Ljava/util/Collection<Lhaven/render/RenderTree$Slot;>; val$cpeq Ljava/util/function/Supplier; val$cpoffset Lhaven/render/Location; this$0 )Lhaven/res/gfx/terobjs/items/decal/Decal; <init> Q Owner R Node �(Lhaven/res/gfx/terobjs/items/decal/Decal;Lhaven/Sprite$Owner;Lhaven/Resource;[Lhaven/render/RenderTree$Node;Ljava/util/function/Supplier;Lhaven/render/Location;)V Code LineNumberTable added !(Lhaven/render/RenderTree$Slot;)V StackMapTable removed tick (D)Z @ S 
SourceFile 
Decal.java EnclosingMethod T U V        ! W java/util/ArrayList ! X   Y Z [ \ haven/render/Pipe$Op Op ] ^ ) * _ ` a , * b a c d S e f g [ h haven/render/RenderTree$Slot )haven/res/gfx/terobjs/items/decal/Decal$1 haven/StaticSprite i haven/Sprite$Owner haven/render/RenderTree$Node java/util/Iterator 'haven/res/gfx/terobjs/items/decal/Decal create C(Lhaven/Sprite$Owner;Lhaven/Resource;Lhaven/Message;)Lhaven/Sprite; F(Lhaven/Sprite$Owner;Lhaven/Resource;[Lhaven/render/RenderTree$Node;)V (I)V java/util/function/Supplier get ()Ljava/lang/Object; haven/render/Pipe ostate (Lhaven/render/Pipe$Op;)V java/util/Collection add (Ljava/lang/Object;)Z remove iterator ()Ljava/util/Iterator; hasNext ()Z next haven/render/RenderTree haven/Sprite decal.cjava                                 ! &  '   B     &*+� *� *� *,-� *� Y� � �    (   
    1  2  ) *  '   x     >*� � +*� �  � 	� 
 � *� � +*� � 
 *+� *� +�  W�    +     (       5  6  7 # 8 - 9 2 : = ;  , *  '   1     *+� *� +�  W�    (       >  ?  @  - .  '   ~     B*� � <*� �  � 	N*� �  :�  � �  � :-� 
 ����    +    �  / 0�   (       C  D  E 5 F @ H  1    j    *   L 	 " P #	 $ L %	 	 ? A	        3    4 5code   haven.res.gfx.terobjs.items.decal.Decal ����   4 �
 ' ; < / =
 > ?
  @ B D
 E F
  G H
 J K
 
 L N	  P
 Q R	  S T
 Q U	 V W	 X Y	 X Z
  [
 \ ]
 ^ _
 ^ ` a c	 e f	 e g
  h	 Q i
 j k
  l
 m n q r
 $ s t u w InnerClasses <init> ()V Code LineNumberTable create y Owner C(Lhaven/Sprite$Owner;Lhaven/Resource;Lhaven/Message;)Lhaven/Sprite; StackMapTable z < a { T | 
SourceFile 
Decal.java * + 	haven/Gob } ~  � � � � � haven/Skeleton$BoneOffset 
BoneOffset decal � � � � � haven/Material$Res Res � � � � � � haven/FastMesh$MeshRes MeshRes � � � � � � � haven/Coord3f � � � � � � � � � � * � | � � � . � � � haven/Material � haven/render/Pipe$Op Op � � � � � * � � � � � � � � � � � { Node [Lhaven/render/RenderTree$Node; )haven/res/gfx/terobjs/items/decal/Decal$1 * � 'haven/res/gfx/terobjs/items/decal/Decal java/lang/Object � haven/Sprite$Factory Factory haven/Sprite$Owner java/util/function/Supplier haven/render/RenderTree$Node haven/render/Location ocontext '(Ljava/lang/Class;)Ljava/util/Optional; java/util/Optional orElse &(Ljava/lang/Object;)Ljava/lang/Object; getres ()Lhaven/Resource; haven/Skeleton haven/Resource layer � IDLayer =(Ljava/lang/Class;Ljava/lang/Object;)Lhaven/Resource$IDLayer; from 2(Lhaven/EquipTarget;)Ljava/util/function/Supplier; java/lang/Integer valueOf (I)Ljava/lang/Integer; get ()Lhaven/Material; haven/FastMesh m Lhaven/FastMesh; haven/Message eom ()Z o Lhaven/Coord3f; float16 ()F haven/MCache tilesz Lhaven/Coord2d; haven/Coord2d x D y (FFF)V xlate ((Lhaven/Coord3f;)Lhaven/render/Location; haven/res/lib/itemtex/ItemTex C(Lhaven/OwnerContext;Lhaven/Message;)Ljava/awt/image/BufferedImage; fixup ,(Ljava/awt/image/BufferedImage;)Lhaven/TexL; haven/render/Pipe haven/TexRender draw � TexDraw Lhaven/TexRender$TexDraw; clip � TexClip Lhaven/TexRender$TexClip; ([Lhaven/render/Pipe$Op;)V nil Lhaven/Message; haven/StaticSprite lsparts @(Lhaven/Resource;Lhaven/Message;)[Lhaven/render/RenderTree$Node; apply � Wrapping ?(Lhaven/render/RenderTree$Node;)Lhaven/render/Pipe$Op$Wrapping; haven/Utils extend :([Ljava/lang/Object;Ljava/lang/Object;)[Ljava/lang/Object; � �(Lhaven/res/gfx/terobjs/items/decal/Decal;Lhaven/Sprite$Owner;Lhaven/Resource;[Lhaven/render/RenderTree$Node;Ljava/util/function/Supplier;Lhaven/render/Location;)V haven/Sprite haven/Resource$IDLayer haven/TexRender$TexDraw haven/TexRender$TexClip haven/render/Pipe$Op$Wrapping haven/render/RenderTree decal.cjava ! & '  (     * +  ,        *� �    -         . 1  ,  �     :+�  � � :� +� :� � � :� � 	:,
� � � 
� :,� � � � :-� � � :� (� Y-� �� � k�-� �� � k�v� ::	� 
� :	:
-� � 8+-� :� ,� :� Y� YSY� SY� S� :
,� �  :
� 
� !� "� #:	::� $Y*+,� %�    2   , � A 3 4� 3 5 6� $ 7�  8� > 5�  # -   r              %  3  8  A  T  f  m  u  � ! � " � # � $ � % � & � ' � ( � ) � , � - � . / 0 1  9    � )   b  $       / v 0	  A C 	 
  I 	  M O 	  b d	 o � p	 ( v x	 � E �	 � e � 	 � e � 	 �  � 	codeentry ?   spr haven.res.gfx.terobjs.items.decal.Decal   lib/itemtex   