Haven Resource 1 src N  Spec.java /* Preprocessed source code */
package haven.res.lib.tspec;

import haven.*;
import java.util.*;

public class Spec implements GSprite.Owner, ItemInfo.SpriteOwner {
    private static final Object[] definfo = {
	new Object[] {Loading.waitfor(Resource.classres(Spec.class).pool.load("ui/tt/defn", 6))},
    };
    public final Object[] info;
    public final ResData res;
    public final OwnerContext ctx;

    public Spec(ResData res, OwnerContext ctx, Object[] info) {
	this.res = res;
	this.ctx = ctx;
	this.info = (info == null)?definfo:info;
    }

    public static final ClassResolver<UI> uictx = new ClassResolver<UI>()
	.add(Glob.class, ui -> ui.sess.glob)
	.add(Session.class, ui -> ui.sess);
    public static OwnerContext uictx(UI ui) {
	return(new OwnerContext() {
		public <C> C context(Class<C> cl) {return(uictx.context(cl, ui));}
	    });
    }

    public <T> T context(Class<T> cl) {return(ctx.context(cl));}
    @Deprecated
    public Glob glob() {return(context(Glob.class));}
    public Resource getres() {return(res.res.get());}
    private Random rnd = null;
    public Random mkrandoom() {
	if(rnd == null)
	    rnd = new Random();
	return(rnd);
    }
    public GSprite sprite() {return(spr);}
    public Resource resource() {return(res.res.get());}

    private GSprite spr = null;
    public GSprite spr() {
	if(spr == null)
	    spr = GSprite.create(this, res.res.get(), res.sdt.clone());
	return(spr);
    }

    private List<ItemInfo> cinfo = null;
    public List<ItemInfo> info() {
	if(cinfo == null)
	    cinfo = ItemInfo.buildinfo(this, info);
	return(cinfo);
    }

    public Tex longtip() {
	return(new TexI(ItemInfo.longtip(info())));
    }

    public String name() {
	GSprite spr = spr();
	ItemInfo.Name nm = ItemInfo.find(ItemInfo.Name.class, info());
	if(nm == null)
	    return(null);
	return(nm.str.text);
    }
}
code 2  haven.res.lib.tspec.Spec$1 ����   4 )	  
  	  
      val$ui 
Lhaven/UI; <init> (Lhaven/UI;)V Code LineNumberTable context %(Ljava/lang/Class;)Ljava/lang/Object; 	Signature 1<C:Ljava/lang/Object;>(Ljava/lang/Class<TC;>;)TC; 
SourceFile 	Spec.java EnclosingMethod   ! "  	 
 # ! % &  ' haven/res/lib/tspec/Spec$1 InnerClasses java/lang/Object haven/OwnerContext haven/res/lib/tspec/Spec uictx  (Lhaven/UI;)Lhaven/OwnerContext; ()V ClassResolver "Lhaven/OwnerContext$ClassResolver;  haven/OwnerContext$ClassResolver 7(Ljava/lang/Class;Ljava/lang/Object;)Ljava/lang/Object; tspec.cjava 0       	      
      "     
*+� *� �                   $     � +*� � �                      (              $ 	      code <  haven.res.lib.tspec.Spec ����   4 �
 " o	 # p	 # q	 # r	 # s	 # t	 # u	 # v w
 	 x y z {
 # z	 | } ~  � �
  o	 | �
 � �
 � �
 � � �
 # �
 � �
  �
 # � �
 � �	  �	 � �	 � �	 - � � �
  �	  � �
 � �
 � � �
 ) o   �
 ) � �  �	 # � � � InnerClasses definfo [Ljava/lang/Object; info res Lhaven/ResData; ctx Lhaven/OwnerContext; uictx ClassResolver "Lhaven/OwnerContext$ClassResolver; 	Signature .Lhaven/OwnerContext$ClassResolver<Lhaven/UI;>; rnd Ljava/util/Random; spr Lhaven/GSprite; cinfo Ljava/util/List; "Ljava/util/List<Lhaven/ItemInfo;>; <init> 9(Lhaven/ResData;Lhaven/OwnerContext;[Ljava/lang/Object;)V Code LineNumberTable StackMapTable � � � 4  (Lhaven/UI;)Lhaven/OwnerContext; context %(Ljava/lang/Class;)Ljava/lang/Object; 1<T:Ljava/lang/Object;>(Ljava/lang/Class<TT;>;)TT; glob ()Lhaven/Glob; 
