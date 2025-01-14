Haven Resource 1 src �   Follow.java /* Preprocessed source code */
package haven.res.lib.synchro;

import haven.*;
import haven.Skeleton.*;

public interface Follow {
    public float ctime();
}

src �  Synchro.java /* Preprocessed source code */
package haven.res.lib.synchro;

import haven.*;
import haven.Skeleton.*;

public class Synchro extends ResPose.ResMod {
    public final Follow flw;

    public Synchro(ResPose pose, ModOwner owner, Skeleton skel, Follow flw) {
	pose.super(owner, skel);
	this.flw = flw;
    }

    public boolean tick(float dt) {
	aupdate(flw.ctime());
	return(true);
    }
}

src �  Synched.java /* Preprocessed source code */
package haven.res.lib.synchro;

import haven.*;
import haven.Skeleton.*;

public class Synched implements ModFactory {
    public PoseMod create(Skeleton skel, final ModOwner owner, Resource res, Message sdt) {
	final long tgtid = sdt.eom()?-1:sdt.uint32();
	final int olid = sdt.eom()?0:sdt.int32();
	Follow flw = new Follow() {
		Gob lg;
		TrackMod mod;

		Gob getgob() {
		    if(tgtid < 0) {
			if(!(owner instanceof Gob))
			    return(null);
			Following f = ((Gob)owner).getattr(Following.class);
			if(f == null)
			    return(null);
			return(f.tgt());
		    } else {
			return(owner.context(Glob.class).oc.getgob(tgtid));
		    }
		}

		TrackMod ftm(PoseMod[] mods) {
		    for(PoseMod mod : mods) {
			if(mod instanceof TrackMod)
			    return((TrackMod)mod);
		    }
		    return(null);
		}

		TrackMod sprmod(Sprite spr) {
		    if(spr instanceof SkelSprite)
			return(ftm(((SkelSprite)spr).mods));
		    return(null);
		}

		TrackMod mod(Gob gob) {
		    if(gob == null)
			return(null);
		    if(olid != 0) {
			Gob.Overlay ol = gob.findol(olid);
			if(ol == null)
			    return(null);
			Sprite spr = ol.spr;
			if(spr == null)
			    return(null);
			return(sprmod(spr));
		    } else {
			Drawable d = gob.getattr(Drawable.class);
			if(d instanceof ResDrawable) {
			    Sprite spr = ((ResDrawable)d).spr;
			    if(spr == null)
				return(null);
			    return(sprmod(spr));
			} else if(d instanceof Composite) {
			    Composite cd = (Composite)d;
			    if(cd.comp == null)
				return(null);
			    return(ftm(cd.comp.poses.mods));
			} else {
			    return(null);
			}
		    }
		}

		public float ctime() {
		    Gob gob = getgob();
		    if(gob != lg) {
			lg = null;
			mod = null;
		    }
		    if(mod == null) {
			if((mod = mod(gob)) == null)
			    return(0);
			lg = gob;
		    }
		    if(mod == null)
			return(0);
		    return(mod.time);
		}
	    };
	return(new Synchro(res.layer(ResPose.class), owner, skel, flw));
    }
}
code �   haven.res.lib.synchro.Follow ����   4 
   ctime ()F 
SourceFile Follow.java haven/res/lib/synchro/Follow java/lang/Object synchro.cjava                 	code y  haven.res.lib.synchro.Synchro ����   4 /
  
  	    
     flw Lhaven/res/lib/synchro/Follow; <init> " ResPose InnerClasses # ModOwner b(Lhaven/Skeleton$ResPose;Lhaven/Skeleton$ModOwner;Lhaven/Skeleton;Lhaven/res/lib/synchro/Follow;)V Code LineNumberTable tick (F)Z 
