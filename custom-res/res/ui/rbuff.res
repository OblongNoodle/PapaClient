Haven Resource 1 src ~  RealmBuff.java /* Preprocessed source code */
/* $use: ui/tt/attrmod */

import haven.*;
import java.util.*;
import java.awt.image.BufferedImage;
import haven.res.ui.tt.attrmod.*;

/* >wdg: RealmBuff */
public class RealmBuff extends Buff implements ItemInfo.ResOwner {
    public final Indir<Resource> res;
    public Object[] rawinfo;

    public RealmBuff(Indir<Resource> res) {
	super(res);
	this.res = res;
    }

    public static Widget mkwidget(UI ui, Object... args) {
	Indir<Resource> res = ui.sess.getres((Integer)args[0]);
	return(new RealmBuff(res));
    }

    public Resource resource() {return(res.get());}

    public static final ClassResolver<UI> uictx = new ClassResolver<UI>()
	.add(Glob.class, ui -> ui.sess.glob)
	.add(Session.class, ui -> ui.sess);
    public <C> C context(Class<C> cl) {
	return(uictx.context(cl, ui));
    }

    private List<ItemInfo> info = Collections.emptyList();
    public List<ItemInfo> info() {
	if(info == null)
	    info = ItemInfo.buildinfo(this, rawinfo);
	return(info);
    }

    private Tex rtip;
    public Object tooltip(Coord c, Widget prev) {
	try {
	    if(rtip == null) {
		List<ItemInfo> info = info();
		BufferedImage img = ItemInfo.longtip(info);
		Resource.Pagina pag = res.get().layer(Resource.pagina);
		if(pag != null)
		    img = ItemInfo.catimgs(0, img, RichText.render("\n" + pag.text, UI.scale(200)).img);
		rtip = new TexI(img);
	    }
	    return(rtip);
	} catch(Loading l) {
	    return("...");
	}
    }

    public void uimsg(String msg, Object... args) {
	if(msg == "tt") {
	    rawinfo = args;
	    info = null;
	    rtip = null;
	} else {
	    super.uimsg(msg, args);
	}
    }
}
code �  RealmBuff ����   4 �
 2 c
 d e	 	 f	 	 g	 h i j
  k
 0 l m
 	 c n o p	 	 q	 	 r
 + s	 	 t
 u v	 	 w
 	 x
 u y	  z
  { | ~ 
  � �
  �	  �
  �
 h � �
 � �	 � �
 u � �
 $ � � � �
 2 �	 0 � �
 + � �   �
 + � �  � � � res Lhaven/Indir; 	Signature Lhaven/Indir<Lhaven/Resource;>; rawinfo [Ljava/lang/Object; uictx ClassResolver InnerClasses "Lhaven/OwnerContext$ClassResolver; .Lhaven/OwnerContext$ClassResolver<Lhaven/UI;>; info Ljava/util/List; "Ljava/util/List<Lhaven/ItemInfo;>; rtip Lhaven/Tex; <init> (Lhaven/Indir;)V Code LineNumberTable "(Lhaven/Indir<Lhaven/Resource;>;)V mkwidget -(Lhaven/UI;[Ljava/lang/Object;)Lhaven/Widget; resource ()Lhaven/Resource; context %(Ljava/lang/Class;)Ljava/lang/Object; 1<C:Ljava/lang/Object;>(Ljava/lang/Class<TC;>;)TC; ()Ljava/util/List; StackMapTable $()Ljava/util/List<Lhaven/ItemInfo;>; tooltip /(Lhaven/Coord;Lhaven/Widget;)Ljava/lang/Object; � ~ | � uimsg ((Ljava/lang/String;[Ljava/lang/Object;)V lambda$static$1 (Lhaven/UI;)Lhaven/Session; lambda$static$0 (Lhaven/UI;)Lhaven/Glob; <clinit> ()V 
SourceFile RealmBuff.java D E � � P ? @ 4 5 � � � java/lang/Integer � � � � 	RealmBuff � � � haven/Resource : = � � M � 8 9 � � � B C ? P � � � � � � haven/Resource$Pagina Pagina java/awt/image/BufferedImage java/lang/StringBuilder D ` 
 � � � � � � � � java/lang/Object � � � � � � � 
haven/TexI D � haven/Loading ... tt Y Z � � �  haven/OwnerContext$ClassResolver 
haven/Glob BootstrapMethods � � � ^ � � � � haven/Session � \ 
haven/Buff haven/ItemInfo$ResOwner ResOwner java/util/List java/util/Collections 	emptyList haven/UI sess Lhaven/Session; intValue ()I getres (I)Lhaven/Indir; haven/Indir get ()Ljava/lang/Object; ui 
Lhaven/UI; 7(Ljava/lang/Class;Ljava/lang/Object;)Ljava/lang/Object; haven/ItemInfo 	buildinfo � Owner ;(Lhaven/ItemInfo$Owner;[Ljava/lang/Object;)Ljava/util/List; longtip 0(Ljava/util/List;)Ljava/awt/image/BufferedImage; pagina Ljava/lang/Class; layer � Layer )(Ljava/lang/Class;)Lhaven/Resource$Layer; append -(Ljava/lang/String;)Ljava/lang/StringBuilder; text Ljava/lang/String; toString ()Ljava/lang/String; scale (I)I haven/RichText render 8(Ljava/lang/String;I[Ljava/lang/Object;)Lhaven/RichText; img Ljava/awt/image/BufferedImage; catimgs @(I[Ljava/awt/image/BufferedImage;)Ljava/awt/image/BufferedImage; !(Ljava/awt/image/BufferedImage;)V glob Lhaven/Glob; haven/OwnerContext
 � � &(Ljava/lang/Object;)Ljava/lang/Object;
 	 � apply ()Ljava/util/function/Function; add R(Ljava/lang/Class;Ljava/util/function/Function;)Lhaven/OwnerContext$ClassResolver;
 	 � haven/ItemInfo$Owner haven/Resource$Layer � � � ] ^ [ \ "java/lang/invoke/LambdaMetafactory metafactory � Lookup �(Ljava/lang/invoke/MethodHandles$Lookup;Ljava/lang/String;Ljava/lang/invoke/MethodType;Ljava/lang/invoke/MethodType;Ljava/lang/invoke/MethodHandle;Ljava/lang/invoke/MethodType;)Ljava/lang/invoke/CallSite; � %java/lang/invoke/MethodHandles$Lookup java/lang/invoke/MethodHandles rbuff.cjava ! 	 2  3   4 5  6    7  8 9    : =  6    >  ? @  6    A  B C   
  D E  F   6     *+� *� � *+� �    G               6    H � I J  F   6     *� +2� � � M� 	Y,� 
�    G   
        K L  F   %     *� �  � �    G         M N  F   $     � +*� � �    G        6    O  ? P  F   A     *� � ***� � � *� �    Q     G       "  #  $ 6    R  S T  F   �     }*� � p*� N-� :*� �  � � � � :� <� YSY� Y� � � � �  ȸ �  � !� "S� #:*� $Y� %� *� �N'�    x y &  Q    � g U V W� D X G   * 
   *  +  ,  - ) . . / g 0 t 2 y 3 z 4 � Y Z  F   U     +(� *,� *� *� � 	*+,� )�    Q     G       9  :  ;  <  >  @
 [ \  F        *� �    G       
 ] ^  F         *� � *�    G         _ `  F   C      � +Y� ,-� .  � /0� 1  � /� �    G               �     �  � � � �  � � � a    � <   2  + � ; 	   }  3 u �	 � u �	 �  � � � � codeentry #   wdg RealmBuff   ui/tt/attrmod 
  