Deprecated RuntimeVisibleAnnotations Ljava/lang/Deprecated; getres ()Lhaven/Resource; 	mkrandoom ()Ljava/util/Random; sprite ()Lhaven/GSprite; resource ()Ljava/util/List; $()Ljava/util/List<Lhaven/ItemInfo;>; longtip ()Lhaven/Tex; name ()Ljava/lang/String; � � lambda$static$1 (Lhaven/UI;)Lhaven/Session; lambda$static$0 (Lhaven/UI;)Lhaven/Glob; <clinit> ()V 
SourceFile 	Spec.java F l ? @ A B C D 6 7 8 9 3 4 5 4 haven/res/lib/tspec/Spec$1 F � � P Q 
haven/Glob � 6 � � � � haven/Resource java/util/Random � � � � � � � � � � � 
haven/TexI 5 _ a � F � A ] haven/ItemInfo$Name Name � � � � � � � � � � S � java/lang/Object haven/res/lib/tspec/Spec � � � � 
ui/tt/defn � � � � � �  haven/OwnerContext$ClassResolver BootstrapMethods � � � j � � � � haven/Session � h : < haven/GSprite$Owner Owner haven/ItemInfo$SpriteOwner SpriteOwner haven/ResData haven/OwnerContext haven/GSprite (Lhaven/UI;)V Lhaven/Indir; haven/Indir get ()Ljava/lang/Object; sdt Lhaven/MessageBuf; haven/MessageBuf clone ()Lhaven/MessageBuf; create E(Lhaven/GSprite$Owner;Lhaven/Resource;Lhaven/Message;)Lhaven/GSprite; haven/ItemInfo 	buildinfo � ;(Lhaven/ItemInfo$Owner;[Ljava/lang/Object;)Ljava/util/List; 0(Ljava/util/List;)Ljava/awt/image/BufferedImage; !(Ljava/awt/image/BufferedImage;)V find 5(Ljava/lang/Class;Ljava/util/List;)Ljava/lang/Object; str Lhaven/Text; 
haven/Text text Ljava/lang/String; haven/UI sess Lhaven/Session; Lhaven/Glob; classres #(Ljava/lang/Class;)Lhaven/Resource; pool Pool Lhaven/Resource$Pool; haven/Resource$Pool load � Named +(Ljava/lang/String;I)Lhaven/Resource$Named; haven/Loading waitfor !(Lhaven/Indir;)Ljava/lang/Object;
 � � &(Ljava/lang/Object;)Ljava/lang/Object;
 # � apply ()Ljava/util/function/Function; add R(Ljava/lang/Class;Ljava/util/function/Function;)Lhaven/OwnerContext$ClassResolver;
 # � haven/ItemInfo$Owner haven/Resource$Named � � � i j g h "java/lang/invoke/LambdaMetafactory metafactory � Lookup �(Ljava/lang/invoke/MethodHandles$Lookup;Ljava/lang/String;Ljava/lang/invoke/MethodType;Ljava/lang/invoke/MethodType;Ljava/lang/invoke/MethodHandle;Ljava/lang/invoke/MethodType;)Ljava/lang/invoke/CallSite; � %java/lang/invoke/MethodHandles$Lookup java/lang/invoke/MethodHandles tspec.cjava ! # "  0 1   3 4    5 4    6 7    8 9    : <  =    >  ? @    A B    C D  =    E   F G  H   �     -*� *� *� *� *+� *,� *-� 	� � -� �    J   1 � (  K L M N  K�    K L M N  K N I   "      ! 	 *  1       ,  	 : O  H   !     	� 	Y*� 
�    I         P Q  H   #     *� +�  �    I        =    R  S T  H   "     
*� � �    I        U     V     W    X Y  H   (     *� � �  � �    I          Z [  H   @     *� � *� Y� � *� �    J     I       #  $  %  \ ]  H        *� �    I       '  ^ Y  H   (     *� � �  � �    I       (  A ]  H   V     -*� � $***� � �  � *� � � � � *� �    J    ( I       ,  - ( .  5 _  H   A     *� � ***� � � *� �    J     I       3  4  5 =    `  a b  H   '     � Y*� � � �    I       9  c d  H   Y      *� L*� � � M,� �,� � �    J    �  e f I       =  >  ?  @  A
 g h  H        *�  �    I       
 i j  H         *�  � !�    I         k l  H   n 	     B� "Y� "Y#� $� %&� '� (SS� � )Y� *� +  � ,-� .  � ,� /�    I          #  1  ;  A   �     �  � � � �  � � � m    � 2   J 	 	      ) y ; 	  � � 	 0 � �	 1 � �	 � � �	 �  � 	 �  �	 � � � codeentry     