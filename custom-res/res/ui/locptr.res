Haven Resource 1 src   Pointer.java /* Preprocessed source code */
import haven.*;
import haven.render.*;
import java.awt.Color;
import static java.lang.Math.*;

/* >wdg: Pointer */
public class Pointer extends Widget {
    public static final BaseColor col = new BaseColor(new Color(241, 227, 157, 255));
    public Indir<Resource> icon;
    public Coord2d tc;
    public Coord lc;
    public long gobid = -1;
    public boolean click;
    private Tex licon;

    public Pointer(Indir<Resource> icon) {
	super(Coord.z);
	this.icon = icon;
    }

    public static Widget mkwidget(UI ui, Object... args) {
	int iconid = (Integer)args[0];
	Indir<Resource> icon = (iconid < 0) ? null : ui.sess.getres(iconid);
	return(new Pointer(icon));
    }
	
    public void presize() {
	resize(parent.sz);
    }

    protected void added() {
	presize();
	super.added();
    }

    private int signum(int a) {
	if(a < 0) return(-1);
	if(a > 0) return(1);
	return(0);
    }

    private void drawarrow(GOut g, Coord tc) {
	Coord hsz = sz.div(2);
	tc = tc.sub(hsz);
	if(tc.equals(Coord.z))
	    tc = new Coord(1, 1);
	double d = Coord.z.dist(tc);
	Coord sc = tc.mul((d - 25.0) / d);
	float ak = ((float)hsz.y) / ((float)hsz.x);
	if((abs(sc.x) > hsz.x) || (abs(sc.y) > hsz.y)) {
	    if(abs(sc.x) * ak < abs(sc.y)) {
		sc = new Coord((sc.x * hsz.y) / sc.y, hsz.y).mul(signum(sc.y));
	    } else {
		sc = new Coord(hsz.x, (sc.y * hsz.x) / sc.x).mul(signum(sc.x));
	    }
	}
	Coord ad = sc.sub(tc).norm(UI.scale(30.0));
	sc = sc.add(hsz);

	// gl.glEnable(GL2.GL_POLYGON_SMOOTH); XXXRENDER
	g.usestate(col);
	g.drawp(Model.Mode.TRIANGLES, new float[] {
		sc.x, sc.y,
		sc.x + ad.x - (ad.y / 3), sc.y + ad.y + (ad.x / 3),
		sc.x + ad.x + (ad.y / 3), sc.y + ad.y - (ad.x / 3),
	    });

	if(icon != null) {
	    try {
		if(licon == null)
		    licon = icon.get().layer(Resource.imgc).tex();
		g.aimage(licon, sc.add(ad), 0.5, 0.5);
	    } catch(Loading l) {
	    }
	}
	this.lc = sc.add(ad);
    }

    public void draw(GOut g) {
	this.lc = null;
	if(tc == null)
	    return;
	Gob gob = (gobid < 0) ? null : ui.sess.glob.oc.getgob(gobid);
	Coord3f sl;
	if(gob != null) {
	    try {
		sl = getparent(GameUI.class).map.screenxf(gob.getc());
	    } catch(Loading l) {
		return;
	    }
	} else {
	    sl = getparent(GameUI.class).map.screenxf(tc);
	}
	if(sl != null)
	    drawarrow(g, new Coord(sl));
    }

    public void update(Coord2d tc, long gobid) {
	this.tc = tc;
	this.gobid = gobid;
    }

    public boolean mousedown(Coord c, int button) {
	if(click && (lc != null)) {
	    if(lc.dist(c) < 20) {
		wdgmsg("click", button, ui.modflags());
		return(true);
	    }
	}
	return(super.mousedown(c, button));
    }

    public void uimsg(String name, Object... args) {
	if(name == "upd") {
	    if(args[0] == null)
		tc = null;
	    else
		tc = ((Coord)args[0]).mul(OCache.posres);
	    if(args[1] == null)
		gobid = -1;
	    else
		gobid = Utils.uint32((Integer)args[1]);
	} else if(name == "icon") {
	    int iconid = (Integer)args[0];
	    Indir<Resource> icon = (iconid < 0) ? null : ui.sess.getres(iconid);
	    this.icon = icon;
	    licon = null;
	} else if(name == "cl") {
	    click = ((Integer)args[0]) != 0;
	} else {
	    super.uimsg(name, args);
	}
    }

