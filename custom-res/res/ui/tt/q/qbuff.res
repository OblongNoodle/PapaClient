Haven Resource 1 src o
  QBuff.java /* Preprocessed source code */
package haven.res.ui.tt.q.qbuff;

import haven.*;
import java.util.*;
import java.awt.image.BufferedImage;

public class QBuff extends ItemInfo.Tip {
    public BufferedImage icon;
    public String name;
    public double q;

    public QBuff(Owner owner, BufferedImage icon, String name, double q) {
	super(owner);
	this.icon = icon;
	this.name = name;
	this.q = q;
    }

    public static interface Modifier {
	public void prepare(QList ql);
    }

    public abstract static class QList extends Tip {
	public final List<QBuff> ql = new ArrayList<>();
	public final List<Modifier> mods = new ArrayList<>();

	QList() {super(null);}

	void sort() {
	    Collections.sort(ql, new Comparator<QBuff>() {
		    public int compare(QBuff a, QBuff b) {
			return(a.name.compareTo(b.name));
		    }
		});
	    for(Modifier mod : mods)
		mod.prepare(this);
	}
    }

    public static class Table extends QList {
	public int order() {return(10);}

	public void layout(Layout l) {
	    sort();
	    CompImage tab = new CompImage();
	    CompImage.Image[] ic = new CompImage.Image[ql.size()];
	    CompImage.Image[] nm = new CompImage.Image[ql.size()];
	    CompImage.Image[] qv = new CompImage.Image[ql.size()];
	    int i = 0;
	    for(QBuff q : ql) {
		ic[i] = CompImage.mk(q.icon);
		nm[i] = CompImage.mk(Text.render(q.name + ":").img);
		qv[i] = CompImage.mk(Text.render((((int)q.q) == q.q)?String.format("%d", (int)q.q):String.format("%.1f", q.q)).img);
		i++;
	    }
	    tab.table(Coord.z, new CompImage.Image[][] {ic, nm, qv}, new int[] {5, 15}, 0, new int[] {0, 0, 1});
	    l.cmp.add(tab, new Coord(0, l.cmp.sz.y));
	}
    }

    public static final Layout.ID<Table> lid = new Layout.ID<Table>() {
	public Table make() {return(new Table());}
    };

    public static class Summary extends QList {
	public int order() {return(10);}

	public void layout(Layout l) {
	    sort();
	    CompImage buf = new CompImage();
	    for(int i = 0; i < ql.size(); i++) {
		QBuff q = ql.get(i);
		Text t = Text.render(String.format((i < ql.size() - 1)?"%,d, ":"%,d", Math.round(q.q)));
		buf.add(q.icon, new Coord(buf.sz.x, Math.max(0, (t.sz().y - q.icon.getHeight()) / 2)));
		buf.add(t.img, new Coord(buf.sz.x, 0));
	    }
	    l.cmp.add(buf, new Coord(l.cmp.sz.x + 10, 0));
	}
    }

    public static final Layout.ID<Summary> sid = new Layout.ID<Summary>() {
	public Summary make() {return(new Summary());}
    };

    public void prepare(Layout l) {
	l.intern(lid).ql.add(this);
    }