SourceFile Synchro.java $ % & 
 '  	 ( ) * + , haven/res/lib/synchro/Synchro haven/Skeleton$ResPose$ResMod ResMod - haven/Skeleton$ResPose haven/Skeleton$ModOwner java/lang/Object getClass ()Ljava/lang/Class; D(Lhaven/Skeleton$ResPose;Lhaven/Skeleton$ModOwner;Lhaven/Skeleton;)V haven/res/lib/synchro/Follow ctime ()F aupdate (F)V haven/Skeleton synchro.cjava !        	     
      3     *+Y� W,-� *� �                       +     **� �  � �       
            .       !  	  ! 	     code �
  haven.res.lib.synchro.Synched$1 ����   4 �	 ! P	 ! Q	 ! R	 ! S
 " T U V
  W
  X Y - Z	 
 [
 \ ] _ `	  a
 ! b
  c	 d e
 ! f g h	  e i	  j	 k l	 m a
 ! n	 ! o	 ! p
 ! q	  r s t u lg Lhaven/Gob; mod TrackMod InnerClasses Lhaven/Skeleton$TrackMod; 	val$tgtid J 	val$owner v ModOwner Lhaven/Skeleton$ModOwner; val$olid I this$0 Lhaven/res/lib/synchro/Synched; <init> =(Lhaven/res/lib/synchro/Synched;JLhaven/Skeleton$ModOwner;I)V Code LineNumberTable getgob ()Lhaven/Gob; StackMapTable V ftm w PoseMod 4([Lhaven/Skeleton$PoseMod;)Lhaven/Skeleton$TrackMod; x sprmod )(Lhaven/Sprite;)Lhaven/Skeleton$TrackMod; &(Lhaven/Gob;)Lhaven/Skeleton$TrackMod; z { g i ctime ()F U 
SourceFile Synched.java EnclosingMethod | } ~ 2 3 * + , / 0 1 4  	haven/Gob haven/Following � � � 9 
haven/Glob � � � � � 8 � � haven/Skeleton$TrackMod haven/SkelSprite � x < ? � � z � � A B haven/Drawable haven/ResDrawable haven/Composite � � � � � � 8 9 $ % & ) & C � � haven/res/lib/synchro/Synched$1 java/lang/Object haven/res/lib/synchro/Follow haven/Skeleton$ModOwner haven/Skeleton$PoseMod [Lhaven/Skeleton$PoseMod; Overlay haven/Gob$Overlay haven/Sprite haven/res/lib/synchro/Synched create b(Lhaven/Skeleton;Lhaven/Skeleton$ModOwner;Lhaven/Resource;Lhaven/Message;)Lhaven/Skeleton$PoseMod; ()V getattr "(Ljava/lang/Class;)Lhaven/GAttrib; tgt context %(Ljava/lang/Class;)Ljava/lang/Object; oc Lhaven/OCache; haven/OCache (J)Lhaven/Gob; haven/Skeleton mods findol (I)Lhaven/Gob$Overlay; spr Lhaven/Sprite; comp Lhaven/Composited; haven/Composited poses Poses Lhaven/Composited$Poses; haven/Composited$Poses time F synchro.cjava   ! "  #    $ %     & )   * +   , /   0 1   2 3      4 5  6   3     *+� * � *� *� *� �    7          8 9  6   �     I*� 	�� **� � � �*� � � � L+� �+� 	�*� 
�  � 
� *� � �    :    �  ;�  7   "    ! 	 "  #  $ % % ) & + ' 0 )   < ?  6   f     *+M,�>6� ,2:� � 	� ������    :    �  @�  7       .  /  0 " . ( 2   A B  6   >     +� � *+� � � ��    :     7       6  7  8   & C  6       x+� �*� � #+*� � M,� �,� N-� �*-� �+� � M,� � ,� � N-� �*-� �,� �  ,� N-� � �*-� � � � ��    :   ' �  D� 
 E� �  F E� �  G�  7   Z    <  =  >  ?  @  A  B ! C % D ' E - G 7 H > I F J J K L L R M Y N ^ O e P g Q v S  H I  6   �     C*� L+*� � *� *� *� � **+� Z� � �*+� *� � �*� �  �    :    �  J 7   .    Y  Z  [  \  ^  _ + ` - a 2 c 9 d ; e  K    � (   2   ^ '  - ^ .	 = ^ > !       d  y 	 m k �  M    N Ocode �  haven.res.lib.synchro.Synched ����   4 C
  
   ��������
  !
  " #
  $ % '
 ) *
 	 + , - . InnerClasses <init> ()V Code LineNumberTable create 0 ModOwner 1 PoseMod b(Lhaven/Skeleton;Lhaven/Skeleton$ModOwner;Lhaven/Resource;Lhaven/Message;)Lhaven/Skeleton$PoseMod; StackMapTable 
SourceFile Synched.java   2 3 4 5 6 7 8 haven/res/lib/synchro/Synched$1  9 haven/res/lib/synchro/Synchro : haven/Skeleton$ResPose ResPose ; < ?  @ haven/res/lib/synchro/Synched java/lang/Object haven/Skeleton$ModFactory 
ModFactory haven/Skeleton$ModOwner haven/Skeleton$PoseMod haven/Message eom ()Z uint32 ()J int32 ()I =(Lhaven/res/lib/synchro/Synched;JLhaven/Skeleton$ModOwner;I)V haven/Skeleton haven/Resource layer A Layer )(Ljava/lang/Class;)Lhaven/Resource$Layer; b(Lhaven/Skeleton$ResPose;Lhaven/Skeleton$ModOwner;Lhaven/Skeleton;Lhaven/res/lib/synchro/Follow;)V haven/Resource$Layer synchro.cjava !                    *� �                   �  	   L� � 	 � � 7� � � � 6� Y*,� :� 	Y-
� � 
,+� �        D� D           (  7 h      B    2          & 	  &  
 & ( 	  & /	 = ) >codeentry     