    public Object tooltip(Coord c, Widget prev) {
	if((lc != null) && (lc.dist(c) < 20))
	    return(tooltip);
	return(null);
    }
}
code �  Pointer ����   4G	  �
 X ���������	  �	  � �
  �	 � �
 � � �
  �	  �	 X �
  �
  �
 X �	  �
  �
  �
  � �
  �
  �@9      
  �	  �	  �
 � �
  �
  �@>      
 � �
  �
  �	  �
 � �	 � �
 � �	  � � � �	 , �
 , � �
 / �?�      
 � � �	  �	  �	  �	 � �	 � �
 � � �
  �	 ; �
 � �
 � �
 � �
  �
  �	  �@4       e �
  �
 � �
  �
 X � �	 � �
  �
 � � [ �
 X �	  � � �
 U �
 T � � col Lhaven/render/BaseColor; icon Lhaven/Indir; 	Signature Lhaven/Indir<Lhaven/Resource;>; tc Lhaven/Coord2d; lc Lhaven/Coord; gobid J click Z licon Lhaven/Tex; <init> (Lhaven/Indir;)V Code LineNumberTable "(Lhaven/Indir<Lhaven/Resource;>;)V mkwidget -(Lhaven/UI;[Ljava/lang/Object;)Lhaven/Widget; StackMapTable � presize ()V added signum (I)I 	drawarrow (Lhaven/GOut;Lhaven/Coord;)V � � draw (Lhaven/GOut;)V � � � � update (Lhaven/Coord2d;J)V 	mousedown (Lhaven/Coord;I)Z uimsg ((Ljava/lang/String;[Ljava/lang/Object;)V � � tooltip /(Lhaven/Coord;Lhaven/Widget;)Ljava/lang/Object; <clinit> 
SourceFile Pointer.java � b i � c d [ \ java/lang/Integer � � � � � � � � Pointer i j � � � b � � r s t s � � � � � � haven/Coord i 	 v u v �
 � Y Z � g h � haven/Resource haven/Resource$Image Image InnerClasses !" haven/Loading a b _ `#$%&'()*+, haven/GameUI-./0 �1234546 i7 w x e f java/lang/Object89: �; � � � upd< `=>?@ cl � � �A haven/render/BaseColor java/awt/Color iB iC haven/Widget haven/Indir 	haven/Gob 
haven/GOut haven/Coord3f java/lang/String [Ljava/lang/Object; z (Lhaven/Coord;)V intValue ()I haven/UI sess Lhaven/Session; haven/Session getres (I)Lhaven/Indir; parent Lhaven/Widget; sz resize div (I)Lhaven/Coord; sub (Lhaven/Coord;)Lhaven/Coord; equals (Ljava/lang/Object;)Z (II)V dist (Lhaven/Coord;)D mul (D)Lhaven/Coord; y I x java/lang/Math abs scale (D)D norm add usestate (Lhaven/render/State;)VD haven/render/Model$Mode Mode 	TRIANGLES Lhaven/render/Model$Mode; drawp (Lhaven/render/Model$Mode;[F)V get ()Ljava/lang/Object; imgc Ljava/lang/Class; layerE Layer )(Ljava/lang/Class;)Lhaven/Resource$Layer; tex ()Lhaven/Tex; aimage (Lhaven/Tex;Lhaven/Coord;DD)V ui 
Lhaven/UI; glob Lhaven/Glob; 
haven/Glob oc Lhaven/OCache; haven/OCache getgob (J)Lhaven/Gob; 	getparent !(Ljava/lang/Class;)Lhaven/Widget; map Lhaven/MapView; getc ()Lhaven/Coord3f; haven/MapView screenxf  (Lhaven/Coord3f;)Lhaven/Coord3f;  (Lhaven/Coord2d;)Lhaven/Coord3f; (Lhaven/Coord3f;)V valueOf (I)Ljava/lang/Integer; modflags wdgmsg posres  (Lhaven/Coord2d;)Lhaven/Coord2d; haven/Utils uint32 (I)J Ljava/lang/Object; (IIII)V (Ljava/awt/Color;)V haven/render/Model haven/Resource$Layer locptr.cjava !  X     Y Z    [ \  ]    ^  _ `    a b    c d    e f    g h     i j  k   8     *� � * � *+� �    l              ]    m � n o  k   T     $+2� � =� � *� 	� 
N� Y-� �    p   
 � G q l        
     r s  k   (     **� � � �    l   
        t s  k   )     	*� *� �    l          !  "  u v  k   8     � �� ��    p     l       %  &  '  w x  k  Z  
  �*� � N,-� M,� � � � Y� M� ,� 9, go� :-� �-� �n8� � -� � � � -� � q� � �j� � ��� /� Y� -� h� l-� � *� � �  :� ,� Y-� � -� h� l� *� � �  :,�  !� #� $:-� %:+� &� '+� (�Y� �QY� �QY� � `� ld�QY� � `� l`�QY� � `� l`�QY� � `� ld�Q� )*� � @*� *� **� � + � ,� -� .� /� 0� *+*� *� % 1 1� 3� :	*� %� 5� t�� 4  p    � # y� B y� D(� � yW z l   ^    + 	 ,  -  . # / , 0 ; 1 H 2 f 3  4 � 6 � 9 � : � = � >m Dt F{ G� H� J� I� L� M  { |  k   �     s*� 5*� 6� �*� 	�� � *� 7� 	� 8� 9*� � :M,� *;� <� ;� =,� >� ?N� :�*;� <� ;� =*� 6� @N-� *+� Y-� A� B�  3 G J 4  p   # S }�   ~  }  z�  � l   6    P  Q  R  S / U 3 W G Z J X L Y M \ a ^ e _ r `  � �  k   +     *+� 6* � �    l       c  d 
 e  � �  k   u     D*� C� 9*� 5� 2*� 5+�  D�� #*F� GY� HSY*� 7� I� HS� J�*+� K�    p    = l       h  i  j ; k = n � � �  k  $     �+L� D,2� *� 6� *,2� � M� N� 6,2� * � � m*,2� � � O� � Z+P� 0,2� � >� � *� 7� 	� 
:*� *� *� '+Q� *,2� � � � � C� 	*+,� R�    p   + � J q� V ~�    ~ � �  ~ l   B    r  s  t  v $ w * x 4 z G { M | W } l ~ r  w � � � � � � �  � �  k   F     *� 5� *� 5+�  D�� *� S��    p     l       �  �  �  � s  k   6      � TY� UY � � � �� V� W� &�    l         �   F �     / , �  �@ ,codeentry    wdg Pointer   