    public Tip shortvar() {
	return(new Tip(owner) {
		public void prepare(Layout l) {
		    l.intern(sid).ql.add(QBuff.this);
		}
	    });
    }
}
code t  haven.res.ui.tt.q.qbuff.QBuff$Modifier ����   4    prepare  QList InnerClasses ((Lhaven/res/ui/tt/q/qbuff/QBuff$QList;)V 
SourceFile 
QBuff.java  &haven/res/ui/tt/q/qbuff/QBuff$Modifier Modifier java/lang/Object #haven/res/ui/tt/q/qbuff/QBuff$QList haven/res/ui/tt/q/qbuff/QBuff qbuff.cjava                        
 	  
 	code �  haven.res.ui.tt.q.qbuff.QBuff$QList$1 ����   4 /	  
  	  
    !
  " # $ % this$0 & QList InnerClasses %Lhaven/res/ui/tt/q/qbuff/QBuff$QList; <init> ((Lhaven/res/ui/tt/q/qbuff/QBuff$QList;)V Code LineNumberTable compare A(Lhaven/res/ui/tt/q/qbuff/QBuff;Lhaven/res/ui/tt/q/qbuff/QBuff;)I '(Ljava/lang/Object;Ljava/lang/Object;)I 	Signature ILjava/lang/Object;Ljava/util/Comparator<Lhaven/res/ui/tt/q/qbuff/QBuff;>; 
SourceFile 
QBuff.java EnclosingMethod ' ( 
   ( ) * + , - haven/res/ui/tt/q/qbuff/QBuff   %haven/res/ui/tt/q/qbuff/QBuff$QList$1 java/lang/Object java/util/Comparator #haven/res/ui/tt/q/qbuff/QBuff$QList sort ()V name Ljava/lang/String; java/lang/String 	compareTo (Ljava/lang/String;)I qbuff.cjava      	  
             "     
*+� *� �                   $     +� ,� � �            A       %     *+� ,� � �                 .             	             code   haven.res.ui.tt.q.qbuff.QBuff$QList ����   4 J
  " #
  $	  %	  & '
  (
 ) * + , - . - / 1  2 3 5 QList InnerClasses ql Ljava/util/List; 	Signature 1Ljava/util/List<Lhaven/res/ui/tt/q/qbuff/QBuff;>; mods Modifier :Ljava/util/List<Lhaven/res/ui/tt/q/qbuff/QBuff$Modifier;>; <init> ()V Code LineNumberTable sort StackMapTable 7 
SourceFile 
QBuff.java  : java/util/ArrayList       %haven/res/ui/tt/q/qbuff/QBuff$QList$1  ; <  = > ? @ 7 A B C D E &haven/res/ui/tt/q/qbuff/QBuff$Modifier F ; #haven/res/ui/tt/q/qbuff/QBuff$QList G haven/ItemInfo$Tip Tip java/util/Iterator H Owner (Lhaven/ItemInfo$Owner;)V ((Lhaven/res/ui/tt/q/qbuff/QBuff$QList;)V java/util/Collections )(Ljava/util/List;Ljava/util/Comparator;)V java/util/List iterator ()Ljava/util/Iterator; hasNext ()Z next ()Ljava/lang/Object; haven/res/ui/tt/q/qbuff/QBuff prepare haven/ItemInfo haven/ItemInfo$Owner qbuff.cjava!                                 @     *� *� Y� � *� Y� � �                          l     7*� � Y*� � *� � 	 L+� 
 � +�  � M,*�  ���        �  �           # , $ 6 %       I    *   0 	         0 	  4 6	 8 4 9	code t	  haven.res.ui.tt.q.qbuff.QBuff$Table ����   4 �
 ' <
 & = >
  <	 & ? @ A B @ D E F E G H	  I
  J K
  <	  L
  M N
  O
 P Q	 R S	  T U V
 W X
 Y Z [
 \ ]	 ! ^ _
  `	 / a b	  c	 ! d
 ! e
  f g i <init> ()V Code LineNumberTable order ()I layout l Layout InnerClasses (Lhaven/ItemInfo$Layout;)V StackMapTable g l > m H n 
SourceFile 
QBuff.java ( ) o ) haven/CompImage p q r s - haven/CompImage$Image Image t u m v w x y haven/res/ui/tt/q/qbuff/QBuff z { | } java/lang/StringBuilder ~  � � : � � � � � � � { � � %d java/lang/Object � � � n � � %.1f � � � � � [Lhaven/CompImage$Image; � � � � haven/Coord � � � � ( � � � #haven/res/ui/tt/q/qbuff/QBuff$Table Table #haven/res/ui/tt/q/qbuff/QBuff$QList QList � haven/ItemInfo$Layout java/util/Iterator java/lang/String sort ql Ljava/util/List; java/util/List size iterator ()Ljava/util/Iterator; hasNext ()Z next ()Ljava/lang/Object; icon Ljava/awt/image/BufferedImage; mk 7(Ljava/awt/image/BufferedImage;)Lhaven/CompImage$Image; name Ljava/lang/String; append -(Ljava/lang/String;)Ljava/lang/StringBuilder; toString ()Ljava/lang/String; 
haven/Text render Line %(Ljava/lang/String;)Lhaven/Text$Line; haven/Text$Line img q D java/lang/Integer valueOf (I)Ljava/lang/Integer; format 9(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String; java/lang/Double (D)Ljava/lang/Double; z Lhaven/Coord; table N(Lhaven/Coord;[[Lhaven/CompImage$Image;Ljava/lang/Object;I[I)Lhaven/CompImage; cmp Lhaven/CompImage; sz y I (II)V add 1(Lhaven/CompImage;Lhaven/Coord;)Lhaven/CompImage; haven/ItemInfo qbuff.cjava ! & '       ( )  *        *� �    +       (  , -  *        
�    +       )  . 2  *  � 	 	  ,*� � Y� M*� �  � N*� �  � :*� �  � :6*� �  :� 	 � �� 
 � :-� � S� Y� � � � � � � � S� ��� �� � Y� �� S� � � Y� � S� � � � S���l,� � Y-SYSYS�
YOYO�
YOYOYO� W+�  ,� !Y+�  � "� #� $� %W�    3   m � C  4 5 6    7  � r 	 4 5 6    7 8  �  	 4 5 6    7 8   9�  +   >    ,  -  .  / ' 0 5 1 8 2 Y 3 e 4 � 5 � 6 � 7 � 8 9+ :  :    � 1   *  / k 0 	   C	 &  h 	 '  j	 R P � 	code F  haven.res.ui.tt.q.qbuff.QBuff$1 ����   4 (
   
  
      ! <init> ()V Code LineNumberTable make Table InnerClasses '()Lhaven/res/ui/tt/q/qbuff/QBuff$Table; # Tip ()Lhaven/ItemInfo$Tip; 	Signature $ Layout ID SLjava/lang/Object;Lhaven/ItemInfo$Layout$ID<Lhaven/res/ui/tt/q/qbuff/QBuff$Table;>; 
SourceFile 
QBuff.java EnclosingMethod %  	 #haven/res/ui/tt/q/qbuff/QBuff$Table   haven/res/ui/tt/q/qbuff/QBuff$1 java/lang/Object haven/ItemInfo$Layout$ID & haven/ItemInfo$Tip haven/ItemInfo$Layout haven/res/ui/tt/q/qbuff/QBuff haven/ItemInfo qbuff.cjava 0           	  
        *� �           =     
         � Y� �           >A    
        *� �           =      '         *     	  " 	  "  	   	             code 6  haven.res.ui.tt.q.qbuff.QBuff$Summary ����   4 �
  1
  2 3
  1	  4 5 6 5 7 8 9 : ;	  <
 = >
 ? @
 A B
 C D	  E F	  G	  H
 C I	  J
 K L
 = M
  N
  O	 C P	 ' Q
  R S U <init> ()V Code LineNumberTable order ()I layout X Layout InnerClasses (Lhaven/ItemInfo$Layout;)V StackMapTable 3 8 Y 
SourceFile 
QBuff.java   ! Z ! haven/CompImage [ \ ] ^ % _ ` haven/res/ui/tt/q/qbuff/QBuff %,d,  %,d java/lang/Object a b c d e f g h Y i j k l o p q haven/Coord r s t u r v w u x y % z {   | } ~  q � � } � %haven/res/ui/tt/q/qbuff/QBuff$Summary Summary #haven/res/ui/tt/q/qbuff/QBuff$QList QList � haven/ItemInfo$Layout java/lang/String sort ql Ljava/util/List; java/util/List size get (I)Ljava/lang/Object; q D java/lang/Math round (D)J java/lang/Long valueOf (J)Ljava/lang/Long; format 9(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String; 
haven/Text render � Line %(Ljava/lang/String;)Lhaven/Text$Line; icon Ljava/awt/image/BufferedImage; sz Lhaven/Coord; x I ()Lhaven/Coord; y java/awt/image/BufferedImage 	getHeight max (II)I (II)V add >(Ljava/awt/image/BufferedImage;Lhaven/Coord;)Lhaven/CompImage; img cmp Lhaven/CompImage; 1(Lhaven/CompImage;Lhaven/Coord;)Lhaven/CompImage; haven/ItemInfo haven/Text$Line qbuff.cjava !           !  "        *� �    #       A  $ %  "        
�    #       B  & *  "       �*� � Y� M>*� �  � �*� �  � :*� �  d� 	� 
� Y� � � S� � :,� � Y,� � � � � � dl� � � W,� � Y,� � � � W���i+� ,� Y+� � � 
`� � W�    +    �  ,� / -A .� g #   * 
   E  F  G  H * I Z J � K � G � M � N  /    � )   "  ' W ( 	   T 	   V	 m C n 	code N  haven.res.ui.tt.q.qbuff.QBuff$2 ����   4 (
   
  
      ! <init> ()V Code LineNumberTable make Summary InnerClasses )()Lhaven/res/ui/tt/q/qbuff/QBuff$Summary; # Tip ()Lhaven/ItemInfo$Tip; 	Signature $ Layout ID ULjava/lang/Object;Lhaven/ItemInfo$Layout$ID<Lhaven/res/ui/tt/q/qbuff/QBuff$Summary;>; 
SourceFile 
QBuff.java EnclosingMethod %  	 %haven/res/ui/tt/q/qbuff/QBuff$Summary   haven/res/ui/tt/q/qbuff/QBuff$2 java/lang/Object haven/ItemInfo$Layout$ID & haven/ItemInfo$Tip haven/ItemInfo$Layout haven/res/ui/tt/q/qbuff/QBuff haven/ItemInfo qbuff.cjava 0           	  
        *� �           Q     
         � Y� �           RA    
        *� �           Q      '         *     	  " 	  "  	   	             code 7  haven.res.ui.tt.q.qbuff.QBuff$3 ����   4 =	  
 	 	  
    	  " # $ % ' this$0 Lhaven/res/ui/tt/q/qbuff/QBuff; <init> ) Owner InnerClasses 8(Lhaven/res/ui/tt/q/qbuff/QBuff;Lhaven/ItemInfo$Owner;)V Code LineNumberTable prepare * Layout (Lhaven/ItemInfo$Layout;)V 
SourceFile 
QBuff.java EnclosingMethod + , - 
   . / 2 3 4 %haven/res/ui/tt/q/qbuff/QBuff$Summary Summary 5 6 7 8 9 haven/res/ui/tt/q/qbuff/QBuff$3 : haven/ItemInfo$Tip Tip haven/ItemInfo$Owner haven/ItemInfo$Layout haven/res/ui/tt/q/qbuff/QBuff shortvar ()Lhaven/ItemInfo$Tip; (Lhaven/ItemInfo$Owner;)V sid ; ID Lhaven/ItemInfo$Layout$ID; intern 0(Lhaven/ItemInfo$Layout$ID;)Lhaven/ItemInfo$Tip; ql Ljava/util/List; java/util/List add (Ljava/lang/Object;)Z haven/ItemInfo haven/ItemInfo$Layout$ID qbuff.cjava    	    
             #     *+� *,� �           Z        4     +� � � � *� �  W�       
    \  ]      <    2   & 	  &  	   ! 	        	 & (	 0  1	      code V  haven.res.ui.tt.q.qbuff.QBuff ����   4 b
  ;	  <	  =	  >	  ?
 # @ A	  B C D E	  F
 
 G H
  I J
  I	  K L N O Summary InnerClasses Table P QList Q Modifier icon Ljava/awt/image/BufferedImage; name Ljava/lang/String; q D lid R Layout S ID Lhaven/ItemInfo$Layout$ID; 	Signature ALhaven/ItemInfo$Layout$ID<Lhaven/res/ui/tt/q/qbuff/QBuff$Table;>; sid CLhaven/ItemInfo$Layout$ID<Lhaven/res/ui/tt/q/qbuff/QBuff$Summary;>; <init> T Owner J(Lhaven/ItemInfo$Owner;Ljava/awt/image/BufferedImage;Ljava/lang/String;D)V Code LineNumberTable prepare (Lhaven/ItemInfo$Layout;)V shortvar Tip ()Lhaven/ItemInfo$Tip; <clinit> ()V 
SourceFile 
QBuff.java , U       ! " ' V W #haven/res/ui/tt/q/qbuff/QBuff$Table X Y Z [ \ haven/res/ui/tt/q/qbuff/QBuff$3 ] ^ , _ haven/res/ui/tt/q/qbuff/QBuff$1 , 8 haven/res/ui/tt/q/qbuff/QBuff$2 * ' haven/res/ui/tt/q/qbuff/QBuff ` haven/ItemInfo$Tip %haven/res/ui/tt/q/qbuff/QBuff$Summary #haven/res/ui/tt/q/qbuff/QBuff$QList &haven/res/ui/tt/q/qbuff/QBuff$Modifier haven/ItemInfo$Layout haven/ItemInfo$Layout$ID haven/ItemInfo$Owner (Lhaven/ItemInfo$Owner;)V intern 0(Lhaven/ItemInfo$Layout$ID;)Lhaven/ItemInfo$Tip; ql Ljava/util/List; java/util/List add (Ljava/lang/Object;)Z owner Lhaven/ItemInfo$Owner; 8(Lhaven/res/ui/tt/q/qbuff/QBuff;Lhaven/ItemInfo$Owner;)V haven/ItemInfo qbuff.cjava !                   !    " '  (    )  * '  (    +   , /  0   >     *+� *,� *-� *� �    1          
       2 3  0   1     +� � � � *� 	 W�    1   
    V  W  4 6  0   %     � 
Y**� � �    1       Z  7 8  0   1      � Y� � � Y� � �    1   
    = 
 Q  9    a    Z     	    	   	   	 
                   # M $ 	 % # &	 - M .	  M 5	codeentry     